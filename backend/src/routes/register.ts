import express from 'express';
import pool from '../db';

// creating instance of express router(middleware)
const router = express.Router();

// defining route
router.post('/', async(req, res) => {

    // extracting variables form body
    const { name, email, password } = req.body;

    // config the response 

    // checking for presence of credentials 
    if(!name || !email || !password){
    
        // returning response
        return res.status(400).json({error: 'Message: Plz fill in all the details!'});
    }

    // quering the db
    try{

        // making the query 
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