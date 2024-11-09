import jwt from "jsonwebtoken";

const generateToken = (userId) => {
  const secret = process.env.SECRET_KEY;

  return jwt.sign({ id: userId }, secret, { expiresIn: '1h' });
};

export default generateToken;
