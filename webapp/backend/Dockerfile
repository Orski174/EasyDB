# Use the official PostgreSQL image from the Docker Hub
FROM postgres:latest AS postgres

# Set environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_DB=EasyDB

# Install git
RUN apt-get update && apt-get install -y git

# Clone the EasyDB repository
RUN git clone https://github.com/Orski174/EasyDB.git /EasyDB

# Copy the InitializeTables.sql script to the PostgreSQL container
COPY --from=postgres /EasyDB/Tables/InitializeTables.sql /docker-entrypoint-initdb.d

# Create a new stage for the application
FROM node:14 AS app

# Set the working directory to /EasyDB/webapp/backend
WORKDIR /EasyDB/webapp/backend

# Install backend dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Start the application and log the output
CMD ["npm", "start"]