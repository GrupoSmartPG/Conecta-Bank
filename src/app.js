import express from "express";

import connectDB from "./config/db.js";
import cors from 'cors';
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
    credentials: true, // Permitir o envio de cookies e credenciais
  }));
  

  const app = express();
  app.use(express.json());



connectDB()

import mainRouter from "./routes/router.js";
app.use('/', mainRouter)



app.get("/",(req,res)=>{
    res.status(200).send("Servidor ok!")
})

const porta = 3000;
app.listen(porta,() =>{
    console.log(`Servidor rodando na porta ${porta}`);
})