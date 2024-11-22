# Database Initialization Script Documentation

This script initializes the database schema and populates it with initial data for a warehouse management system. Below is a detailed description of each table created in the script:

## Tables

### Warehouse
- **WH_Name**: Name of the warehouse (Primary Key)
- **Contact_SSN**: Social Security Number of the contact person (Foreign Key referencing Employee)
- **Contact_Number**: Contact number of the warehouse
- **Address_1**: Primary address line
- **Address_2**: Secondary address line (optional)
- **City**: City where the warehouse is located
- **Zip_code**: Zip code of the warehouse location
- **Area**: Area of the warehouse in square meters

### Supplier
- **Supp_ID**: Supplier ID (Primary Key)
- **Supp_Name**: Name of the supplier
- **Supp_Nb**: Contact number of the supplier
- **Supp_Email**: Email address of the supplier
- **Address_1**: Primary address line
- **Address_2**: Secondary address line (optional)
- **City**: City where the supplier is located
- **Zip_Code**: Zip code of the supplier location

### Raw_Material
- **Material_Name**: Name of the raw material (Primary Key)
- **Category**: Category of the raw material
- **Cost_per_unit**: Cost per unit of the raw material
- **Unit**: Unit of measurement for the raw material

### Product
- **Product_Name**: Name of the product (Primary Key)
- **Price_per_unit**: Price per unit of the product
- **Unit**: Unit of measurement for the product

### Rooms
- **Room_ID**: Room ID (Primary Key)
- **Room_Name**: Name of the room
- **Room_Number**: Room number
- **WH_Name**: Name of the warehouse (Foreign Key referencing Warehouse)

### Block
- **BK_ID**: Block ID (Primary Key)
- **WH_Name**: Name of the warehouse (Foreign Key referencing Warehouse)
- **Area**: Area of the block in square meters
- **Block_Name**: Name of the block

### Block_Categories
- **Block_ID**: Block ID (Foreign Key referencing Block)
- **Category**: Category of the block
- **Primary Key**: Composite key (Block_ID, Category)

### Product_Category
- **Product_Name**: Name of the product (Foreign Key referencing Product)
- **Category**: Category of the product
- **Primary Key**: Composite key (Product_Name, Category)

### Product_RM
- **Product_Name**: Name of the product (Foreign Key referencing Product)
- **Material_Name**: Name of the raw material (Foreign Key referencing Raw_Material)
- **Quantity**: Quantity of the raw material used in the product
- **Primary Key**: Composite key (Product_Name, Material_Name)

### Employee
- **SSN**: Social Security Number (Primary Key)
- **F_Name**: First name
- **L_Name**: Last name
- **Birth_Date**: Birth date
- **Gender**: Gender
- **Extension_Nb**: Extension number (optional)
- **Address_1**: Primary address line
- **Address_2**: Secondary address line (optional)
- **City**: City where the employee resides
- **Zip_Code**: Zip code of the employee's residence
- **Wage**: Wage of the employee
- **Personal_Nb**: Personal contact number
- **SupSSN**: Supervisor's SSN (Foreign Key referencing Employee)
- **Room_ID**: Room ID (Foreign Key referencing Rooms)
- **WH_Name**: Warehouse name (Foreign Key referencing Warehouse)
- **Dep_Name**: Department name

### Emp_Occup
- **EmployeeSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Occupation**: Occupation of the employee
- **Primary Key**: Composite key (EmployeeSSN, Occupation)

### Dependents
- **DependantName**: Name of the dependent (Primary Key)
- **Gender**: Gender of the dependent
- **Relationship**: Relationship to the employee
- **Birth_Day**: Birth date of the dependent
- **RelativeSSN**: SSN of the related employee (Foreign Key referencing Employee)

### Department
- **Dep_Name**: Department name (Primary Key)
- **Contact_Nb**: Contact number (optional)
- **Email**: Email address
- **ManagerSSN**: Manager's SSN (Foreign Key referencing Employee)

### Department_Occupies
- **Dep_Name**: Department name (Foreign Key referencing Department)
- **Room_ID**: Room ID (Foreign Key referencing Rooms)
- **Primary Key**: Composite key (Dep_Name, Room_ID)

### Equipment
- **Equipment_ID**: Equipment ID (Primary Key)
- **Equip_Name**: Name of the equipment
- **First_Used**: Date when the equipment was first used
- **Operation_Cost**: Operation cost of the equipment
- **Room_ID**: Room ID (Foreign Key referencing Rooms)

### Maintains_Equip
- **Equipment_ID**: Equipment ID (Foreign Key referencing Equipment)
- **Cost**: Maintenance cost
- **ME_Descr**: Maintenance description
- **ME_Date**: Maintenance date
- **EmpSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Primary Key**: Composite key (Equipment_ID, ME_Date, EmpSSN)

