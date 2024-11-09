import express from "express";
import cors from "cors";
import connectDB from "./config/db.js";
import mainRouter from "./routes/router.js";

// Criação do servidor Express
const app = express();

// Configuração do CORS
const allowedOrigins = [
  'https://conecta-bank.flutterflow.app'
];

app.use(cors({
  origin: function (origin, callback) {
    if (!origin || allowedOrigins.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true, // Permitir envio de cookies e credenciais
}));

// Middleware para interpretar JSON
app.use(express.json());

// Conexão com o banco de dados
connectDB();

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
