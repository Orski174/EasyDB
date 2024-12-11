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

# Copy the built frontend to the backend's public directory
COPY --from=frontend-builder /app/build ./public

# Stage 3: Final stage with Node.js backend and PostgreSQL
FROM ubuntu:20.04 AS final
WORKDIR /app

# Install dependencies for PostgreSQL and Node.js
RUN apt-get update && apt-get install -y \
    postgresql postgresql-contrib nodejs npm && \
    apt-get clean

# Set up environment variables for PostgreSQL
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_DB=EasyDB

# Copy Node.js backend from the previous stage
COPY --from=backend-builder /app ./

# Add initialization script for PostgreSQL
COPY Tables/InitializeTables.sql /docker-entrypoint-initdb.d/

# Expose necessary ports
EXPOSE 5000 5432

# Start both PostgreSQL and Node.js
CMD ["sh", "-c", "/etc/init.d/postgresql start && npm start"]
