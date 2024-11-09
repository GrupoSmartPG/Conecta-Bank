import Usuario from '../models/usuarioModel.js'
import { configDotenv } from 'dotenv';
configDotenv()

  

export const update = async (req ,res) => {
    try {
        const user = await Usuario.findByIdAndUpdate(req.params.id, req.body).exec()
        res.status(200).json(user)
    } catch (error) {
        res.status(400).json("Não foi possivel atualizar")
    }
}

export const sacarFundos = async (req, res) => {
    const { id } = req.params;
    const { valor } = req.body;
  
    try {
      const user = await Usuario.findById(id);
      if (!user) {
        return res.status(404).json({ message: "Usuário não encontrado" });
      }
  
      if (user.saldo < valor) {
        return res.status(400).json({ message: "Saldo insuficiente" });
      }
  
      user.saldo -= valor;
      await user.save();
  
      res.status(200).json({ message: "Saque realizado com sucesso", saldo: user.saldo });
    } catch (error) {
      res.status(500).json({ message: "Erro no servidor", error });
    }
  };

export const fecharConta = async (req, res) => {
    const { id } = req.params;
  
    try {
      const user = await Usuario.findById(id);
      if (!user) {
        return res.status(404).json({ message: "Usuário não encontrado" });
      }
  
      if (user.saldo > 0) {
        return res.status(400).json({ message: "Você ainda tem saldo na conta. Realize um saque antes de encerrar." });
      }
  
      await Usuario.findByIdAndDelete(id);
  
      res.status(200).json({ message: "Conta encerrada com sucesso" });
    } catch (error) {
      res.status(500).json({ message: "Erro no servidor", error });x
    }
  };