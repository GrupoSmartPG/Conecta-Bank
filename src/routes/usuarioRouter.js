import { Router } from 'express'
import {
   
    update,
    sacarFundos,
    fecharConta
} from '../controllers/usuarioController.js'
import { verifyJWT } from '../middlewares/jwt.js';

const usuarioRouter = Router()

usuarioRouter.put('/:id', update)
usuarioRouter.post('/sacar/:id', verifyJWT, sacarFundos)
usuarioRouter.delete('/:id', verifyJWT,fecharConta)



export default usuarioRouter