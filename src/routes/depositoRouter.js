import { Router } from "express";
import { 
    deposit
} from '../controllers/depositoController.js';
import { verifyJWT } from '../middlewares/jwt.js';

const depositoRouter = Router();

depositoRouter.post('/depositar', verifyJWT, deposit);

export default depositoRouter;