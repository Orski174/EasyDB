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
  password: '123',
  port: 5432,
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

// app.get('/api/logistics', async (req, res) => {
//   try {
//     const results = await pool.query(`
//         WITH ProductPrice AS (
//             SELECT 
//                 Product_Name, 
//                 Price_per_unit AS max_price
//             FROM 
//                 Product
//             WHERE 
//                 Price_per_unit = (SELECT MAX(Price_per_unit) FROM Product)
//         )
//         SELECT 
//             w.WH_Name AS warehouse_name, 
//             pp.Product_Name AS product_name, 
//             pp.max_price
//         FROM 
//             Warehouse w
//         JOIN 
//             Block b ON w.WH_Name = b.WH_Name
//         JOIN
//             Contains_Product cp ON b.BK_ID = cp.Block_ID  
//         JOIN 
//             ProductPrice pp ON cp.Product_Name = pp.Product_Name
//         ORDER BY 
//             pp.max_price DESC;
//     `);
//     res.json(results.rows); // Send the query results as JSON
//   } catch (err) {
//     console.error('Error executing query', err.stack);
//     res.status(500).send('Error fetching data');
//   }
// });



app.get('/api/logistics', async (req, res) => {
  try {
    const results = await pool.query(`
      WITH ProductPrice AS (
            SELECT 
                Product_Name, 
                Price_per_unit AS max_price
            FROM 
                Product
            WHERE 
                Price_per_unit = (SELECT MAX(Price_per_unit) FROM Product)
        )
        SELECT 
            w.WH_Name AS warehouse_name, 
            pp.Product_Name AS product_name, 
            pp.max_price
        FROM 
            Warehouse w
        JOIN 
            Block b ON w.WH_Name = b.WH_Name
        JOIN
            Contains_Product cp ON b.BK_ID = cp.Block_ID  
        JOIN 
            ProductPrice pp ON cp.Product_Name = pp.Product_Name
        ORDER BY 
            pp.max_price DESC;
    `);
    console.log('Query Results:', results.rows); // Debug log
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});


app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});