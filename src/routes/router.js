import express from "express";
const mainRouter = express.Router();

import usuarioRouter from "./convertRouter.js";
mainRouter.use('/usuario', usuarioRouter)

import convertRouter from "./convertRouter.js";
mainRouter.use('/convert', convertRouter);

import carteiraRouter from "./carteiraRouter.js"
mainRouter.use('/carteira', carteiraRouter)

export default mainRouter;