# Utilise l'image de base Ubuntu
FROM ubuntu:latest

# Met à jour les packages et installe OpenSSH Server et Node.js
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get install -y nodejs npm

# Configure le serveur SSH
RUN mkdir /var/run/sshd

# Définit le mot de passe pour l'utilisateur root (ici "root" pour l'exemple)
RUN echo 'root:root' | chpasswd

# Autorise la connexion root via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Autorise les tunnels
RUN echo "PermitTunnel yes" >> /etc/ssh/sshd_config

# Copie le fichier index.js dans le conteneur
COPY index.js /usr/src/app/index.js

# Expose le port SSH et le port du serveur HTTP
EXPOSE 2222 3000

# Lance le serveur SSH et le serveur Node.js
CMD ["/bin/bash", "-c", "/usr/sbin/sshd -D & node /usr/src/app/index.js"]
