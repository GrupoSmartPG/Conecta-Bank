import { Router } from "express";
import { 
    transferir, listarTransacoes
} from '../controllers/transacoesController.js';
import { verifyJWT } from '../middlewares/jwt.js';


const transacaoRouter = Router();

transacaoRouter.post('/transferir', transferir, verifyJWT)



transacaoRouter.post('/listar', listarTransacoes, verifyJWT)


export default transacaoRouter;