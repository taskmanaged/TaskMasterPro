// src/routes/task.js
const express = require('express');
const router = express.Router();
const {
  createTask,
  getTasks,
  updateTask,
  deleteTask,
} = require('../controllers/taskController');
const {
  verifyToken,
  checkPermission,
} = require('../middleware/authMiddleware');

router.post(
  '/',
  verifyToken,
  checkPermission('AssignTasks'),
  createTask
);
router.get('/', verifyToken, getTasks);
router.put(
  '/:taskId',
  verifyToken,
  checkPermission('UpdateTask'),
  updateTask
);
router.delete(
  '/:taskId',
  verifyToken,
  checkPermission('DeleteTask'),
  deleteTask
);

module.exports = router;