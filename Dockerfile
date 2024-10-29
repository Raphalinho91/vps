# Utilise l'image de base Ubuntu
FROM ubuntu:latest

# Met à jour les packages et installe OpenSSH Server, Node.js, et Nginx
RUN apt-get update && \
    apt-get install -y openssh-server nginx nodejs npm supervisor

# Configure le serveur SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "PermitTunnel yes" >> /etc/ssh/sshd_config

# Copie le fichier de configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copie le fichier index.js dans le conteneur
COPY index.js /usr/src/app/index.js

# Copie la configuration de supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose le port 80 pour HTTP
EXPOSE 80

# Lance supervisord pour gérer les services
CMD ["/usr/bin/supervisord"]
