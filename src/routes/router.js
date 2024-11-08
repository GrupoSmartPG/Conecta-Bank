import express from "express";
const mainRouter = express.Router();

import usuarioRouter from "./usuarioRouter.js";
mainRouter.use('/usuario', usuarioRouter)

import carteiraRouter from "./carteiraRouter.js"
mainRouter.use('/carteira', carteiraRouter)

import transacaoRouter from "./transacoesRouter.js";
mainRouter.use('/transacao', transacaoRouter)

export default mainRouter;