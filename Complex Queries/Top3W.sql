-- Find the top 3 warehouses with the highest revenue from product transactions in the last year

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