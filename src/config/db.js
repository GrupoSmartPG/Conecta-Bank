import mongoose from "mongoose";
import {configDotenv } from "dotenv"
configDotenv()

const dbUser = process.env.DB_USER;
const dbPass = process.env.DB_PASS
const connectDB = async () => {
    mongoose
        .connect(`mongodb+srv://${dbUser}:${dbPass}@cluster0.4lhzj.mongodb.net/k`) // aqui conecta
        .then(() => console.log('Connected to MongoDB')) // se conectar, imprime isso
        .catch((error) => console.log(error)); // se der erro, imprime o erro
};
export default connectDB;