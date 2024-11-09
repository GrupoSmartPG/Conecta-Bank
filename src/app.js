import express from "express";
import cors from 'cors';
import connectDB from "./config/db.js";
import mainRouter from "./routes/router.js";

// Criação do servidor Express
const app = express();

// Configuração do CORS (Permitir qualquer origem)
app.use(cors({
  origin: true, // Permitir todas as origens
  credentials: true, // Permitir envio de cookies e credenciais
}));

// Middleware para interpretar JSON
app.use(express.json());

// Conexão com o banco de dados
connectDB()
  .then(() => console.log("Conectado ao banco de dados"))
  .catch((err) => {
    console.error("Erro ao conectar ao banco de dados:", err.message);
    process.exit(1); // Finaliza o processo em caso de erro crítico
  });

// Roteador principal
app.use('/', mainRouter);

// Rota para verificar se o servidor está funcionando
app.get("/", (req, res) => {
  res.status(200).send("Servidor ok!");
});

// Inicialização do servidor
const porta = 3000;
app.listen(porta, () => {
  console.log(`Servidor rodando na porta ${porta}`);
});
