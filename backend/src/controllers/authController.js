const { User, Role } = require('../models');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { check, validationResult } = require('express-validator');

// Register User with validation
exports.register = [
  // Validation middleware
  check('email').isEmail().withMessage('Valid email is required'),
  check('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters long'),
  check('first_name').notEmpty().withMessage('First name is required'),
  check('last_name').notEmpty().withMessage('Last name is required'),
  check('role_name').notEmpty().withMessage('Role name is required'),

  // Registration logic
  async (req, res) => {
    // Handle validation errors
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    try {
      const { email, password, first_name, last_name, role_name } = req.body;

      // Check if the user already exists
      let user = await User.findOne({ where: { email } });
      if (user) return res.status(400).json({ message: 'User already exists' });

      // Find role
      const role = await Role.findOne({ where: { role_name } });
      if (!role) return res.status(400).json({ message: 'Invalid role' });

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
  },
];

// Login User
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user
    const user = await User.findOne({ where: { email } });
    if (!user) return res.status(400).json({ message: 'Invalid credentials' });

    // Check password
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) return res.status(400).json({ message: 'Invalid credentials' });

    // Generate token
    const token = jwt.sign(
      { user_id: user.user_id, role_id: user.role_id },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    res.json({ token });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
exports.login = async (req, res, next) => {
  try {
    // Your login logic...
  } catch (err) {
    next(err);
  }
};