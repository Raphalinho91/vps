# Utilise l'image de base Ubuntu
FROM ubuntu:latest

# Met à jour les packages et installe OpenSSH Server, Node.js, et Nginx
RUN apt-get update && \
    apt-get install -y openssh-server nginx nodejs npm

# Configure le serveur SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PermitTunnel yes" >> /etc/ssh/sshd_config

# Copie le fichier de configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copie le fichier index.js dans le conteneur
COPY index.js /usr/src/app/index.js

# Expose le port 80 pour HTTP
EXPOSE 80

# Lance le serveur SSH, le serveur Node.js, et Nginx
CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & nginx & node /usr/src/app/index.js"]
