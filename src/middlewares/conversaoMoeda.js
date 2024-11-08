import axios from 'axios';

const EXCHANGE_RATE_API_KEY = process.env.EXCHANGE_RATE_API_KEY;


const BASE_URL = 'https://v6.exchangerate-api.com/v6';

export const conversaoMoeda = async (req, res, next) => {
    const { amount, fromCurrency, toCurrency } = req.body;

    if (!amount || !fromCurrency || !toCurrency) {
        return res.status(400).json({ error: 'Insira todos os parâmetros. '});
    }

    try {
        const url = `${BASE_URL}/${EXCHANGE_RATE_API_KEY}/pair/${fromCurrency}/${toCurrency}`;
        const response = await axios.get(url);

        if (response.data && response.data.conversion_rate) {
            const taxaDeConversao = response.data.conversion_rate;
            const valorConvertido = amount * taxaDeConversao;
        
            req.valorConvertido = valorConvertido;
            next();
        } else {
            throw new Error('Erro ao obter a taxa de conversão da API.');
        }
    } catch (error) {
        return res.status(500).json({ error: 'Erro ao realizar a conversão'});
    }
};