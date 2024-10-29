# Utilise l'image de base Ubuntu
FROM ubuntu:latest

# Met à jour les packages et installe OpenSSH Server
RUN apt-get update && apt-get install -y openssh-server

# Configure le serveur SSH
RUN mkdir /var/run/sshd

# Définit le mot de passe pour l'utilisateur root (ici "root" pour l'exemple)
RUN echo 'root:root' | chpasswd

# Autorise la connexion root via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Autorise les tunnels
RUN echo "PermitTunnel yes" >> /etc/ssh/sshd_config

# Expose le port SSH
EXPOSE 22

# Lance le serveur SSH
CMD ["/usr/sbin/sshd", "-D"]
