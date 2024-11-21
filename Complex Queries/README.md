# Complex SQL Queries

This document provides a collection of complex SQL queries designed to extract meaningful insights from a database. Each query addresses a specific business requirement and demonstrates advanced SQL techniques.
## Queries

### 1. Top 3 Products with Highest Sales in the Last 6 Months
This query retrieves the top 3 products with the highest sales in the last 6 months, including their supplier details. It joins the `Orders`, `Products`, and `Suppliers` tables, calculates total sales, and orders the results in descending order of sales.

### 2. Employees Operating More Than One Type of Machine
This query lists the names of employees who operate more than one type of machine. It joins the `Employees`, `Machine_Operation`, and `Machines` tables, counts distinct machine types operated by each employee, and filters those with more than one type.

### 3. Departments with Highest Utilization of Raw Materials Over the Last Year
This query identifies departments with the highest utilization of raw materials over the last year. It joins the `Departments`, `Production_Records`, and `Raw_Material_Usage` tables, sums the quantity of raw materials used, and orders the results in descending order.

### 4. Employees Working on Orders with at Least 3 Different Products
This query retrieves the names and details of employees who worked on orders with at least 3 different products. It joins the `Employees`, `Order_Assignments`, and `Orders` tables, counts distinct products per employee, and filters those with at least 3 products.

### 5. Warehouses Storing the Most Expensive Product
This query finds warehouses storing the most expensive product and its details. It uses a common table expression (CTE) to find the maximum product price, then joins the `Warehouses`, `Inventory`, and `Products` tables to retrieve the relevant details.

### 6. Suppliers Contributing to at Least 25% of Total Orders
This query detects suppliers whose products contribute to at least 25% of the total orders in the factory. It uses CTEs to calculate total orders and supplier-specific orders, then filters suppliers meeting the 25% threshold.

### 7. Machines with Longest Cumulative Hours by Department
This query finds the machines that have operated for the longest cumulative hours, grouped by department. It joins the `Machines`, `Machine_Operation`, and `Departments` tables, sums operation hours, and orders the results by department and total hours.

### 8. Frequently Ordered Product Pairs
This query finds pairs of products frequently ordered together (at least 5 times). It joins the `Orders` table with itself to find pairs of products in the same order, counts occurrences, and filters pairs ordered together at least 5 times.

## Usage
These queries can be executed in any SQL-compliant database system. Ensure that the database schema includes the relevant tables and columns as referenced in the queries.