const { Sequelize, DataTypes } = require('sequelize');
require('dotenv').config();

const sequelize = new Sequelize(
    process.env.DB_NAME,
    process.env.DB_USER,
    process.env.DB_PASSWORD,
    {
        host: process.env.DB_HOST,
        dialect: 'mysql',
        port: process.env.DB_PORT,
    }
);


const Student = sequelize.define('Student', {
    name: { type: DataTypes.STRING, allowNull: false },
    age: { type: DataTypes.INTEGER, allowNull: false },
    class: { type: DataTypes.STRING, allowNull: true }
});


const testConnection = async () => {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        await sequelize.sync();
        console.log('Database synchronized successfully.');

        const newStudent = await Student.create({
            name: 'John Doe',
            age: 20,
            class: 'Physics',
        });
        console.log('Student created:', newStudent.toJSON());

        } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
};

testConnection();


