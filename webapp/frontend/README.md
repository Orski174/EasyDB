
# Web Application Configuration and Launch Instructions

 This documentation provides step-by-step instructions on how to configure and launch the web application.

## Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher) or yarn (v1.22 or higher)
- PostgreSQL (v12 or higher)

### Backend Configuration

1. **Install Dependencies**:
    Navigate to the `webapp/backend` directory and install the required dependencies by running:

    ```bash
    cd webapp/backend
    npm install
    ```

2. **Database Configuration**:
    Ensure PostgreSQL is running and create a database named `EasyDB`. Update the `Pool` configuration in `server.js` with your PostgreSQL credentials if necessary.

3. **Launch Backend Server**:
    Start the backend server by running:

    ```bash
    npm start
    ```

    The server will run on `http://localhost:5000`.

### Frontend Configuration

1. **Install Dependencies**:
    Navigate to the `webapp` directory and install the required dependencies by running:

    ```bash
    cd webapp
    npm install
    ```

2. **Configure Axios**:
    Axios is used for making HTTP requests to the backend server. Ensure the base URL in your axios requests matches the backend server URL (`http://localhost:5000`).

3. **Launch React Application**:
    Start the React application by running:

    ```bash
    npm start
    ```

    The application will run on `http://localhost:3000`.

### Accessing the Application

- **View Database**:
   Navigate to `http://localhost:3000/view-db` to view the database tables. Use the dropdown menu to select and view different tables.

- **Interact with Database**:
   Navigate to `http://localhost:3000/interact-db` to interact with the database.

### Additional Notes

- Ensure both the backend server and the React application are running simultaneously.
- If you encounter any issues, check the console logs for error messages and ensure all dependencies are correctly installed.
