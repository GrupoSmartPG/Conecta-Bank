import { Schema, model} from 'mongoose'

const dataAtual = new Date();

const carteiraSchema = new Schema({ 
    usrId: {
        type: Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    saldo: {
        type: Schema.Types.Decimal128,
        required: true,
        default: 0,
        set: (val) => {
            return parseFloat(val).toFixed(3);
        }
    },
    tipoMoeda: {
        type: String,
        required: true
    },
    carteiraCriada: {
        type: Date,
        default: dataAtual
    }

});

carteiraSchema.methods.getFormattedSaldo = function() {
    return parseFloat(this.saldo.toString()).toFixed(3); //Pode dar erro aqui
}

export default model('Carteira', carteiraSchema);