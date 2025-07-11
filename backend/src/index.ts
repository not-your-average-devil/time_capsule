import express from 'express';
import './db';
import capsuleRoutes from './routes/capsule';
import registerRoutes from './routes/register';

const app = express();
const PORT = 3000;

app.use(express.json()); 

app.use('/register', registerRoutes); // register yourself route
app.use('/capsules', capsuleRoutes); // register your capsule route

app.get('/', (req, res) => {
  res.send('Server running!');
});

app.listen(PORT, () => {
  console.log(`🚀 Server is running at http://localhost:${PORT}`);
});
