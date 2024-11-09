import express from "express";
const mainRouter = express.Router();

import usuarioRouter from "./usuarioRouter.js";
mainRouter.use('/usuario', usuarioRouter)

import authRouter from "./authRouter.js"
mainRouter.use("/auth", authRouter)

import convertRouter from "./convertRouter.js";
mainRouter.use('/convert', convertRouter);

import carteiraRouter from "./carteiraRouter.js"
mainRouter.use('/carteira', carteiraRouter);

import transacaoRouter from "./transacoesRouter.js";
mainRouter.use('/transacao', transacaoRouter);

import depositoRouter from "./depositoRouter.js";
mainRouter.use('/deposito', depositoRouter);

import analiseRouter from "./analiseRouter.js";
mainRouter.use('/analise', analiseRouter);

export default mainRouter