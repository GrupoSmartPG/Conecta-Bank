import Usuario from '../models/usuarioModel.js';
import Transacoes from '../models/transacoesModel.js';

export const transferir = async (req, res) => {
  const { deCarteira, carteiraPara, valor, tipoMoeda, detalhes } = req.body;

  try {
    const remetente = await Usuario.findById(deCarteira);
    const destinatario = await Usuario.findById(carteiraPara);

    if (!remetente || !destinatario) {
      return res.status(404).json({ message: "Remetente ou destinatário não encontrado" });
    }

    if (remetente.saldo < valor) {
      return res.status(400).json({ message: "Saldo insuficiente" });
    }

    remetente.saldo -= valor;
    destinatario.saldo += valor;

    const novaTransacao = new Transacoes({
      deCarteira,
      carteiraPara,
      montante: valor,
      tipoTransacao: 'TRANSFERENCIA',
      statusTransacao: 'COMPLETA',
      tipoMoeda,
      detalhes,
      dataTransacao: new Date(),
    });

    await novaTransacao.save();

    await remetente.save();
    await destinatario.save();

    res.status(200).json({ message: "Transferência realizada com sucesso" });
  } catch (err) {
    res.status(500).json({ message: "Erro ao transferir", error: err.message });
  }
};