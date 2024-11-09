import express from "express";
import { analisarGastos } from "../controllers/analiseController.js";
import { verifyJWT } from "../middlewares/jwt.js";

const analiseRouter = express.Router();

analiseRouter.get("/gastos", verifyJWT, analisarGastos); // Middleware JWT aplicado corretamente

export default analiseRouter;
