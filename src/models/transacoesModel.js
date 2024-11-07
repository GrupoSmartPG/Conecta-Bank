import { Schema, model } from "mongoose";

const dataAtual = new Date();

const transacoesSchema = new Schema({
    deCarteira: {
        type: Schema.Types.ObjectId,
        ref: 'Carteira',
        required: true
    },
    carteiraPara: {
        type: Schema.Types.ObjectId,
        ref: 'Carteira',
        required: true
    },
    montante: {
        type: Number,
        required: true
    },
    tipoTransacao: {
        type: String,
        enum: ['DEPOSITO', 'TRANSFERENCIA', 'RETIRADA'],
        required: true
    },
    statusTransacao: {
        type: String,
        required: true
    },
    tipoMoeda: {
        type: String,
        required: true
    },
    detalhes: {
        type: String,
        required: true
    },
    dataTransacao: {
        type: Date,
        default: dataAtual
    }
});

export default model('Transacoes', transacoesSchema);