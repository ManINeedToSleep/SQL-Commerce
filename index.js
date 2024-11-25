import sequelize from './db.js'; // Import the Sequelize connection
import Student from './student.js'; // Import the Student model

const main = async () => {
    try {
        // Test the connection
        await sequelize.authenticate();
        console.log('Database connected successfully.');

        // Sync the database (creates tables if they don't exist)
        await sequelize.sync({ force: false });
        console.log('Database synced.');

        // Example: Create a new student
        const newStudent = await Student.create({ name: 'John Doe', age: 18, class: '12-A' });
        console.log('New student created:', newStudent.toJSON());
    } catch (error) {
        console.error('Error connecting to the database:', error);
    } finally {
        // Close the connection
        await sequelize.close();
    }
};

// Run the main function
main();
