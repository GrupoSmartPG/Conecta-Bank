import express from 'express';
import { conversaoMoeda } from '../middlewares/conversaoMoeda.js';
import { createConversion } from '../controllers/convertController.js';
import { verifyJWT } from '../middlewares/jwt.js';

const convertRouter = express.Router();

convertRouter.post('/convert', conversaoMoeda, createConversion, verifyJWT);

export default convertRouter;