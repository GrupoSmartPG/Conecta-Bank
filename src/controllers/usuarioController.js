import Usuario from '../models/usuarioModel.js'
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { configDotenv } from 'dotenv';
configDotenv()

const SECRET_KEY = process.env.SECRET_KEY;
  
export const register = async (req, res) => {
    const { nome, email, senha } = req.body;
  
    try {
      const userExists = await Usuario.findOne({ email });
      if (userExists) {
        return res.status(400).json({ message: "E-mail já está em uso" });
      }

      const hashedPassword = await bcrypt.hash(senha, 10);
  
      const newUser = new Usuario({ nome, email, senha: hashedPassword });
      await newUser.save();
  
      res.status(201).json({ message: "Usuário registrado com sucesso" });
    } catch (err) {
      res.status(500).json({ message: "Erro no servidor", error: err });
    }
};

export const login = async (req, res) => {
    const { email, senha } = req.body;
  
    try {
      const user = await Usuario.findOne({ email });
    
      if (!user || !(await bcrypt.compare(senha, user.senha))) {
        return res.status(401).json({ message: "Credenciais inválidas" });
      }

      const token = jwt.sign({ email: user.email, nome: user.nome }, SECRET_KEY, { expiresIn: "1h" });
      res.json({ token });
    } catch (err) {
      res.status(500).json({ message: "Erro no servidor", error: err });
    }
}; 

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
      res.status(500).json({ message: "Erro no servidor", error });
    }
  };