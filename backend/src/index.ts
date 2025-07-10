import express from 'express';
import './db';
import capsuleRoutes from './routes/capsule';

const app = express();
const PORT = 3000;

app.use(express.json()); // so we can parse JSON in requests

app.use('/capsules', capsuleRoutes); // register your capsule route

app.get('/', (req, res) => {
  res.send('Server running!');
});

app.listen(PORT, () => {
  console.log(`🚀 Server is running at http://localhost:${PORT}`);
});
