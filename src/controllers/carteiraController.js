import Carteira from '../models/carteiraModel.js';

export const store = async (req, res) => {
    try {
        const carteira = await Carteira.create(req.body);
        return res.status(201).json(carteira);
    } catch (error) {
        return res.status(500).json({ error: error });
        }
    };
    
    export const index = async (req, res) => {
        try {
        const carteira = await Carteira.find().exec();
        return res.status(200).json(carteira);
        } catch (error) {
        return res.status(500).json({ error: error });
        }
    };
    
    export const update = async (req, res) => {
        try {
        const carteira = await Carteira.findByIdAndUpdate(
            req.params.id,
            req.body
        ).exec();
        return res.status(200).json(carteira);
        } catch (error) {
        return res.status(500).json({ error: error });
        }
    };
    
    export const destroy = async (req, res) => {
        try {
        const carteira = await Carteira.findByIdAndDelete(req.params.id).exec();
        return res.status(204).json();
        } catch (error) {
        return res.status(500).json({ error: error });
        }
    };