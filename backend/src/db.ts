// connection Pool fromm the 'pg' lib to manage connections efficiently 
import { Pool } from 'pg';

const pool = new Pool(
    {
        user: 'postgres',
        host: 'localhost',
        database: 'time_capsule',
        password: 'Aditya@123',
        port: 5432,
    }
);

// Immediatly invoked functional expression
(async () => {
    try{
        const res = await pool.query('SELECT NOW()');
        console.log('PostgresSQL connected at: ', res.rows[0].now);
    }
    catch(err){
        console.error('DB connection error: ', err);
    }
})();

export default pool;