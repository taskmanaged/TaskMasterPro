// src/index.js

// Import required modules
const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
require('dotenv').config(); // Load environment variables from .env file

// Initialize the Express app
const app = express();

// Import route handlers
const authRoutes = require('./routes/auth');
const taskRoutes = require('./routes/task');

// Middleware setup
app.use(helmet()); // Adds security headers to responses
app.use(cors());   // Enable Cross-Origin Resource Sharing
app.use(express.json()); // Parse incoming JSON requests

// Request logger middleware to log all incoming requests
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
});

// Define API routes
app.use('/api/auth', authRoutes); // Routes for authentication
app.use('/api/tasks', taskRoutes); // Routes for task management

// Test route for API health check
app.get('/api/test', (req, res) => {
  res.json({ message: 'API is working' });
});

// Global error handling middleware for uncaught errors
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({ error: err.message });
});

// Set the port from environment variables or use a default port
const PORT = process.env.PORT || 5000;

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
