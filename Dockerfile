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

# Stage 3: Add PostgreSQL
FROM postgres:15 AS postgres
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_DB=EasyDB

# Copy database initialization script
COPY Tables/InitializeTables.sql /docker-entrypoint-initdb.d/

# Expose the PostgreSQL port
EXPOSE 5432

# Stage 4: Final container to run backend and PostgreSQL
FROM node:14 AS final
WORKDIR /app
COPY --from=backend-builder /app ./

# Include a mechanism to run PostgreSQL and Node.js together
# Use a simple script to start PostgreSQL in the background
RUN apt-get update && apt-get install -y postgresql postgresql-contrib

COPY --from=postgres /usr/local/bin /usr/local/bin
COPY --from=postgres /usr/lib/postgresql /usr/lib/postgresql
COPY --from=postgres /etc/postgresql /etc/postgresql

# Expose backend and PostgreSQL ports
EXPOSE 5000 5432

# Start both services
CMD ["sh", "-c", "pg_ctlcluster 11 main start && npm start"]
