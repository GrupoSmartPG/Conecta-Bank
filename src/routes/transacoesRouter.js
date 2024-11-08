import { Router } from "express";
import { 
    transferir
} from '../controllers/transacoesController.js';

const transacaoRouter = Router();

transacaoRouter.post('/transferir', transferir)

export default transacaoRouter;