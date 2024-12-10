# Use a multi-stage build for the React frontend and Node.js backend

# Stage 1: Build React frontend
FROM node:14 AS frontend-builder
WORKDIR /app
COPY webapp/frontend/package*.json ./
RUN npm install
COPY webapp/frontend/ ./
RUN npm run build

# Stage 2: Build Node.js backend
FROM node:14 AS backend-builder
WORKDIR /app
COPY webapp/backend/package*.json ./
RUN npm install
COPY webapp/backend/ ./
# Install PostgreSQL client
RUN apt-get update && apt-get install -y postgresql-client

# Initialize the PostgreSQL database
COPY Tables/InitializeTables.sql /docker-entrypoint-initdb.d/

# Copy the built frontend to the backend's public directory
COPY --from=frontend-builder /app/build ./public

# Expose the port the backend server runs on
EXPOSE 5000

# Start the backend server
CMD ["npm", "start"]