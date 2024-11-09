import { obterTransacoesPorUsuario, classificarPorCategoria } from "../middlewares/analiseDados.js";
import Carteira from "../models/carteiraModel.js";
import jwt from "jsonwebtoken";

const SECRET_KEY = process.env.SECRET_KEY; // Certifique-se de configurar corretamente no .env

// Função para extrair e verificar o token JWT
const getUserFromToken = async (authHeader) => {
  if (!authHeader) {
    throw new Error("Token não fornecido.");
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    throw new Error("Token malformado.");
  }

  const decoded = jwt.verify(token, SECRET_KEY);
  return decoded.id; // Retorna apenas o ID do usuário
};

// Função para análise de gastos
export const analisarGastos = async (req, res) => {
  try {
    // Obtemos o ID do usuário a partir do token JWT
    const usuarioId = await getUserFromToken(req.headers.authorization);

    // Obtém as carteiras relacionadas ao usuário
    const carteiras = await Carteira.find({ usrId: usuarioId });
    if (!carteiras || carteiras.length === 0) {
      return res.status(404).json({ error: "Nenhuma carteira encontrada para o usuário." });
    }

    // Obtém os IDs das carteiras
    const idsCarteiras = carteiras.map((carteira) => carteira._id);

    // Obtém as transações relacionadas às carteiras do usuário
    const transacoes = await obterTransacoesPorUsuario(idsCarteiras);

    // Classifica os gastos por categoria
    const gastosPorCategoria = classificarPorCategoria(transacoes);

    // Calcula o gasto total e médio
    const gastoTotal = transacoes.reduce((acc, transacao) => acc + transacao.montante, 0);
    const gastoMedio = gastoTotal / (transacoes.length || 1);

    res.json({
      gastoTotal,
      gastoMedio,
      gastosPorCategoria,
      transacoes,
    });
  } catch (error) {
    console.error("Erro ao analisar gastos:", error.message);
    res.status(500).json({ error: "Erro na análise de dados." });
  }
};
