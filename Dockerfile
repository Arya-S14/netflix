# Use a lightweight web server
FROM nginx:alpine

# Copy your HTML file(s) into Nginx default directory
COPY netflix.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx automatically
CMD ["nginx", "-g", "daemon off;"]
