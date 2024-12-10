# Use the official Node.js image from the Docker Hub
FROM node:14 AS app

# Install git
RUN apt-get update && apt-get install -y git

# Clone the repository
RUN git clone https://github.com/Orski174/EasyDB.git /EasyDB

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
EXPOSE 3000

# Start the application and log the output
CMD ["sh", "-c", "serve -s build &> /var/log/serve.log"]