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
    email: Joi.string().email().required(),
    senha: Joi.string()
      .min(8)
      .regex(/[A-Z]/, 'uma letra maiúscula')
      .regex(/[a-z]/, 'uma letra minúscula')
      .regex(/\d/, 'um número')
      .regex(/[@$!%*?&.]/, 'um caractere especial')
      .required(),
    confirmesenha: Joi.string().valid(Joi.ref('senha')).required(),
  });

  const { error } = schema.validate(req.body, { abortEarly: false });

  if (error) {
    return res.status(422).json({ errors: error.details.map((detail) => detail.message) });
  }

  const { nome, email, senha } = req.body;

  try {
    const userExists = await Usuario.findOne({ email });
    if (userExists) {
      return res.status(422).json({ message: "Email já cadastrado." });
    }

    const salt = await bcrypt.genSalt(12);
    const passwordHash = await bcrypt.hash(senha, salt);

    const user = new Usuario({
      nome,
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

// Login de usuários
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

    // Verifica se o 2FA já está habilitado
    if (user.twoFactorEnabled) {
      return res.status(200).json({
        requires2FA: true,
        message: "Autenticação de dois fatores necessária.",
      });
    }

    // Gera o segredo do 2FA
    const secret = speakeasy.generateSecret({ length: 20 });
    user.twoFactorSecret = secret.base32; // Salva o segredo no banco de dados
    await user.save();

    // Cria a URL otpauthUrl
    const otpauthUrl = speakeasy.otpauthURL({
      secret: secret.base32,
      label: `Conecta:${user.email}`,
      issuer: "Conecta",
      encoding: "base32",
    });

    // gera o QR Code e inclui o secret na resposta
    qrcode.toDataURL(otpauthUrl, (err, dataUrl) => {
      if (err) {
        console.error("Erro ao gerar QR Code:", err);
        return res.status(500).json({ message: "Erro ao gerar QR Code." });
      }

      return res.status(200).json({
        message: "2FA obrigatório. Configure no seu aplicativo.",
        qrCodeUrl: dataUrl, // 64Base do QR Code
        secret: secret.base32, // secret para configuração manual do app autenticador
        setupInstructions: `Adicione manualmente este segredo (${secret.base32}) no seu aplicativo de autenticação se você não puder escanear o QR Code.`,
        setupRequired: true,
      });
    });
  } catch (err) {
    console.error("Erro ao fazer login:", err);
    return res.status(500).json({ message: "Erro no servidor." });
  }
};

// Verificação do 2FA
export const verify2FA = async (req, res) => {
  const { email, token } = req.body;

 
  if (!email || !token) {
    return res.status(400).json({ message: "E-mail e token são obrigatórios." });
  }

  try {
    // Busca o usuário pelo e-mail
    const user = await Usuario.findOne({ email });

    // Verifica se o usuário existe
    if (!user) {
      return res.status(404).json({ message: "Usuário não encontrado." });
    }

    // Verifica se o token 2FA é válido
    const isTokenValid = speakeasy.totp.verify({
      secret: user.twoFactorSecret, // Segredo do usuário armazenado no banco
      encoding: "base32",
      token, // Token fornecido pelo cliente
      window: 1, // Permite uma margem de erro de 1 intervalo de tempo (~30s antes ou depois)
    });

    // Retorna erro se o token for inválido
    if (!isTokenValid) {
      return res.status(401).json({ message: "Token de autenticação inválido." });
    }

    // Ativa o 2FA caso ainda não esteja ativo
    if (!user.twoFactorEnabled) {
      user.twoFactorEnabled = true;
      await user.save();
    }

    // Gera um token  para autenticação do usuário
    const jwtToken = jwt.sign(
      { id: user._id, email: user.email, nome: user.nome },
      process.env.SECRET_KEY, 
      { expiresIn: "1h" }
    );

    // Retorna sucesso com o token
    res.status(200).json({ message: "Login bem-sucedido com 2FA!", token: jwtToken });
  } catch (err) {
    console.error("Erro ao verificar 2FA:", err);
    res.status(500).json({ message: "Erro no servidor." });
  }
};
