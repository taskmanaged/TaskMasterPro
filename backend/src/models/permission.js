// src/models/permission.js
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Permission = sequelize.define(
  'Permission',
  {
    permission_id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true,
    },
    permission_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    tableName: 'permissions',
    timestamps: true,
  }
);

module.exports = Permission;
