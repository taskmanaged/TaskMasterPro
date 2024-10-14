// src/models/index.js

// Import Sequelize instance
const sequelize = require('../config/database');

// Import models
const User = require('./user');
const Role = require('./role');
const Permission = require('./permission');
const Task = require('./task');

// Define associations between models

// Many-to-Many between Role and Permission through 'RolePermissions'
Role.belongsToMany(Permission, { through: 'RolePermissions' });
Permission.belongsToMany(Role, { through: 'RolePermissions' });

// One-to-Many between Role and User
User.belongsTo(Role, { foreignKey: 'role_id' });
Role.hasMany(User, { foreignKey: 'role_id' });

// Many-to-Many between User and Task through 'UserTasks'
User.belongsToMany(Task, { through: 'UserTasks', foreignKey: 'user_id' });
Task.belongsToMany(User, { through: 'UserTasks', foreignKey: 'task_id' });

// Sync models with the database

// Option 1: Sync with `alter: true` to automatically alter the tables to match the models (non-destructive)
sequelize.sync({ alter: true })
  .then(() => {
    console.log('Database synced (with alter).');
  })
  .catch((err) => {
    console.error('Error syncing database:', err);
  });

// Option 2: Use `force: true` if you need to drop tables and recreate them (destructive)
// Uncomment this block if you want to force sync
/*
sequelize.sync({ force: true })
  .then(() => {
    console.log('Database synced (with force).');
  })
  .catch((err) => {
    console.error('Error syncing database:', err);
  });
*/

// Export all models and the Sequelize instance
module.exports = {
  sequelize,
  User,
  Role,
  Permission,
  Task,
};
