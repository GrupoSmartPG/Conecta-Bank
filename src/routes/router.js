import express from "express";
const mainRouter = express.Router();

import usuarioRouter from "./usuarioRouter.js";
mainRouter.use('/usuario', usuarioRouter)

import convertRouter from "./convertRouter.js";
mainRouter.use('/convert', convertRouter);

export default mainRouter;