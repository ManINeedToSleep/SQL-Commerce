import { DataTypes } from 'sequelize';
import sequelize from './db.js'; // Import the database connection

// Define and export the Student model
const Student = sequelize.define('Student', {
    name: { type: DataTypes.STRING, allowNull: false },
    age: { type: DataTypes.INTEGER, allowNull: false },
    class: { type: DataTypes.STRING, allowNull: true },
});

export default Student;
