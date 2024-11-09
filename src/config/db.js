import mongoose from "mongoose";
import {configDotenv } from "dotenv"
configDotenv()

const dbUser = process.env.DB_USER;
const dbPass = process.env.DB_PASS
const connectDB = async () => {
    mongoose
        .connect(`mongodb+srv://${dbUser}:${dbPass}@cluster0.4lhzj.mongodb.net/ConectaBank`) // aqui conecta
        .then(() => console.log('Connected to MongoDB')) // se conectar, imprime isso
        .catch((error) => console.log(error)); // se der erro, imprime o erro
};
export default connectDB;

// token murilo eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im11cmlsb0BnbWFpbC5jb20iLCJub21lIjoiTXVyaWxvIiwiaWF0IjoxNzMxMTU1OTEyLCJleHAiOjE3MzExNTk1MTJ9.70Q86ZFTYoFJ_JW2po8_IvR6JxKtg-7WrBOBnj5xHTU
// token marquinhos eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1hcmNvc0BnbWFpbC5jb20iLCJub21lIjoiTWFyY29zIiwiaWF0IjoxNzMxMTU1OTUwLCJleHAiOjE3MzExNTk1NTB9.R4w92QlMqm0N61pCKHgzmZm4EuBNSMTK3ch3CqEUbOk
