
/*

export const register = async (req, res) => {
    const { nome, email, senha } = req.body;ß

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

*/






import Usuario from '../models/usuarioModel.js';
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import qrcode from "qrcode";
import speakeasy from 'speakeasy';
import { configDotenv } from 'dotenv';
import Joi from 'joi';

configDotenv();

const SECRET_KEY = process.env.SECRET_KEY;

// Registro de usuários
export const register = async (req, res) => {
  const schema = Joi.object({
    nome: Joi.string().min(3).max(50).required(),
    celular: Joi.string()
      .pattern(/^\(\d{2}\)\s\d{4,5}-\d{4}$/)
      .required(),
    email: Joi.string().email().required(),
    senha: Joi.string()
      .min(8)
      .regex(/[A-Z]/, 'uma letra maiúscula')
      .regex(/[a-z]/, 'uma letra minúscula')
      .regex(/\d/, 'um número')
      .regex(/[@$!%*?&]/, 'um caractere especial')
      .required(),
    confirmesenha: Joi.string().valid(Joi.ref('senha')).required(),
  });

  const { error } = schema.validate(req.body, { abortEarly: false });

  if (error) {
    return res.status(422).json({ errors: error.details.map((detail) => detail.message) });
  }

  const { nome, celular, email, senha } = req.body;

  try {
    const userExists = await Usuario.findOne({ email });
    if (userExists) {
      return res.status(422).json({ message: "Email já cadastrado." });
    }

    const salt = await bcrypt.genSalt(12);
    const passwordHash = await bcrypt.hash(senha, salt);

    const user = new Usuario({
      nome,
      celular,
      email,
      senha: passwordHash,
    });

    await user.save();

    res.status(201).json({ message: "Usuário registrado com sucesso!" });
  } catch (error) {
    console.error("Erro no servidor:", error);
    res.status(500).json({ message: "Erro no servidor." });
  }
};

// Login com 2FA
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

    if (user.twoFactorEnabled) {
      return res.status(200).json({
        requires2FA: true,
        message: "Autenticação de dois fatores necessária.",
      });
    }

    const secret = speakeasy.generateSecret({ length: 20 });
    user.twoFactorSecret = secret.base32;
    await user.save();

    const otpauthUrl = speakeasy.otpauthURL({
      secret: secret.base32,
      label: `Conecta:${user.email}`,
      issuer: "Conecta",
      encoding: "base32",
    });

    qrcode.toDataURL(otpauthUrl, (err, dataUrl) => {
      if (err) {
        console.error("Erro ao gerar QR Code:", err);
        return res.status(500).json({ message: "Erro ao gerar QR Code." });
      }
      return res.status(200).json({
        message: "2FA obrigatório. Escaneie o QR Code para configurar.",
        qrCodeUrl: dataUrl,
        setupRequired: true,
      });
    });
  } catch (err) {
    console.error("Erro ao fazer login:", err);
    res.status(500).json({ message: "Erro no servidor." });
  }
};

// Verificação do 2FA
export const verify2FA = async (req, res) => {
  const { email, token } = req.body;

  if (!email || !token) {
    return res.status(400).json({ message: "E-mail e token são obrigatórios." });
  }

  try {
    const user = await Usuario.findOne({ email });

    if (!user) {
      return res.status(404).json({ message: "Usuário não encontrado." });
    }

    const isTokenValid = speakeasy.totp.verify({
      secret: user.twoFactorSecret,
      encoding: "base32",
      token,
      window: 1, // Aceita tokens dentro de uma janela de tempo
    });

    if (!isTokenValid) {
      return res.status(401).json({ message: "Token de autenticação inválido." });
    }

    if (!user.twoFactorEnabled) {
      user.twoFactorEnabled = true;
      await user.save();
    }

    const jwtToken = jwt.sign(
      { id: user._id, email: user.email, nome: user.nome },
      SECRET_KEY,
      { expiresIn: "1h" }
    );

    res.status(200).json({ message: "Login bem-sucedido com 2FA!", token: jwtToken });
  } catch (err) {
    console.error("Erro ao verificar 2FA:", err);
    res.status(500).json({ message: "Erro no servidor." });
  }
};
