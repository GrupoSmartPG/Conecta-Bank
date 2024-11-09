import Transacoes from "../models/transacoesModel.js";

// Obtém transações relacionadas às carteiras do usuário
export const obterTransacoesPorUsuario = async (carteirasDoUsuario) => {
  return await Transacoes.find({ deCarteira: { $in: carteirasDoUsuario } });
};

// Classifica os gastos por categoria
export const classificarPorCategoria = (transacoes) => {
  return transacoes.reduce((acc, transacao) => {
    const categoria = transacao.categoria || "Sem Categoria"; // Define "Sem Categoria" como padrão
    acc[categoria] = (acc[categoria] || 0) + transacao.montante; // Soma o valor na categoria correspondente
    return acc;
  }, {});
};
