import express from "express"
const app = express();
app.use(express.json());

import mainRouter from "./src/routes/router.js";
app.use('/', mainRouter)

//Dados padrões servidor
app.get("/",(req,res)=>{
    res.status(200).send("Servidor ok!")
})

const porta = 3000;
app.listen(porta,() =>{
    console.log(`Servidor rodando na porta http://localhost:${porta}`);
})