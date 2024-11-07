import axios from 'axios';

const EXCHANGE_RATE_API_KEY = process.env.EXCHANGE_RATE_API_KEY;
const BASE_URL = 'https://v6.exchangerate-api.com/v6';

// Função para obter taxa de câmbio e realizar a conversão
export const convertCurrency = async (amount, fromCurrency, toCurrency) => {
    try {
        // URL da API de conversão
        const url = `${BASE_URL}/${EXCHANGE_RATE_API_KEY}/pair/${fromCurrency}/${toCurrency}/${amount}`;
        
        // Solicitação para a API de taxas de câmbio
        const response = await axios.get(url);
        
        if (response.data && response.data.conversion_result) {
            return response.data.conversion_result; // Retorna o valor convertido
        } else {
            throw new Error('Erro ao obter taxa de conversão');
        }
    } catch (error) {
        console.error('Erro ao converter moedas:', error);
        throw error;
    }
};






