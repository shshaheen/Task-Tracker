const mongoose = require("mongoose");

const VALID_STATUSES = ["todo", "inprogress", "done"];
const VALID_PRIORITIES = ["low", "medium", "high"];

const taskSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: [true, "Task title is required"],
      trim: true,
      maxlength: [200, "Title cannot exceed 200 characters"],
    },
    description: {
      type: String,
      trim: true,
      maxlength: [1000, "Description cannot exceed 1000 characters"],
    },
    status: {
      type: String,
      enum: {
        values: VALID_STATUSES,
        message: `Status must be one of: ${VALID_STATUSES.join(", ")}`,
      },
      default: "todo",
    },
    priority: {
      type: String,
      enum: {
        values: VALID_PRIORITIES,
        message: `Priority must be one of: ${VALID_PRIORITIES.join(", ")}`,
      },
      default: "medium",
    },
    teamId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Team",
      required: [true, "Team ID is required"],
    },
    createdBy: {
      type: String,
    },
    assignedTo: {
      type: String,
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

