import { analisarGastos } from "../controllers/analiseController.js";

const analiseRouter = express.Router();

Router.get('/analise/:usrId', analisarGastos);

export default analiseRouter;