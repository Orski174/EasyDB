const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const port = 5000;

app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'EasyDB',
  password: 'omar123',
  port: 5432,
});

app.get('/api/data', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM Employee');
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Server Error');
  }
});
const tables = ['Block', 'Block_Categories', 'Consumer', 'Contains_Material', 'Contains_Product', 'Department', 'Department_Occupies', 'Dependents', 'Emp_Occup', 'Employee', 'Equip_Trans', 'Equipment', 'Machine', 'Machine_Trans', 'Maintains_Equip', 'Maintains_Mach', 'Material_Trans', 'Product', 'Product_Category', 'Product_RM', 'Product_Trans', 'Raw_Material', 'Rooms', 'Supplier', 'Warehouse'];

tables.forEach(table => {
    app.get(`/api/${table.toLowerCase()}`, async (req, res) => {
        try {
            const result = await pool.query(`SELECT * FROM ${table}`);
            res.json(result.rows);
        } catch (err) {
            console.error(err.message);
            res.status(500).send('Server Error');
        }
    });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});