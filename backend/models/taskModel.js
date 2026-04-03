const mongoose = require("mongoose");

const VALID_STATUSES = ["todo", "inprogress", "done"];

const taskSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, "Task title is required"],
      trim: true,
      maxlength: [200, "Title cannot exceed 200 characters"],
    },
    status: {
      type: String,
      enum: {
        values: VALID_STATUSES,
        message: `Status must be one of: ${VALID_STATUSES.join(", ")}`,
      },
      default: "todo",
    },
  },
  {
    // Automatically manages createdAt and updatedAt fields
    timestamps: true,
    // Remove __v from API responses
    versionKey: false,
  }
);

const Task = mongoose.model("Task", taskSchema);

module.exports = Task;

