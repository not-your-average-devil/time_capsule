import express from 'express';
import pool from '../db';

const router = express.Router();

router.post('/', async (req, res) => {
  const { message, unlockDate } = req.body;

  if (!message || !unlockDate) {
    return res.status(400).json({ error: 'Message and unlockDate is required!' });
  }

  try {
    const result = await pool.query(
      'INSERT INTO capsules (message, unlock_date) VALUES ($1, $2) RETURNING *',
      [message, unlockDate]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Insert error:', err);
    res.status(500).json({ error: (err as Error).message });
  }
});

router.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM capsules ORDER BY id DESC');
    res.status(200).json(result.rows);
  } catch (err) {
    console.error('Fetch error:', err);
    res.status(500).json({ error: (err as Error).message });
  }
});


export default router;
