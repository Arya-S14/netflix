# Use nginx lightweight image
FROM nginx:alpine

# Copy your HTML file into nginx default public directory
COPY netflix.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
