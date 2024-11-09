import { Schema, model} from 'mongoose'

const dataAtual = new Date();

const carteiraSchema = new Schema({ 
    usrId: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    saldo: {
        type: Number,
        required: false
    },
    tipoMoeda: {
        type: String,
        required: true,
        default:"R$"
    },
    carteiraCriada: {
        type: Date,
        default: dataAtual
    }

});

export default model('Carteira', carteiraSchema);