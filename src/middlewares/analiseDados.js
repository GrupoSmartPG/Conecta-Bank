import Transacoes from '../models/transacoesModel';

export const obterTransacoesPorUsuario = async (usuarioId) => {
    return await Transacoes.find({ usuarioId });
};

export const classificarPorCategoria = (transacoes) => {
    return transacoes.reduce((acc, transacao) => {
        acc[transacao.categoria] = (acc[transacao.categoria] || 0) + transacao.valor;
        return acc;
    }, {});
};
