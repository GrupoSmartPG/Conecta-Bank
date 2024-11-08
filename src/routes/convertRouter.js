import express from 'express';
import { conversaoMoeda } from '../middlewares/conversaoMoeda';
import { createConversion } from '../controllers/convertController';

const router = express.Router();

router.post('/convert', conversaoMoeda, createConversion);

export default router;