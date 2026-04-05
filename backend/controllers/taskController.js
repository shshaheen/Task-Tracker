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
 * Supports filtering by teamId: GET /api/tasks?teamId=...
 */
const getAllTasks = async (req, res) => {
  try {
    const { teamId } = req.query;
    const filter = teamId ? { teamId } : {};
    
    const tasks = await Task.find(filter).sort({ createdAt: -1 });
    res.status(200).json({ success: true, count: tasks.length, data: tasks });
  } catch (error) {
    console.error("getAllTasks error:", error.message);
    res.status(500).json({ success: false, message: "Failed to fetch tasks" });
  }
};

/**
 * POST /api/tasks
 * Creates a new task and broadcasts the "taskCreated" event.
 */
const createTask = async (req, res) => {
  try {
    const { title, description, priority, status, teamId, createdBy, assignedTo } = req.body;

    if (!title || !title.trim()) {
      return res.status(400).json({ success: false, message: "Title is required" });
    }
    if (!teamId) {
      return res.status(400).json({ success: false, message: "Team ID is required" });
    }

    const task = await Task.create({
      title: title.trim(),
      description,
      priority,
      status,
      teamId,
      createdBy,
      assignedTo
    });

    const io = getIO(req);
    // Broadcast to the specifically affected team room
    io.to(`team_${teamId}`).emit("taskCreated", task);
    // Also broadcast globally for general UI updates if needed
    io.emit("taskCreated", task);

    res.status(201).json({ success: true, data: task });
  } catch (error) {
    console.error("createTask error:", error.message);

    if (error.name === "ValidationError") {
      const messages = Object.values(error.errors).map((e) => e.message);
      return res.status(400).json({ success: false, message: messages.join(", ") });
    }

    res.status(500).json({ success: false, message: "Failed to create task" });
  }
};

/**
 * PATCH /api/tasks/:id
 * Updates a task and broadcasts the "taskUpdated" event.
 */
const updateTask = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, description, status, priority, teamId, assignedTo } = req.body;

    const updateData = {};
    if (title !== undefined) updateData.title = title.trim();
    if (description !== undefined) updateData.description = description ? description.trim() : "";
    if (status !== undefined) updateData.status = status;
    if (priority !== undefined) updateData.priority = priority;
    if (teamId !== undefined) updateData.teamId = teamId;
    if (assignedTo !== undefined) updateData.assignedTo = assignedTo;

    const task = await Task.findByIdAndUpdate(
      id,
      updateData,
      { new: true, runValidators: true }
    );

    if (!task) {
      return res.status(404).json({ success: false, message: "Task not found" });
    }

    const io = getIO(req);
    io.to(`team_${task.teamId}`).emit("taskUpdated", task);
    io.emit("taskUpdated", task);

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
 * Deletes a task and broadcasts the "taskDeleted" event.
 */
const deleteTask = async (req, res) => {
  try {
    const { id } = req.params;

    const task = await Task.findByIdAndDelete(id);

    if (!task) {
      return res.status(404).json({ success: false, message: "Task not found" });
    }

    const io = getIO(req);
    io.to(`team_${task.teamId}`).emit("taskDeleted", { id: task._id });
    io.emit("taskDeleted", { id: task._id });

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

