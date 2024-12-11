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
COPY --from=frontend-builder /app/build ./build

# Stage 3: Final container to run backend
FROM node:14 AS final
WORKDIR /app
COPY --from=backend-builder /app ./

# Expose backend ports
EXPOSE 5000

# Start both services
CMD ["npm", "start"]
