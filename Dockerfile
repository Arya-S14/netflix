FROM nginx:alpine  

# Copy static html file into nginx web root
COPY netflix.html /usr/share/nginx/html/index.html  

EXPOSE 80
