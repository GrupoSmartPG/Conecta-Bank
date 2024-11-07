import { Router } from "express";
import { 
    store,
    index,
    update,
    destroy
} from '../controllers/carteiraController.js';

const carteiraRouter = Router();

carteiraRouter.post('/nova', store);
carteiraRouter.get('/carteiras', index);
carteiraRouter.put('/:id', update);
carteiraRouter.delete('/:id', destroy);

export default carteiraRouter;