# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest AS postgres

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_DB=EasyDB

# Create a new stage for the application
FROM node:14 AS app

# Install git
RUN apt-get update && apt-get install -y git

# Clone the repository
RUN git clone https://github.com/Orski174/EasyDB.git /EasyDB

# Copy the InitializeTables.sql script to the PostgreSQL container
COPY Tables/InitializeTables.sql /docker-entrypoint-initdb.d

# Set the working directory to /EasyDB/webapp
WORKDIR /EasyDB/webapp

# Install dependencies and build the React application
RUN npm install
RUN npm run build
RUN npm install -g serve

# Set the working directory to /EasyDB/webapp/backend
WORKDIR /EasyDB/webapp/backend

# Install backend dependencies and start the server
RUN npm install

# Expose the port the app runs on
EXPOSE 5000

# Start the application and log the output
CMD ["sh", "-c", "serve -s build &> /var/log/serve.log & npm start"]