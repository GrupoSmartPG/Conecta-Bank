import express from 'express';
import { analisarGastos } from "../controllers/analiseController.js";

const analiseRouter = express.Router();

analiseRouter.get('/analisador/:usrId', analisarGastos);

export default analiseRouter;