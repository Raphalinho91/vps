const http = require("http");

// Configuration du port
const PORT = 3000;

// Création du serveur
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader("Content-Type", "text/plain");
  res.end("Bienvenue sur votre serveur Ubuntu!\n");
});

// Démarrage du serveur
server.listen(PORT, () => {
  console.log(`Serveur en écoute sur le port ${PORT}`);
});
