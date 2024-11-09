import { Schema, model } from "mongoose";

const catalogoSchema = new Schema({
        nomeEstabelecimento: {
            type: String,
            required: true
        },
        tipoEstabelecimento: {
            type: String,
            required: true
        }
    });

export default model('Catalogo', catalogoSchema);