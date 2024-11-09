import { Router } from "express";

import {
    store,
    index,
    update,
    destroy
} from '../controllers/catalogoController.js';

const catalogoRouter = Router();

catalogoRouter.post('/novo', store);
catalogoRouter.get('estabelecimentos', index);
catalogoRouter.put('/:id', update);
catalogoRouter.delete('/:id', destroy);

export default catalogoRouter;
