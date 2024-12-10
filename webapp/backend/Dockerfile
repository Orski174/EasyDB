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

# Use the official Node.js image from the Docker Hub
FROM node:14

# Set the working directory to /EasyDB/webapp/backend
WORKDIR /EasyDB/webapp/backend

# Copy package.json and package-lock.json
COPY package*.json ./

# Install backend dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Start the application and log the output
CMD ["npm", "start"]