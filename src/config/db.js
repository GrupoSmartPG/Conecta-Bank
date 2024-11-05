import mongoose from "mongoose";

const connectDB = async () => {
    mongoose
        .connect(`mongodb://localhost:27017/Conecta-Bank`) // aqui conecta
        .then(() => console.log('Connected to MongoDB')) // se conectar, imprime isso
        .catch((error) => console.log(error)); // se der erro, imprime o erro
};
export default connectDB;