### Machine
- **Machine_Nb**: Machine number (Primary Key)
- **Machine_Name**: Machine name (Primary Key)
- **First_Used**: Date when the machine was first used
- **Operation_Cost**: Operation cost of the machine
- **Room_ID**: Room ID (Foreign Key referencing Rooms)

### Maintains_Mach
- **Machine_Number**: Machine number (Foreign Key referencing Machine)
- **Machine_Name**: Machine name (Foreign Key referencing Machine)
- **Cost**: Maintenance cost
- **MM_Descr**: Maintenance description
- **MM_Date**: Maintenance date
- **EmpSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Primary Key**: Composite key (Machine_Number, Machine_Name, MM_Date, EmpSSN)

### Material_Trans
- **Mat_Name**: Material name (Foreign Key referencing Raw_Material)
- **Supp_ID**: Supplier ID (Foreign Key referencing Supplier)
- **Transaction_Date**: Transaction date
- **Total_Revenue**: Total revenue from the transaction
- **Quantity**: Quantity of material transacted
- **EmpSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Block_ID**: Block ID (Foreign Key referencing Block)
- **Primary Key**: Composite key (Mat_Name, Supp_ID, Transaction_Date, EmpSSN, Block_ID)

### Consumer
- **Con_ID**: Consumer ID (Primary Key)
- **Consumer_Name**: Name of the consumer
- **Consumer_Nb**: Contact number (optional)
- **Consumer_Email**: Email address (optional)
- **Address_1**: Primary address line
- **Address_2**: Secondary address line (optional)
- **City**: City where the consumer resides
- **Zip_Code**: Zip code of the consumer's residence

### Product_Trans
- **Prod_Name**: Product name (Foreign Key referencing Product)
- **Con_ID**: Consumer ID (Foreign Key referencing Consumer)
- **Transaction_Date**: Transaction date
- **Total_Revenue**: Total revenue from the transaction
- **Quantity**: Quantity of product transacted
- **EmpSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Block_ID**: Block ID (Foreign Key referencing Block)
- **Primary Key**: Composite key (Prod_Name, Con_ID, Transaction_Date, EmpSSN, Block_ID)

### Contains_Material
- **Block_ID**: Block ID (Foreign Key referencing Block)
- **Material_Name**: Material name (Foreign Key referencing Raw_Material)
- **Quantity**: Quantity of material contained in the block
- **Primary Key**: Composite key (Block_ID, Material_Name)

### Contains_Product
- **Block_ID**: Block ID (Foreign Key referencing Block)
- **Product_Name**: Product name (Foreign Key referencing Product)
- **Quantity**: Quantity of product contained in the block
- **Primary Key**: Composite key (Block_ID, Product_Name)

### Equip_Trans
- **Supp_ID**: Supplier ID (Foreign Key referencing Supplier)
- **Cost**: Transaction cost
- **Trans_Date**: Transaction date
- **Equipment_ID**: Equipment ID (Foreign Key referencing Equipment)
- **Quantity**: Quantity of equipment transacted
- **EmpSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Primary Key**: Composite key (Supp_ID, Trans_Date, Equipment_ID, EmpSSN)

### Machine_Trans
- **Supp_ID**: Supplier ID (Foreign Key referencing Supplier)
- **Cost**: Transaction cost
- **Trans_Date**: Transaction date
- **Machine_Nb**: Machine number (Foreign Key referencing Machine)
- **Machine_Name**: Machine name (Foreign Key referencing Machine)
- **EmpSSN**: Employee's SSN (Foreign Key referencing Employee)
- **Quantity**: Quantity of machines transacted
- **Primary Key**: Composite key (Supp_ID, Trans_Date, Machine_Nb, Machine_Name, EmpSSN)

## Initial Data Insertion

The script also includes initial data insertion for the following tables:
- **Supplier**
- **Raw_Material**
- **Product**
- **Consumer**
- **Employee**
- **Warehouse**
- **Rooms**
- **Block**
- **Block_Categories**
- **Product_Category**
- **Product_RM**
- **Material_Trans**
- **Product_Trans**
- **Contains_Material**
- **Contains_Product**
- **Equipment**
- **Machine**
- **Maintains_Equip**
- **Maintains_Mach**
- **Equip_Trans**
- **Machine_Trans**

## Triggers

The script mentions the need for triggers to:
1. Insert a new entry in the materials table when a new material is created.
2. Append the quantity included in a material transaction to the amount present in the block.
3. Subtract the quantity sold from the total quantity present in the block during a product transaction.
4. Create a new entry in the equipment table during an equipment transaction.
5. Create a new entry in the machines table during a machine transaction.

These triggers are to be implemented in a later phase.

## Commit

The script ends with a `COMMIT` statement to save all the changes made during the transaction.
