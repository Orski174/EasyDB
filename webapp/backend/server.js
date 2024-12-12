require('dotenv').config();

const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const port = 5000;

app.use(cors());
app.use(express.json());

app.use(express.static(path.join(__dirname, 'build')));

const pool = new Pool({
  user: process.env.DB_USER || 'postgres',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'EasyDB',
  password: process.env.DB_PASSWORD || '123',
  port: process.env.DB_PORT || 5432,
});

module.exports = pool;

const tables = ['Block', 'Block_Categories', 'Consumer', 'Contains_Material', 'Contains_Product', 'Department', 'Department_Occupies', 'Dependents', 'Emp_Occup', 'Employee', 'Equip_Trans', 'Equipment', 'Machine', 'Machine_Trans', 'Maintains_Equip', 'Maintains_Mach', 'Material_Trans', 'Product', 'Product_Category', 'Product_RM', 'Product_Trans', 'Raw_Material', 'Rooms', 'Supplier', 'Warehouse'];

function getPrimaryKey(table) {
  const primaryKey = {
    'Block': 'bk_id',
    'Block_Categories': 'block_id',
    'Consumer': 'con_id',
    'Contains_Material': 'block_id',
    'Contains_Product': 'block_id',
    'Department': 'dep_name',
    'Department_Occupies': 'dep_name',
    'Dependents': 'dependantname',
    'Emp_Occup': 'employeesn',
    'Employee': 'ssn',
    'Equip_Trans': 'supp_id',
    'Equipment': 'equipment_id',
    'Machine': 'machine_nb',
    'Machine_Trans': 'supp_id',
    'Maintains_Equip': 'equipment_id',
    'Maintains_Mach': 'machine_number',
    'Material_Trans': 'mat_name',
    'Product': 'product_name',
    'Product_Category': 'product_name',
    'Product_RM': 'product_name',
    'Product_Trans': 'prod_name',
    'Raw_Material': 'material_name',
    'Rooms': 'room_id',
    'Supplier': 'supp_id',
    'Warehouse': 'wh_name'
  }[table];
  return primaryKey;
}

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

tables.forEach(table => {
  app.post(`/api/${table.toLowerCase()}/update`, async (req, res) => {
    const { row, column, value } = req.body;
    try {
      const primaryKey = getPrimaryKey(table);
      const updateQuery = `UPDATE ${table} SET ${column} = $1 WHERE ${primaryKey} = $2 RETURNING *`;
      const result = await pool.query(updateQuery, [value, row]);
      res.json(result.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).send(`Server Error: ${err.message}`);
    }
  });
});

tables.forEach(table => {
  app.post(`/api/${table.toLowerCase()}/update`, async (req, res) => {
    const { row, column, value } = req.body;
    try {
      const primaryKey = getPrimaryKey(table);
      const updateQuery = `UPDATE ${table} SET ${column} = $1 WHERE ${primaryKey} = $2 RETURNING *`;
      const result = await pool.query(updateQuery, [value, row]);
      res.json(result.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).send(`Server Error: ${err.message}`);
    }
  });
});

tables.forEach(table => {
  app.post(`/api/${table.toLowerCase()}/insert`, async (req, res) => {
    const newRow = req.body;
    try {
      const columns = Object.keys(newRow).join(', ');
      const values = Object.values(newRow);
      const placeholders = values.map((_, index) => `$${index + 1}`).join(', ');

      const insertQuery = `INSERT INTO ${table} (${columns}) VALUES (${placeholders}) RETURNING *`;
      const result = await pool.query(insertQuery, values);
      res.json(result.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).send(`Server Error: ${err.message}`);
    }
  });
});

tables.forEach(table => {
  app.post(`/api/${table.toLowerCase()}/delete`, async (req, res) => {
    const { row } = req.body;
    try {
      const primaryKey = getPrimaryKey(table);
      const deleteQuery = `DELETE FROM ${table} WHERE ${primaryKey} = $1 RETURNING *`;
      const result = await pool.query(deleteQuery, [row]);
      res.json(result.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).send(`Server Error: ${err.message}`);
    }
  });
});

app.post('/api/machine_trans/trans', async (req, res) => {
  const newTransaction = req.body;
  try {
    const columns = Object.keys(newTransaction).join(', ');
    const values = Object.values(newTransaction);
    const placeholders = values.map((_, index) => `$${index + 1}`).join(', ');

    const insertQuery = `INSERT INTO Machine_Trans (${columns}) VALUES (${placeholders}) RETURNING *`;
    const result = await pool.query(insertQuery, values);
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).send(`Server Error: ${err.message}`);
  }
});

