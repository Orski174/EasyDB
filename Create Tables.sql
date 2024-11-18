BEGIN;

CREATE TABLE Warehouse (
    WH_Name VARCHAR(100) NOT NULL,
    Contact_SSN CHAR(9) NOT NULL,
    Contact_Number VARCHAR(15) NOT NULL,
    Address_1 VARCHAR(64) NOT NULL,
    Address_2 VARCHAR(64),
    City VARCHAR(50) NOT NULL,
    Zip_code VARCHAR(10) NOT NULL,
    Area INT NOT NULL,
    CONSTRAINT PK_Warehouse PRIMARY KEY (WH_Name)
);

CREATE TABLE Supplier (
    Supp_ID VARCHAR(9) NOT NULL,
    Supp_Name VARCHAR(50) NOT NULL,
    Supp_Nb VARCHAR(15) NOT NULL,
    Supp_Email VARCHAR(30) NOT NULL,
    Address_1 VARCHAR(64) NOT NULL,
    Address_2 VARCHAR(64),
    City VARCHAR(50) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY (Supp_ID)
);

CREATE TABLE Raw_Material (
    Material_Name VARCHAR(50) NOT NULL,
    Cost_per_unit DECIMAL(10, 2) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Raw_Material PRIMARY KEY (Material_Name)
);

CREATE TABLE Product (
    Product_Name VARCHAR(50) NOT NULL,
    Price_per_unit DECIMAL(10, 2) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Product PRIMARY KEY (Product_Name)
);

CREATE TABLE Rooms (
    Room_ID VARCHAR(12) NOT NULL,
    Room_Name VARCHAR(50) NOT NULL,
    Room_Number INT NOT NULL,
    WH_Name VARCHAR(100),
    CONSTRAINT PK_Rooms PRIMARY KEY (Room_ID),
    CONSTRAINT FK_Rooms_WH_Name FOREIGN KEY (WH_Name) REFERENCES Warehouse(WH_Name)
);

CREATE TABLE Block (
    BK_ID VARCHAR(12) NOT NULL,
    WH_Name VARCHAR(100) NOT NULL,
    Area INT NOT NULL,
    Block_Name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Block PRIMARY KEY (BK_ID),
    CONSTRAINT FK_Block_WH_Name FOREIGN KEY (WH_Name) REFERENCES Warehouse(WH_Name)
);

CREATE TABLE Block_Categories (
    Block_ID VARCHAR(12) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Block_Categories PRIMARY KEY (Block_ID, Category),
    CONSTRAINT FK_Block_Categories_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID)
);

CREATE TABLE Block_Characteristics (
    Block_ID VARCHAR(12) NOT NULL,
    Val VARCHAR(30) NOT NULL,
    Types VARCHAR(15) NOT NULL,
    CONSTRAINT PK_Block_Characteristics PRIMARY KEY (Block_ID, Val, Types),
    CONSTRAINT FK_Block_Characteristics_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID)
);

CREATE TABLE Material_Category (
    Material_Name VARCHAR(50) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Material_Category PRIMARY KEY (Material_Name, Category),
    CONSTRAINT FK_Material_Category_Material_Name FOREIGN KEY (Material_Name) REFERENCES Raw_Material(Material_Name)
);

CREATE TABLE Product_Category (
    Product_Name VARCHAR(50) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Product_Category PRIMARY KEY (Product_Name, Category),
    CONSTRAINT FK_Product_Category_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name)
);

CREATE TABLE Product_RM (
    Product_Name VARCHAR(50) NOT NULL,
    Material_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Unit VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Product_RM PRIMARY KEY (Product_Name, Material_Name),
    CONSTRAINT FK_Product_RM_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name),
    CONSTRAINT FK_Product_RM_Material_Name FOREIGN KEY (Material_Name) REFERENCES Raw_Material(Material_Name)
);

