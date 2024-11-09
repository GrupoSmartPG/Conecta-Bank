import { Router } from 'express';
import { register, login, verify2FA } from '../controllers/authUserController.js';
import { store } from '../controllers/carteiraController.js';
const authRouter = Router();

// Rota para registro de novos usuários
authRouter.post('/registro', register, store);

// Rota para login
authRouter.post('/login', login);

// Rota para verificar o token de 2FA
authRouter.post('/verify-2fa', verify2FA);

export default authRouter;