app.post('/api/equip_trans/trans', async (req, res) => {
  const newTransaction = req.body;
  try {
    const columns = Object.keys(newTransaction).join(', ');
    const values = Object.values(newTransaction);
    const placeholders = values.map((_, index) => `$${index + 1}`).join(', ');

    const insertQuery = `INSERT INTO Equip_Trans (${columns}) VALUES (${placeholders}) RETURNING *`;
    const result = await pool.query(insertQuery, values);
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).send(`Server Error: ${err.message}`);
  }
});

app.post('/api/product_trans/trans', async (req, res) => {
  const newTransaction = req.body;
  try {
    const columns = Object.keys(newTransaction).join(', ');
    const values = Object.values(newTransaction);
    const placeholders = values.map((_, index) => `$${index + 1}`).join(', ');

    const insertQuery = `INSERT INTO Product_Trans (${columns}) VALUES (${placeholders}) RETURNING *`;
    const result = await pool.query(insertQuery, values);
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).send(`Server Error: ${err.message}`);
  }
});

app.post('/api/material_trans/trans', async (req, res) => {
  const newTransaction = req.body;
  try {
    const columns = Object.keys(newTransaction).join(', ');
    const values = Object.values(newTransaction);
    const placeholders = values.map((_, index) => `$${index + 1}`).join(', ');

    const insertQuery = `INSERT INTO Material_Trans (${columns}) VALUES (${placeholders}) RETURNING *`;
    const result = await pool.query(insertQuery, values);
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).send(`Server Error: ${err.message}`);
  }
});

