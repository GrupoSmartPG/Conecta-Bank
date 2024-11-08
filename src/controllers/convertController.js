export const createConversion = async (req, res) => {
    const { amount, fromCurrency, toCurrency  } = req.body;
    
    try {
        const valorConvertido = req.valorConvertido;
        
        return res.status(200).json({
            message: 'Conversão realizada', 
            fromCurrency,
            toCurrency,
            originalAmount: amount,
            convertedAmount: valorConvertido,
        });
    } catch (error) {
        return res.status(500).json({ error: 'Erro ao criar conversão' });
    }
};