CREATE TABLE Employee (
    SSN CHAR(9) NOT NULL,
    F_Name VARCHAR(50) NOT NULL,
    L_Name VARCHAR(50) NOT NULL,
    Birth_Date DATE NOT NULL,
    Gender CHAR(1) NOT NULL,
    Extension_Nb VARCHAR(5),
    Address_1 VARCHAR(64) NOT NULL,
    Address_2 VARCHAR(64),
    City VARCHAR(50) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    Wage DECIMAL(10, 2) NOT NULL,
    Personal_Nb VARCHAR(15) NOT NULL,
    SupSSN CHAR(9),
    Room_ID VARCHAR(12),
    WH_Name VARCHAR(100),
    Dep_Name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (SSN),
    CONSTRAINT FK_Employee_SupSSN FOREIGN KEY (SupSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Employee_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID),
    CONSTRAINT FK_Employee_WH_Name FOREIGN KEY (WH_Name) REFERENCES Warehouse(WH_Name)
);
CREATE TABLE Emp_Occup (
    EmployeeSSN CHAR(9) NOT NULL,
    Occupation VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Emp_Occup PRIMARY KEY (EmployeeSSN, Occupation),
    Constraint FK_Emp_Occup_EmployeeSSN FOREIGN KEY (EmployeeSSN) REFERENCES Employee(SSN)
);
CREATE TABLE Dependents (
    DependantName VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    Relationship VARCHAR(10) NOT NULL,
    Birth_Day DATE NOT NULL,
    RelativeSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Dependents PRIMARY KEY (DependantName),
    CONSTRAINT FK_Dependents_RelativeSSN FOREIGN KEY (RelativeSSN) REFERENCES Employee(SSN)
);

CREATE TABLE Department (
    Dep_Name VARCHAR(50) NOT NULL,
    Contact_Nb VARCHAR(15),
    Email VARCHAR(30) NOT NULL,
    ManagerSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Department PRIMARY KEY (Dep_Name),
    CONSTRAINT FK_Department_ManagerSSN FOREIGN KEY (ManagerSSN) REFERENCES Employee(SSN)
);

CREATE TABLE Department_Occupies (
    Dep_Name VARCHAR(100) NOT NULL,
    Room_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Department_Occupies PRIMARY KEY (Dep_Name, Room_ID),
    CONSTRAINT FK_Department_Occupies_Dep_Name FOREIGN KEY (Dep_Name) REFERENCES Department(Dep_Name),
    CONSTRAINT FK_Department_Occupies_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Equipment (
    Equipment_ID VARCHAR(12) NOT NULL,
    Equip_Name VARCHAR(50) NOT NULL,
    First_Used DATE,
    Operation_Cost DECIMAL(10, 2),
    Room_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Equipment PRIMARY KEY (Equipment_ID),
    CONSTRAINT FK_Equipment_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Maintains_Equip (
    Equipment_ID VARCHAR(12) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    ME_Descr VARCHAR(255) NOT NULL,
    ME_Date DATE NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Maintains_Equip PRIMARY KEY (Equipment_ID, ME_Date, EmpSSN),
    CONSTRAINT FK_Maintains_Equip_Equipment_ID FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID),
    CONSTRAINT FK_Maintains_Equip_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN)
);

CREATE TABLE Machine (
    Machine_Nb INT NOT NULL,
    Machine_Name VARCHAR(50) NOT NULL,
    First_Used DATE,
    Operation_Cost DECIMAL(10, 2),
    Room_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Machine PRIMARY KEY (Machine_Nb, Machine_Name),
    CONSTRAINT FK_Machine_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Maintains_Mach (
    Machine_Number INT NOT NULL,
    Machine_Name VARCHAR(50) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    MM_Descr VARCHAR(255),
    MM_Date DATE NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Maintains_Mach PRIMARY KEY (Machine_Number, Machine_Name, MM_Date, EmpSSN),
    CONSTRAINT FK_Maintains_Mach_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Maintains_Mach_Machine FOREIGN KEY (Machine_Number, Machine_Name) REFERENCES Machine(Machine_Nb, Machine_Name)
);

CREATE TABLE Material_Trans (
    Mat_Name VARCHAR(50) NOT NULL,
    Supp_ID VARCHAR(9) NOT NULL,
    Expiry_Date DATE NOT NULL,
    Transaction_Date DATE NOT NULL,
    Total_Revenue DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Production_Date DATE NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    Block_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Material_Trans PRIMARY KEY (Mat_Name, Supp_ID, Transaction_Date, EmpSSN, Block_ID),
    CONSTRAINT FK_Material_Trans_Mat_Name FOREIGN KEY (Mat_Name) REFERENCES Raw_Material(Material_Name),
    CONSTRAINT FK_Material_Trans_Supp_ID FOREIGN KEY (Supp_ID) REFERENCES Supplier(Supp_ID),
    CONSTRAINT FK_Material_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Material_Trans_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID)
);
CREATE TABLE Consumer (
    Con_ID VARCHAR(12) PRIMARY KEY,
    Consumer_Name VARCHAR(30) NOT NULL,
    Consumer_Nb VARCHAR(15),
    Consumer_Email VARCHAR(30),
    Address_1 VARCHAR(64),
    Address_2 VARCHAR(64),
    City VARCHAR(50),
    Zip_Code VARCHAR(10)
);

