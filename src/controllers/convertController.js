import { convertCurrency } from '../models/currencyModel.js';
import Carteira from '../models/carteiraModel.js';


// Função para criar uma nova conversão de moedas
export const createConversion = async (req, res) => {
    const { carteiraId, amount, fromCurrency, toCurrency } = req.body;

    // Validação dos parâmetros obrigatórios
    if (!carteiraId || !amount || !fromCurrency || !toCurrency) {
        return res.status(400).json({ error: 'Parâmetros faltando. Inclua carteiraId, amount, fromCurrency e toCurrency.' });
    }

    try {
        // Verifica se a carteira existe
        const carteira = await Carteira.findById(carteiraId);
        if (!carteira) {
            return res.status(404).json({ error: 'Carteira não encontrada' });
        }

        // Realiza a conversão de moedas usando a função que utiliza a API externa
        const valorConvertido = await convertCurrency(parseFloat(amount), fromCurrency.toUpperCase(), toCurrency.toUpperCase());

        // Cria a conversão e salva no banco de dados
        const conversao = await Convert.create({
            saldoA: carteiraId,
            saldoB: valorConvertido,
            fromCurrency,
            toCurrency,
            amount,
            convertedAt: new Date(),
        });

        return res.status(201).json({
            message: 'Conversão realizada com sucesso',
            fromCurrency,
            toCurrency,
            originalAmount: amount,
            convertedAmount: valorConvertido,
            conversion: conversao
        });
    } catch (error) {
        console.error('Erro ao realizar conversão:', error);
        return res.status(500).json({ error: 'Erro ao realizar a conversão de moedas' });
    }
};

// Função para obter uma conversão específica pelo ID
export const getConversion = async (req, res) => {
    const { id } = req.params;

    try {
        // Busca a conversão pelo ID e popula o saldoA com os dados da carteira
        const conversao = await Convert.findById(id).populate('saldoA');

        if (!conversao) {
            return res.status(404).json({ error: 'Conversão não encontrada' });
        }

        return res.status(200).json(conversao);
    } catch (error) {
        console.error('Erro ao buscar conversão:', error);
        return res.status(500).json({ error: 'Erro ao buscar a conversão de moedas' });
    }
};
