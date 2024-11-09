import { Schema, model } from 'mongoose';

const usuarioSchema = new Schema({
  nome: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  senha: {
    type: String,
    required: true,
  },
  celular: {
    type: String,
    required: true,
  },
  saldo: {
    type: Number,
    default: 0,
  },
  transacoes: [
    {
      type: Schema.Types.ObjectId,
      ref: "Transacoes",
    },
  ],
  twoFactorSecret: {
    type: String, // Armazena o segredo do 2FA
    default: null,
  },
  twoFactorEnabled: {
    type: Boolean, // Indica se o 2FA está ativo
    default: false,
  },
});

export default model('Usuario', usuarioSchema);
