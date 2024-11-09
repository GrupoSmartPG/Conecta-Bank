import mongoose from "mongoose";
import {configDotenv } from "dotenv"
configDotenv()

const dbUser = process.env.DB_USER;
const dbPass = process.env.DB_PASS
console.log(dbUser)
const connectDB = async () => {
    mongoose
        .connect(`mongodb+srv://fpedrapaixao:Filipe16.@cluster0.4lhzj.mongodb.net/ConectaBank`) // aqui conecta
        .then(() => console.log('Connected to MongoDB')) // se conectar, imprime isso
        .catch((error) => console.log(error)); // se der erro, imprime o erro
};
export default connectDB;
