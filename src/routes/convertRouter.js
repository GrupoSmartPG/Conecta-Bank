import express from 'express';
import { createConversion, getConversion } from '../controllers/convertController.js';

const router = express.Router();

// Rota para criar uma nova conversão de moeda
router.post('/convert', createConversion);

// Rota para obter uma conversão específica pelo ID
router.get('/convert/:id', getConversion);

export default router;
