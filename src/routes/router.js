import express from "express";
const mainRouter = express.Router();

import usuarioRouter from "./usuarioRouter.js";
mainRouter.use('/usuario', usuarioRouter)

export default mainRouter;