# Use the official NGINX base image
FROM nginx

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove default NGINX static files
RUN rm -rf ./*

# Copy website files from your local machine to the container
COPY ./website /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 8080

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
