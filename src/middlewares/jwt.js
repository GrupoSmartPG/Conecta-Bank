import jwt from "jsonwebtoken";
import Usuario from "../models/usuarioModel.js";

const SECRET_KEY = process.env.SECRET_KEY;

export const verifyJWT = (req, res, next) => {
    const token = req.header("Authorization")?.replace("Bearer ", "");
    if (!token) return res.status(403).json({ message: "Token não fornecido" });
  
    try {
      const decoded = jwt.verify(token, SECRET_KEY);
      req.user = decoded;
      next();
    } catch (err) {
      res.status(401).json({ message: "Token inválido" });
    }
  };