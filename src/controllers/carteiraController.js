import Carteira from '../models/carteiraModel.js';
import Usuario from '../models/usuarioModel.js';

export const store = async (req, res) => {
    try {
        const user = await Usuario.findOne({ email: req.body.email });
        if(!user){
            return res.status(500).json('Usuário não encontrado.');
        };
        if(!req.body.tipoMoeda){
            tipo = 'Real';
        } else{
            tipo = req.body.tipoMoeda;
        };
        const carteira = {
            usrId:user._id,
            tipoMoeda: tipo
        };
        await Carteira.create(carteira);
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
