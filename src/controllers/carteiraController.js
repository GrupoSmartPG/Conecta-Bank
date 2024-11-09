import jwt from "jsonwebtoken";
import Carteira from "../models/carteiraModel.js";
import Usuario from "../models/usuarioModel.js";

const SECRET_KEY = process.env.SECRET_KEY; // Certifique-se de que SECRET_KEY está configurado no .env

// Função para extrair e verificar o token JWT
const getUserFromToken = async (authHeader) => {
  if (!authHeader) {
    throw new Error("Token não fornecido.");
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    throw new Error("Token não fornecido.");
  }

  const decoded = jwt.verify(token, SECRET_KEY);
  const user = await Usuario.findById(decoded.id);
  if (!user) {
    throw new Error("Usuário não encontrado.");
  }

  return user;
};

// Função para armazenar carteira
export const store = async (req, res) => {
  try {
    const user = await getUserFromToken(req.headers.authorization);

    // Define o tipo de moeda
    const tipo = req.body.tipoMoeda || "Real";

    // Cria a carteira associada ao usuário
    const carteira = await Carteira.create({
      usrId: user._id,
      tipoMoeda: tipo,
      saldo: req.body.saldo || 0, // Define saldo inicial se fornecido
    });

    return res.status(201).json(carteira);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

// Função para listar carteiras
export const index = async (req, res) => {
  try {
    const user = await getUserFromToken(req.headers.authorization);

    // Lista apenas as carteiras do usuário autenticado
    const carteiras = await Carteira.find({ usrId: user._id }).exec();
    return res.status(200).json(carteiras);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

// Função para atualizar carteira
export const update = async (req, res) => {
  try {
    const user = await getUserFromToken(req.headers.authorization);

    // Verifica se a carteira pertence ao usuário autenticado antes de atualizar
    const carteira = await Carteira.findOneAndUpdate(
      { _id: req.params.id, usrId: user._id },
      req.body,
      { new: true } // Retorna o documento atualizado
    );

    if (!carteira) {
      return res.status(404).json({ message: "Carteira não encontrada." });
    }

    return res.status(200).json(carteira);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

// Função para excluir carteira
export const destroy = async (req, res) => {
  try {
    const user = await getUserFromToken(req.headers.authorization);

    // Verifica se a carteira pertence ao usuário autenticado antes de excluir
    const carteira = await Carteira.findOneAndDelete({
      _id: req.params.id,
      usrId: user._id,
    });

    if (!carteira) {
      return res.status(404).json({ message: "Carteira não encontrada." });
    }

    return res.status(204).send();
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};
