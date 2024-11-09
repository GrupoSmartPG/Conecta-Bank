import { Router } from "express";
import { 
    transferir
} from '../controllers/transacoesController.js';
import { verifyJWT } from '../middlewares/jwt.js';


const transacaoRouter = Router();

transacaoRouter.post('/transferir', transferir, verifyJWT)

export default transacaoRouter;