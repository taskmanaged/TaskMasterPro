// src/middleware/authMiddleware.js
const jwt = require('jsonwebtoken');
const { User, Role, Permission } = require('../models');

exports.verifyToken = (req, res, next) => {
  const token = req.headers['authorization'];

  if (!token)
    return res.status(403).json({ message: 'No token provided' });

  jwt.verify(token, process.env.JWT_SECRET, async (err, decoded) => {
    if (err)
      return res.status(500).json({ message: 'Failed to authenticate token' });

    // Attach user to request
    req.user = decoded;
    next();
  });
};

exports.checkPermission = (permissionName) => {
  return async (req, res, next) => {
    const { user_id, role_id } = req.user;

    // Get role and permissions
    const role = await Role.findByPk(role_id, {
      include: [Permission],
    });

    const permissions = role.Permissions.map((p) => p.permission_name);

    if (!permissions.includes(permissionName))
      return res.status(403).json({ message: 'Access denied' });

    next();
  };
};