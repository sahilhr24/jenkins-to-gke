# Use the official Nginx image as the base image
FROM nginx:latest

# Copy custom HTML file to the Nginx web root
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to allow external access
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
