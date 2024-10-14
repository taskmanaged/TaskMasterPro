// src/controllers/authController.js
const { User, Role } = require('../models');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { check, validationResult } = require('express-validator');

// User Registration
exports.register = [
  // Validation middleware
  check('email').isEmail().withMessage('Valid email is required'),
  check('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters long'),
  check('first_name').notEmpty().withMessage('First name is required'),
  check('last_name').notEmpty().withMessage('Last name is required'),
  check('role_name').notEmpty().withMessage('Role name is required'),
  
  // Registration logic
  async (req, res) => {
    try {
      // Handle validation errors
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const { email, password, first_name, last_name, role_name } = req.body;

      // Check if the user already exists
      let user = await User.findOne({ where: { email } });
      if (user) {
        return res.status(400).json({ message: 'User already exists' });
      }

      // Find role
      const role = await Role.findOne({ where: { role_name } });
      if (!role) {
        return res.status(400).json({ message: 'Invalid role' });
      }

      // Hash the password
      const password_hash = await bcrypt.hash(password, 10);

      // Create the new user
      user = await User.create({
        email,
        password_hash,
        first_name,
        last_name,
        role_id: role.role_id,
      });

      res.status(201).json({ message: 'User registered successfully' });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
];

// User Login
exports.login = [
  // Validation middleware for login
  check('email').isEmail().withMessage('Valid email is required'),
  check('password').notEmpty().withMessage('Password is required'),

  // Login logic
  async (req, res) => {
    try {
      // Handle validation errors
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });
      }

      const { email, password } = req.body;

      // Find user by email
      const user = await User.findOne({ where: { email } });
      if (!user) {
        return res.status(400).json({ message: 'Invalid credentials' });
      }

      // Compare provided password with the stored hash
      const isMatch = await bcrypt.compare(password, user.password_hash);
      if (!isMatch) {
        return res.status(400).json({ message: 'Invalid credentials' });
      }

      // Generate a JWT token
      const
