import express from 'express';
import { conversaoMoeda } from '../middlewares/conversaoMoeda';
import { createConversion } from '../controllers/convertController';

const convertRouter = express.Router();

convertRouter.post('/convert', conversaoMoeda, createConversion);

export default convertRouter;