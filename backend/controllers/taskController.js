const Task = require("../models/taskModel");

// ─── Helpers ────────────────────────────────────────────────────────────────

/**
 * Retrieve the Socket.io instance attached to the request by server.js.
 * Throws a descriptive error if it is missing (guards against mis-configuration).
 */
const getIO = (req) => {
  const io = req.app.get("io");
  if (!io) throw new Error("Socket.io instance not attached to app");
  return io;
};

// ─── Controllers ────────────────────────────────────────────────────────────

/**
 * GET /api/tasks
 * Returns all tasks sorted by creation date (newest first).
 */
const getAllTasks = async (req, res) => {
  try {
    const tasks = await Task.find().sort({ createdAt: -1 });
    res.status(200).json({ success: true, count: tasks.length, data: tasks });
  } catch (error) {
    console.error("getAllTasks error:", error.message);
    res.status(500).json({ success: false, message: "Failed to fetch tasks" });
  }
};

/**
 * POST /api/tasks
 * Creates a new task and broadcasts the "taskCreated" event to all clients.
 */
const createTask = async (req, res) => {
  try {
    const { title, status } = req.body;

    if (!title || !title.trim()) {
      return res
        .status(400)
        .json({ success: false, message: "Title is required" });
    }

    const task = await Task.create({ title: title.trim(), status });

    // Broadcast to every connected Socket.io client
    getIO(req).emit("taskCreated", task);

    res.status(201).json({ success: true, data: task });
  } catch (error) {
    console.error("createTask error:", error.message);

    // Mongoose validation errors (e.g. invalid status enum)
    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((e) => e.message);
      return res.status(400).json({ success: false, message: messages.join(", ") });
    }

    res.status(500).json({ success: false, message: "Failed to create task" });
  }
};

/**
 * PATCH /api/tasks/:id
 * Updates a task's status and broadcasts the "taskUpdated" event to all clients.
 */
const updateTask = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!status) {
      return res
        .status(400)
        .json({ success: false, message: "Status is required" });
    }

    const task = await Task.findByIdAndUpdate(
      id,
      { status },
      {
        new: true,          // return the updated document
        runValidators: true // enforce schema enum validation
      }
    );

    if (!task) {
      return res
        .status(404)
        .json({ success: false, message: "Task not found" });
    }

    getIO(req).emit("taskUpdated", task);

    res.status(200).json({ success: true, data: task });
  } catch (error) {
    console.error("updateTask error:", error.message);

    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((e) => e.message);
      return res.status(400).json({ success: false, message: messages.join(", ") });
    }

    if (error.name === "CastError") {
      return res.status(400).json({ success: false, message: "Invalid task ID" });
    }

    res.status(500).json({ success: false, message: "Failed to update task" });
  }
};

/**
 * DELETE /api/tasks/:id
 * Deletes a task and broadcasts the "taskDeleted" event to all clients.
 */
const deleteTask = async (req, res) => {
  try {
    const { id } = req.params;

    const task = await Task.findByIdAndDelete(id);

    if (!task) {
      return res
        .status(404)
        .json({ success: false, message: "Task not found" });
    }

    // Send the deleted task's ID so clients can remove it from their local state
    getIO(req).emit("taskDeleted", { id: task._id });

    res.status(200).json({ success: true, data: { id: task._id } });
  } catch (error) {
    console.error("deleteTask error:", error.message);

    if (error.name === "CastError") {
      return res.status(400).json({ success: false, message: "Invalid task ID" });
    }

    res.status(500).json({ success: false, message: "Failed to delete task" });
  }
};

module.exports = { getAllTasks, createTask, updateTask, deleteTask };

