

import Carteira from '../models/carteiraModel.js';
import Transacoes from '../models/transacoesModel.js';

export const transferir = async (req, res) => {
  const { deCarteira, carteiraPara, valor, tipoMoeda, detalhes } = req.body;

  try {
    // Verifica se as carteiras existem
    const remetente = await Carteira.findById(deCarteira);
    const destinatario = await Carteira.findById(carteiraPara);

    if (!remetente || !destinatario) {
      return res.status(404).json({ message: "Carteira remetente ou destinatária não encontrada." });
    }

    // Verifica se as moedas são compatíveis
    if (remetente.tipoMoeda !== destinatario.tipoMoeda) {
      return res.status(400).json({ message: "As carteiras possuem tipos de moeda diferentes." });
    }

    // Verifica se há saldo suficiente na carteira remetente
    if (remetente.saldo < valor) {
      return res.status(400).json({ message: "Saldo insuficiente na carteira remetente." });
    }

    // Realiza a transferência
    remetente.saldo -= valor;
    destinatario.saldo += valor;

    // Cria a transação
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

    // Salva a transação e atualiza as carteiras
    await novaTransacao.save();
    await remetente.save();
    await destinatario.save();

    res.status(200).json({ message: "Transferência realizada com sucesso", transacao: novaTransacao });
  } catch (err) {
    console.error("Erro ao realizar transferência:", err.message);
    res.status(500).json({ message: "Erro ao transferir", error: err.message });
  }
};




export const listarTransacoes = async (req, res) => {
  try {
    // Obtemos os parâmetros de paginação da query string
    const page = parseInt(req.query.page) || 1; // Página atual (padrão: 1)
    const limit = parseInt(req.query.limit) || 10; // Limite de itens por página (padrão: 10)
    const skip = (page - 1) * limit;

    // Busca as transações com paginação
    const transacoes = await Transacoes.find()
      .populate("deCarteira carteiraPara", "tipoMoeda saldo") // Popula informações das carteiras
      .skip(skip) // Pula os registros anteriores
      .limit(limit); // Limita a quantidade de registros retornados

    // Conta o total de transações no banco
    const total = await Transacoes.countDocuments();

    res.status(200).json({
      total, // Total de transações
      page, // Página atual
      pages: Math.ceil(total / limit), // Total de páginas
      transacoes, // Transações retornadas
    });
  } catch (err) {
    console.error("Erro ao listar transações:", err.message);
    res.status(500).json({ message: "Erro ao listar transações.", error: err.message });
  }
};
