# Use the official Debian image: https://hub.docker.com/_/debian
FROM debian

# Run updates and install nginx
RUN apt update -y && apt install nginx -y

# Copy the nginx.conf from the repository into the default sites folder
COPY nginx.conf /etc/nginx/sites-available/default

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove default NGINX static files
RUN rm -rf ./*

# Copy website files from your local machine to the container
COPY ./website /usr/share/nginx/html

# Expose port 8080 for web traffic
EXPOSE 8080/tcp

# Start the Nginx server
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
