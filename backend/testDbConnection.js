// testDbConnection.js
const sequelize = require('./src/config/database');

sequelize.authenticate()
  .then(() => {
    console.log('Database connection has been established successfully.');
    process.exit(0);
  })
  .catch((err) => {
    console.error('Unable to connect to the database:', err);
    process.exit(1);
  });