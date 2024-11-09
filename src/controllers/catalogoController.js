import Catalogo from '../models/catologoModel.js';

export const store = async (req, res) => {
    try {
        const catalogo = await Catalogo.create(req.body);
        return res.status(200).json(catalogo);
    } catch (error) {
        return res.status(400).json({ error: 'Falha ao criar estabelecimento'});
    }
}

export const index = async (req, res) => {
    try {
        const catalogos = await Catalogo.find().exec()
        return res.status(200).json(catalogos);
    } catch (error) {
        return res.status(400).json({ error: 'falha ao listar os estabelecimentos '});
    }
}

export const update = async (req, res) => {
    try {
        const catalogo = await Catalogo.findByIdAndUpdate(req.params.id, req.body).exec();
        return res.status(200).json(catalogo);
    } catch (error) {
        return res.status(400).json({ error: 'Falha ao atualizar estebelecimento' });
    }
}

export const destroy = async (req, res) => {
    try {
        await Catalogo.findByIdAndDelete(req.params.id).exec();
        return res.status(200).json();
    } catch (error) {
        return res.status(400).json({ error: error });
    }
};