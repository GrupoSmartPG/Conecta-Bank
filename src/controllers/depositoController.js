// controllers/usuarioController.js
import Usuario from "../models/usuarioModel.js";
import Transacoes from "../models/transacoesModel.js";  // Importando o modelo de transações

export const deposit = async (req, res) => {
  const { id } = req.params;  // ID do usuário para o qual o depósito será feito
  const { montante, tipoMoeda, detalhes } = req.body;

  try {
    // Verifica se o usuário existe
    const user = await Usuario.findById(id);
    if (!user) {
      return res.status(404).json({ message: "Usuário não encontrado" });
    }

    // Atualiza o saldo do usuário
    user.saldo += montante;
    await user.save();

    // Cria a transação de depósito
    const novaTransacao = new Transacoes({
      deCarteira: null,  // Se for um depósito externo, pode ser nulo
      carteiraPara: id,  // ID da carteira do usuário que recebe o depósito
      montante,
      tipoTransacao: 'DEPOSITO',
      statusTransacao: 'COMPLETA',
      tipoMoeda,
      detalhes,
    });

    await novaTransacao.save();

    res.status(200).json({ message: "Depósito realizado com sucesso", saldoAtual: user.saldo });
  } catch (err) {
    res.status(500).json({ message: "Erro no servidor", error: err });
  }
};