import { Router } from 'express'
import{register,
login}from '../controllers/authUserController.js'
const authRouter = Router()
authRouter.post('/registro', register)
authRouter.post('/login', login)

export default authRouter;