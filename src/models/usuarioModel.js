import {Schema,model} from 'mongoose'

const usuarioSchema = new Schema ({
    nome: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    senha: {
        type: String,
        required: true
    },
    saldo: {
        type: Number,
        default: 0
    },
    transacoes: [{ 
        type: Schema.Types.ObjectId, 
        ref: "Transacoes" 
    }]
})

export default model('Usuario', usuarioSchema);
