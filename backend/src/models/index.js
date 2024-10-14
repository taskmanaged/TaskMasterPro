// src/models/index.js
const sequelize = require('../config/database');
const User = require('./user');
const Role = require('./role');
const Permission = require('./permission');
const Task = require('./task');

// Associations
Role.belongsToMany(Permission, { through: 'RolePermissions' });
Permission.belongsToMany(Role, { through: 'RolePermissions' });

User.belongsTo(Role, { foreignKey: 'role_id' });
Role.hasMany(User, { foreignKey: 'role_id' });

User.belongsToMany(Task, { through: 'UserTasks', foreignKey: 'user_id' });
Task.belongsToMany(User, { through: 'UserTasks', foreignKey: 'task_id' });

// Sync models
sequelize.sync({ alter: true });

module.exports = {
  sequelize,
  User,
  Role,
  Permission,
  Task,
};