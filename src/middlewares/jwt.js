import jwt from "jsonwebtoken";

const SECRET_KEY = process.env.SECRET_KEY;

export const verifyJWT = (req, res, next) => {
  // Verifica a presença do cabeçalho Authorization
  const authHeader = req.header("Authorization");
  if (!authHeader) {
    return res.status(403).json({ message: "Token não fornecido." });
  }

  // Extrai o token removendo o prefixo "Bearer"
  const token = authHeader.replace("Bearer ", "");
  if (!token) {
    return res.status(403).json({ message: "Token malformado." });
  }

  try {
    // Verifica e decodifica o token
    const decoded = jwt.verify(token, SECRET_KEY);

    // Adiciona os dados decodificados do token ao objeto req
    req.user = decoded;
    next(); // Passa para o próximo middleware ou controller
  } catch (err) {
    // Trata diferentes erros do JWT
    if (err.name === "TokenExpiredError") {
      return res.status(401).json({ message: "Token expirado." });
    } else if (err.name === "JsonWebTokenError") {
      return res.status(401).json({ message: "Token inválido." });
    }
    return res.status(500).json({ message: "Erro ao validar o token." });
  }
};
