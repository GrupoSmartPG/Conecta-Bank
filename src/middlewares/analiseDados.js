import Transacoes from '../models/transacoesModel.js';

export const obterTransacoesPorUsuario = async (usuarioId) => {
    return await Transacoes.find({ usuarioId });
};

export const classificarPorCategoria = (transacaos) => {
    return transacaos.reduce((acc, transacao) => {
        acc[transacao.categoria] = (acc[transacao.categoria] || 0) + transacao.valor;
        return acc;
    }, {});
};
