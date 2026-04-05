const Team = require("../models/teamModel");

// Get all teams
exports.getAllTeams = async (req, res) => {
  try {
    const teams = await Team.find().sort({ createdAt: -1 });
    res.status(200).json({
      status: "success",
      results: teams.length,
      data: teams,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: error.message,
    });
  }
};

// Create a new team
exports.createTeam = async (req, res) => {
  try {
    const { name, description } = req.body;

    const existingTeam = await Team.findOne({ name });
    if (existingTeam) {
      return res.status(400).json({
        success: false,
        message: "Team with this name already exists",
      });
    }

    const newTeam = await Team.create({ name, description });

    res.status(201).json({
      status: "success",
      data: newTeam,
    });
  } catch (error) {
    res.status(400).json({
      status: "error",
      message: error.message,
    });
  }
};
