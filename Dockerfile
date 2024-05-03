# Base image with Node.js
FROM node:16 as build-stage

# Set the working directory in the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the project
COPY . .

# Build the project
RUN npm run build

# Use a lightweight web server to serve the built React app
FROM nginx:stable

# Copy the built files to the nginx public folder
COPY --from=build-stage /app/build /usr/share/nginx/html

# Expose port 80 and start nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
