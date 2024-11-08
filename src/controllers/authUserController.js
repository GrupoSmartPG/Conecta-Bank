import Usuario from '../models/usuarioModel.js'
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import qrcode from "qrcode"
import speakeasy from 'speakeasy'
import { configDotenv } from 'dotenv';
configDotenv()
const SECRET_KEY = process.env.SECRET_KEY;

export const register = async (req, res) => {
    const { nome, email, senha } = req.body;

    if (!nome || !email || !senha) {
        return res.status(400).json({ message: "Todos os campos são obrigatórios." });
    }

    try {
        const userExists = await Usuario.findOne({ email });
        if (userExists) {
            return res.status(400).json({ message: "E-mail já está em uso." });
        }

        const hashedPassword = await bcrypt.hash(senha, 10);
        const newUser = new Usuario({ nome, email, senha: hashedPassword });
        await newUser.save();

        res.status(201).json({ message: "Usuário registrado com sucesso." });
    } catch (err) {
        console.error("Erro ao registrar usuário:", err);
        res.status(500).json({ message: "Erro no servidor", error: err.message });
    }
};

export const login = async (req, res) => {
    const { email, senha } = req.body;

    if (!email || !senha) {
        return res.status(400).json({ message: "E-mail e senha são obrigatórios." });
    }

    try {
        const user = await Usuario.findOne({ email });

        if (!user || !(await bcrypt.compare(senha, user.senha))) {
            return res.status(401).json({ message: "Credenciais inválidas." });
        }

        const token = jwt.sign(
            { email: user.email, nome: user.nome },
            SECRET_KEY,
            { expiresIn: "1h" }
        );

        res.json({ token });
    } catch (err) {
        console.error("Erro ao fazer login:", err);
        res.status(500).json({ message: "Erro no servidor", error: err.message });
    }
};
