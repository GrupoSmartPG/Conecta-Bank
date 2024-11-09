import { Router } from "express";
import { 
    store,
    index,
    update,
    destroy
} from "../controllers/carteiraController.js";
import { verifyJWT } from "../middlewares/jwt.js"; // Importa o middleware

const carteiraRouter = Router();


carteiraRouter.post('/nova', verifyJWT, store); // Criação de carteira
carteiraRouter.get('/carteiras', verifyJWT, index); // Listagem de carteiras
carteiraRouter.put('/:id', verifyJWT, update); // Atualização de carteira
carteiraRouter.delete('/:id', verifyJWT, destroy); // Exclusão de carteira

export default carteiraRouter;
