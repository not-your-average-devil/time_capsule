import express from 'express';
import pool from '../db';

const router = express.Router();

router.post('/', async(req, res) => {

    const { email, password } = req.body;

    if(!email || !password){
        return res.status(400).json(({error : 'Bad Request: plz fill in all credentials!'}));
    }

    try{

        const result = await pool.query(

            // over here -> $1 insert the first value from the array I pass as the second argument to pool.query()
            'SELECT * FROM users WHERE email = $1', 
            [email], 
        );
        
        if(result.rows.length === 0){
            return res.status(401).json({ err: 'Invalid credentials (email not found)'});
        }

        const user = result.rows[0];

        if(user.password != password){
            return res.status(401).json({ error: 'Invalid credentials (password does not match)'});
        }

        res.status(200).json(
            {
                id: user.id,
                name: user.name, 
                email: user.email,
                password: user.password,
            }
        );
    }

    catch(err){
        console.error('Login error: ', err);
        res.status(500).json({ error: (err as Error).message });
    }
})

export default router;