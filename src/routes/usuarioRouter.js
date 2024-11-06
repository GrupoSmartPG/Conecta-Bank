import { Router } from 'express'
import {
    register,
    login,
    update,
    sacarFundos,
    fecharConta
} from '../controllers/usuarioController.js'
import { verifyJWT } from '../middlewares/jwt.js';

const usuarioRouter = Router()

usuarioRouter.post('/registro', register)
usuarioRouter.post('/login', login)
usuarioRouter.put('/:id', update)
usuarioRouter.post('/sacar/:id', verifyJWT, sacarFundos)
usuarioRouter.delete('/:id', verifyJWT,fecharConta)



export default usuarioRouter