import express from 'express';
import { conversaoMoeda } from '../middlewares/conversaoMoeda.js';
import { createConversion } from '../controllers/convertController.js';

const convertRouter = express.Router();

convertRouter.post('/convert', conversaoMoeda, createConversion);

export default convertRouter;