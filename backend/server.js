require("dotenv").config();

const express = require("express");
const http = require("http");
const cors = require("cors");
const { Server } = require("socket.io");

const connectDB = require("./config/db");
const taskRoutes = require("./routes/taskRoutes");

const teamRoutes = require("./routes/teamRoutes");

// ─── App & Server Setup ─────────────────────────────────────────────────────

const app = express();
const httpServer = http.createServer(app); 

// ─── Socket.io ──────────────────────────────────────────────────────────────

const io = new Server(httpServer, {
  cors: {
    origin: "*",      
    methods: ["GET", "POST", "PATCH", "DELETE"],
  },
});

app.set("io", io);

io.on("connection", (socket) => {
  console.log(`🔌  Socket connected:    ${socket.id}`);

  // Join a team-specific room for targeted updates
  socket.on("joinTeam", (teamId) => {
    socket.join(`team_${teamId}`);
    console.log(`👥  Socket ${socket.id} joined team_${teamId}`);
  });

  socket.on("disconnect", () => {
    console.log(`🔌  Socket disconnected: ${socket.id}`);
  });
});

// ─── Middleware ─────────────────────────────────────────────────────────────

app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PATCH", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

app.use(express.json());

// ─── Health Check ────────────────────────────────────────────────────────────

app.get("/health", (_req, res) => {
  res.status(200).json({ status: "ok", timestamp: new Date().toISOString() });
});

// ─── API Routes ──────────────────────────────────────────────────────────────

app.use("/api/tasks", taskRoutes);
app.use("/api/teams", teamRoutes);

// ─── 404 Catch-All ───────────────────────────────────────────────────────────

app.use((_req, res) => {
  res.status(404).json({ success: false, message: "Route not found" });
});

// ─── Global Error Handler ────────────────────────────────────────────────────

// eslint-disable-next-line no-unused-vars
app.use((err, _req, res, _next) => {
  // body-parser sets err.type = 'entity.parse.failed' for malformed JSON bodies
  if (err.type === "entity.parse.failed" || err instanceof SyntaxError) {
    return res.status(400).json({
      success: false,
      message: "Invalid JSON — please check your request body syntax",
    });
  }

  console.error("Unhandled error:", err.stack);
  res.status(500).json({ success: false, message: "Internal server error" });
});

// ─── Bootstrap ───────────────────────────────────────────────────────────────

const PORT = process.env.PORT || 8000;

const start = async () => {
  await connectDB(); // Connect to MongoDB before accepting traffic

  httpServer.listen(PORT, () => {
    console.log(`🚀  Server running on http://localhost:${PORT}`);
    console.log(`📡  Socket.io listening on port ${PORT}`);
  });
};

start();

