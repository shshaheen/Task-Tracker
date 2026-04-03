const mongoose = require("mongoose");

/**
 * Connects to MongoDB using the URI defined in environment variables.
 * Exits the process on failure so the server never starts in a broken state.
 */
const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI, {
      // Mongoose 7+ no longer needs these flags, but left explicit for clarity
    });

    console.log(`✅  MongoDB connected: ${conn.connection.host}`);
  } catch (error) {
    console.error(`❌  MongoDB connection error: ${error.message}`);
    process.exit(1); // Exit with failure – no point running without a DB
  }
};

module.exports = connectDB;