app.post('/api/query', async (req, res) => {

  const { query } = req.body;
  try {
    const results = await pool.query(query);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});

app.get('/api/Query1', async (req, res) => {
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
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});


app.get('/api/Query2', async (req, res) => {
  try {
    const results = await pool.query(`
      SELECT 
          e.Dep_Name AS department_name,
          SUM(mt.Quantity) AS total_material_used
      FROM 
          Employee e
      JOIN 
          Material_Trans mt ON e.SSN = mt.EmpSSN
      WHERE 
          mt.Transaction_Date >= NOW() - INTERVAL '1 year'
      GROUP BY 
          e.Dep_Name
      ORDER BY 
          total_material_used DESC
      LIMIT 5;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});

app.get('/api/Query3', async (req, res) => {
  try {
    const results = await pool.query(`
      SELECT 
          e.SSN, 
          e.F_Name, 
          e.L_Name,
          COUNT(DISTINCT t.Prod_Name) AS product_count
      FROM 
          Employee e
      JOIN 
          Product_Trans t ON e.SSN = t.EmpSSN
      GROUP BY 
          e.SSN, e.F_Name, e.L_Name
      HAVING 
          COUNT(DISTINCT t.Prod_Name) >= 3;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});

app.get('/api/Query4', async (req, res) => {
  try {
    const results = await pool.query(`
        SELECT 
            e.SSN,
            e.F_Name, 
            e.L_Name,
            COUNT(DISTINCT mm.machine_number || '-' || mm.machine_name) AS machine_count
        FROM 
            Employee e
        JOIN 
            Maintains_Mach mm ON e.SSN = mm.EmpSSN
        GROUP BY 
            e.SSN, e.F_Name, e.L_Name
        HAVING 
            COUNT(DISTINCT mm.machine_number || '-' || mm.machine_name) > 1;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});


app.get('/api/Query5', async (req, res) => {
  try {
    const results = await pool.query(`
        SELECT 
            d.Dep_Name AS department_name, 
            m.Machine_Name,
            m.Machine_Nb, 
            (CURRENT_DATE - m.First_Used) AS total_days_operated
        FROM 
            Machine m
        JOIN 
            Department_Occupies d ON m.Room_ID = d.Room_ID
        ORDER BY 
            d.Dep_Name, total_days_operated DESC;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});



app.get('/api/Query6', async (req, res) => {
  try {
    const results = await pool.query(`
          WITH TotalOrders AS (
              SELECT 
                  SUM(Quantity) AS total_quantity
              FROM 
                  Material_Trans
          ),
          SupplierOrders AS (
              SELECT 
                  s.Supp_ID, 
                  s.Supp_Name, 
                  SUM(mt.Quantity) AS supplier_quantity
              FROM 
                  Supplier s
              JOIN 
                  Material_Trans mt ON s.Supp_ID = mt.Supp_ID
              GROUP BY 
                  s.Supp_ID, s.Supp_Name
          )
          SELECT 
              so.Supp_Name, 
              so.supplier_quantity, 
              ROUND((so.supplier_quantity::DECIMAL / t.total_quantity) * 100, 2) AS percentage
          FROM 
              SupplierOrders so
          CROSS JOIN 
              TotalOrders t
          WHERE 
              (so.supplier_quantity::DECIMAL / t.total_quantity) * 100 > 10;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});



app.get('/api/Query7', async (req, res) => {
  try {
    const results = await pool.query(`
        WITH ProductRevenue AS (
            SELECT 
                w.WH_Name,
                SUM(pt.Total_Revenue) AS product_revenue
            FROM 
                Warehouse w
            JOIN 
                Block b ON w.WH_Name = b.WH_Name
            JOIN 
                Product_Trans pt ON b.BK_ID = pt.Block_ID
            WHERE 
                pt.Transaction_Date >= NOW() - INTERVAL '1 year'
            GROUP BY 
                w.WH_Name
        )
        SELECT 
            WH_Name,
            product_revenue
        FROM 
            ProductRevenue
        ORDER BY 
            product_revenue DESC
        LIMIT 3;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});


app.get('/api/Query8', async (req, res) => {
  try {
    const results = await pool.query(`
          WITH WarehouseCategorySales AS (
              SELECT 
                  w.WH_Name AS warehouse_name,
                  pc.Category AS product_category,
                  SUM(pt.Quantity) AS total_quantity_sold
              FROM 
                  Warehouse w
              JOIN 
                  Block b ON w.WH_Name = b.WH_Name
              JOIN 
                  Product_Trans pt ON b.BK_ID = pt.Block_ID
              JOIN 
                  Product_Category pc ON pt.Prod_Name = pc.Product_Name
              WHERE 
                  pt.Transaction_Date >= NOW() - INTERVAL '1 year'
              GROUP BY 
                  w.WH_Name, pc.Category
          ),
          MaxCategoryPerWarehouse AS (
              SELECT 
                  warehouse_name,
                  product_category,
                  total_quantity_sold
              FROM (
                  SELECT 
                      warehouse_name,
                      product_category,
                      total_quantity_sold,
                      RANK() OVER (PARTITION BY warehouse_name ORDER BY total_quantity_sold DESC) AS rank
                  FROM 
                      WarehouseCategorySales
              ) ranked_categories
              WHERE 
                  rank = 1
          )
          SELECT 
              warehouse_name,
              product_category,
              total_quantity_sold
          FROM 
              MaxCategoryPerWarehouse
          ORDER BY 
              warehouse_name;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});


app.get('/api/Query9', async (req, res) => {
  try {
    const results = await pool.query(`
      WITH EmployeeProductTransactions AS (
            SELECT 
                e.SSN AS employee_ssn,
                CONCAT(e.F_Name, ' ', e.L_Name) AS employee_name,
                COUNT(pt.Prod_Name) AS products_handled
            FROM 
                Employee e
            JOIN 
                Product_Trans pt ON e.SSN = pt.EmpSSN
            WHERE 
                pt.Transaction_Date >= NOW() - INTERVAL '1 year'
            GROUP BY 
                e.SSN, e.F_Name, e.L_Name
        )
        SELECT 
            employee_name,
            products_handled
        FROM 
            EmployeeProductTransactions
        ORDER BY 
            products_handled DESC
        LIMIT 3;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});



app.get('/api/Query10', async (req, res) => {
  try {
    const results = await pool.query(`
      SELECT 
          pt.Prod_Name AS product_name, 
          SUM(pt.Total_Revenue) AS total_sales
      FROM 
          Product_Trans pt
      WHERE 
          pt.Transaction_Date >= CURRENT_DATE - INTERVAL '6 months'
      GROUP BY 
          pt.Prod_Name
      ORDER BY 
          total_sales DESC
      LIMIT 3;
    `);
    res.json(results.rows);
  } catch (err) {
    console.error('Error executing query', err.stack);
    res.status(500).send('Error fetching data');
  }
});






app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});