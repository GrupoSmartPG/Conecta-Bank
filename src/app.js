import express from "express";
const app = express();
app.use(express.json());
import connectDB from "./config/db.js";

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