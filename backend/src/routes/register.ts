import express from 'express';
import pool from '../db';

const router = express.Router();

router.post('/', async(req, res) => {
    const { name, email, password } = req.body;

    if(!name || !email || !password){
        return res.status(400).json({error: 'Message: Plz fill in all the details!'});
    }

    try{
        const result = await pool.query(
            'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING *',
            [name, email, password]
        );
        res.status(201).json(result.rows[0]);
    }
    catch(err){
        console.error('Insert error: ', err);
        res.status(500).json({ error: (err as Error).message});
    }
});

export default router 