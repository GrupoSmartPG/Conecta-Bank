import express from "express";
import cors from "cors";
import connectDB from "./config/db.js";
import mainRouter from "./routes/router.js";

// Criação do servidor Express
const app = express();

// Configuração do CORS
app.use(cors({
  origin: (origin, callback) => {
    // Permitir todas as origens
    callback(null, true);
  },
  credentials: true, // Permitir envio de cookies e credenciais
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], // Métodos HTTP permitidos
  allowedHeaders: ['Content-Type', 'Authorization'], // Cabeçalhos permitidos
}));

// Middleware para lidar com pré-requisições
app.options('*', cors()); // Lidar com preflight requests

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
app.use("/", mainRouter);

// Rota para verificar se o servidor está funcionando
app.get("/", (req, res) => {
  res.status(200).send("Servidor ok!");
});

// Inicialização do servidor
const porta = 3000;
app.listen(porta, () => {
  console.log(`Servidor rodando na porta ${porta}`);
});