CREATE TABLE Product_Trans (
    Prod_Name VARCHAR(50) NOT NULL,
    Con_ID VARCHAR(12) NOT NULL,
    Expiry_Date DATE NOT NULL,
    Transaction_Date DATE NOT NULL,
    Total_Revenue DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Production_Date DATE NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    Block_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Product_Trans PRIMARY KEY (Prod_Name, Con_ID, Transaction_Date, EmpSSN, Block_ID),
    CONSTRAINT FK_Product_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Product_Trans_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID),
    CONSTRAINT FK_Product_Trans_Prod_Name FOREIGN KEY (Prod_Name) REFERENCES Product(Product_Name),
    CONSTRAINT FK_Product_Trans_Con_ID FOREIGN KEY (Con_ID) REFERENCES Consumer(Con_ID)
);

CREATE TABLE Contains_Material (
    Block_ID VARCHAR(12) NOT NULL,
    Material_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_Contains_Material PRIMARY KEY (Block_ID, Material_Name),
    CONSTRAINT FK_Contains_Material_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID),
    CONSTRAINT FK_Contains_Material_Material_Name FOREIGN KEY (Material_Name) REFERENCES Raw_Material(Material_Name)
);

CREATE TABLE Contains_Product (
    Block_ID VARCHAR(12) NOT NULL,
    Product_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_Contains_Product PRIMARY KEY (Block_ID, Product_Name),
    CONSTRAINT FK_Contains_Product_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID),
    CONSTRAINT FK_Contains_Product_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name)
);



CREATE TABLE Equip_Trans (
    Supp_ID VARCHAR(9) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Trans_Date DATE NOT NULL,
    Equipment_ID VARCHAR(12) NOT NULL,
    Quantity INT NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Equip_Trans PRIMARY KEY (Supp_ID, Trans_Date, Equipment_ID, EmpSSN),
    CONSTRAINT FK_Equip_Trans_Supp_ID FOREIGN KEY (Supp_ID) REFERENCES Supplier(Supp_ID),
    CONSTRAINT FK_Equip_Trans_Equipment_ID FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID),
    CONSTRAINT FK_Equip_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN)
);

CREATE TABLE Machine_Trans (
    Supp_ID VARCHAR(9) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Trans_Date DATE NOT NULL,
    Machine_Nb INT NOT NULL,
    Machine_Name VARCHAR(50) NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_Machine_Trans PRIMARY KEY (Supp_ID, Trans_Date, Machine_Nb, Machine_Name, EmpSSN),
    CONSTRAINT FK_Machine_Trans_Supp_ID FOREIGN KEY (Supp_ID) REFERENCES Supplier(Supp_ID),
    CONSTRAINT FK_Machine_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Machine_Trans_Machine FOREIGN KEY (Machine_Nb, Machine_Name) REFERENCES Machine(Machine_Nb, Machine_Name)
);

COMMIT;

ALTER TABLE Warehouse
ADD CONSTRAINT FK_Warehouse_Contact_SSN FOREIGN KEY (Contact_SSN) REFERENCES Employee(SSN);