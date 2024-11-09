import { obterTransacoesPorUsuario, classificarPorCategoria} from '../middlewares/analiseDados.js';

export const analisarGastos = async (req, res) => {
    const { usuarioId } = req.params;

    try {
        const transacoes = await obterTransacoesPorUsuario(usuarioId);
        const gastosPorCategoria = classificarPorCategoria(transacoes);
        
        const gastoTotal = transacoes.reduce((acc, transacoes) => acc + transacoes.valor, 0);
        const gastoMedio = gastoTotal / (transacoes.length || 1);

        res.json({
            gastoTotal,
            gastoMedio,
            gastosPorCategoria,
            transacoes
        });
    } catch (error) {
        res.status(500).json({ error: 'Erro analise dados'})
    }
}
