# Using the latest ubuntu as the base image 
FROM ubuntu:latest

# Installing the  dependencies and cowsay and also copies the fortune and cowsay executables to the /bin directory.
RUN apt-get update && \
    apt-get -y install fortune cowsay
RUN apt-get install -y netcat-openbsd
RUN cp -pr /usr/games/fortune /bin/fortune
RUN cp -pr /usr/games/cowsay /bin/cowsay

# Copies the TLS certificate and private key into the container and restrict the permission of the private key to the user only.
# Let say the certificate name is tls.crt and private key name is tls.key 
COPY tls.crt /etc/tls/tls.crt
COPY tls.key /etc/tls/tls.key
RUN chmod 600 /etc/tls/tls.key

# Sets the working directory to /app
WORKDIR /app

# Copied the script into the container
COPY wisecow.sh /app/wisecow.sh

# Made the script executable by adding execution permission
RUN chmod +x /app/wisecow.sh

# Exposed the port No that the server can run on
EXPOSE 4499

# Runs the wisecow.sh script as the default command.
CMD ["/app/wisecow.sh"]




