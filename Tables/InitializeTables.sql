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
    Material_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(100) NOT NULL,
    Cost_per_unit DECIMAL(10, 2) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Raw_Material PRIMARY KEY (Material_Name)
);

CREATE TABLE Product (
    Product_Name VARCHAR(100) NOT NULL,
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


CREATE TABLE Product_Category (
    Product_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Product_Category PRIMARY KEY (Product_Name, Category),
    CONSTRAINT FK_Product_Category_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name)
);

CREATE TABLE Product_RM (
    Product_Name VARCHAR(100) NOT NULL,
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
    Prod_Name VARCHAR(100) NOT NULL,
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
    Product_Name VARCHAR(100) NOT NULL,
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

ALTER TABLE Warehouse
ADD CONSTRAINT FK_Warehouse_Contact_SSN FOREIGN KEY (Contact_SSN) REFERENCES Employee(SSN);

-- Inserting initial data
-- Suppliers
INSERT INTO Supplier (Supp_ID, Supp_Name, Supp_Nb, Supp_Email, Address_1, Address_2, City, Zip_Code)
VALUES
('S000001', 'Supplier A', '1234567890', 'suppliera@example.com', '123 Street', NULL, 'CityA', '12345'),
('S000002', 'Supplier B', '2345678901', 'supplierb@example.com', '456 Avenue', NULL, 'CityB', '23456'),
('S000003', 'Supplier C', '3456789012', 'supplierc@example.com', '789 Blvd', NULL, 'CityC', '34567'),
('S000004', 'Supplier D', '4567890123', 'supplierd@example.com', '101 Road', NULL, 'CityD', '45678'),
('S000005', 'Supplier E', '5678901234', 'suppliere@example.com', '202 Lane', NULL, 'CityE', '56789'),
('S000006', 'Supplier F', '6789012345', 'supplierf@example.com', '303 Path', NULL, 'CityF', '67890'),
('S000007', 'Supplier G', '7890123456', 'supplierg@example.com', '404 Drive', NULL, 'CityG', '78901'),
('S000008', 'Supplier H', '8901234567', 'supplierh@example.com', '505 Court', NULL, 'CityH', '89012');

-- Raw Materials
INSERT INTO Raw_Material (Material_Name, Category, Cost_per_unit, Unit) 
VALUES
('Steel', 'Metals', 50.00, 'kg'),
('Wood', 'Wood', 500.00, 'm³'),
('Cement', 'Cement', 10.00, 'kg'),
('Plastic', 'Polymers', 30.00, 'kg'),
('Copper', 'Metals', 800.00, 'kg'),
('Aluminum', 'Metals', 275.00, 'kg'),
('Rubber', 'Polymers', 15.00, 'kg'),
('Green Paint', 'Chemicals', 150.00, 'liter'),
('Gypsum', 'Cement', 5.00, 'kg'),
('Glass', 'Finishing Materials', 200.00, 'm²'),
('Sand', 'Aggregates', 20.00, 'kg'),
('Gravel', 'Aggregates', 30.00, 'kg'),
('Clay Bricks', 'Construction Materials', 500.00, '1000 units'),
('Lime', 'Cement', 15.00, 'kg'),
('Asphalt', 'Construction Materials', 80.00, 'kg'),
('Reinforcement Bars', 'Metals', 60.00, 'kg'),
('Plywood', 'Wood', 400.00, 'm²'),
('Fiber Glass', 'Polymers', 100.00, 'kg'),
('Bitumen', 'Construction Materials', 90.00, 'kg'),
('Ceramic Tiles', 'Finishing Materials', 600.00, 'm²'),
('Marble', 'Finishing Materials', 2000.00, 'm²'),
('Granite', 'Finishing Materials', 1800.00, 'm²'),
('PVC', 'Polymers', 40.00, 'kg'),
('Electrical Wires', 'Electrical Materials', 300.00, 'kg'),
('Adhesives', 'Chemicals', 80.00, 'kg'),
('Insulation Foam', 'Insulation', 120.00, 'kg'),
('Glass Wool', 'Insulation', 90.00, 'kg');


INSERT INTO Product (Product_Name, Price_per_unit, Unit)
VALUES
('Steel Pipe, 5m x 150mm OD x 12mm WT', 70.00, 'meter'),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 40.00, 'meter'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 250.00, 'piece'),
('Copper Pipe, 4m x 20mm ID x 1mm WT', 250.00, 'meter'),
('Wooden Door, 220x100x5cm', 600.00, 'piece'),
('Steel Door, 220x100x6cm', 850.00, 'piece'),
('Aluminum Door, 210x95x5cm', 750.00, 'piece'),
('Steel Beam, 8m x 250mm H x 150mm W', 180.00, 'meter'),
('Steel Truss, 4x3x0.7m', 200.00, 'piece'),
('Prefab Shed, 12x6x4m', 6500.00, 'structure'),
('Wooden Decking, 2m x 20cm x 5cm', 50.00, 'meter'),
('PVC Sheet, 2.5m x 1.2m x 0.5cm', 60.00, 'sheet'),
('Steel Reinforcement Bar, 12mm x 6m', 10.00, 'meter'),
('Cement Block, 40x20x20cm', 5.00, 'block'),
('Aluminum Window Frame, 1.5m x 1m', 120.00, 'piece'),
('Fiberglass Insulation Roll, 5m x 1.2m x 0.05m', 150.00, 'roll'),
('Asphalt Shingles, 1m x 0.5m', 20.00, 'sheet'),
('Ceramic Tile, 30x30cm', 2.50, 'tile'),
('Marble Slab, 2m x 1m x 2cm', 250.00, 'slab');

-- Consumers
INSERT INTO Consumer (Con_ID, Consumer_Name, Consumer_Nb, Consumer_Email, Address_1, Address_2, City, Zip_Code)
VALUES
('C000001', 'Consumer A', '1231231230', 'consumera@example.com', '101 Elm Street', NULL, 'CityX', '54321'),
('C000002', 'Consumer B', '2342342341', 'consumerb@example.com', '202 Oak Avenue', NULL, 'CityY', '65432'),
('C000003', 'Consumer C', '3453453452', 'consumerc@example.com', '303 Pine Blvd', NULL, 'CityZ', '76543'),
('C000004', 'Consumer D', '4564564563', 'consumerd@example.com', '404 Maple Road', NULL, 'CityW', '87654'),
('C000005', 'Consumer E', '5675675674', 'consumere@example.com', '505 Cedar Lane', NULL, 'CityV', '98765'),
('C000006', 'Consumer F', '6786786785', 'consumerf@example.com', '606 Birch Path', NULL, 'CityU', '09876'),
('C000007', 'Consumer G', '7897897896', 'consumerg@example.com', '707 Ash Drive', NULL, 'CityT', '10987'),
('C000008', 'Consumer H', '8908908907', 'consumerh@example.com', '808 Walnut Court', NULL, 'CityS', '21098');


--Due to several key constraints when populating the Employee table, we'll be filling WH_Name and Room_ID with null temporarily.
INSERT INTO Employee (SSN, F_Name, L_Name, Birth_Date, Gender, Extension_Nb, Address_1, Address_2, City, Zip_Code, Wage, Personal_Nb, SupSSN, Room_ID, WH_Name, Dep_Name)
VALUES
('E000001', 'John', 'Doe', '1980-01-01', 'M', '101', '1 Main St', NULL, 'City1', '11111', 60000, '1234567890', NULL, NULL, NULL, 'HR'),
('E000002', 'Jane', 'Smith', '1990-02-02', 'F', '102', '2 Main St', NULL, 'City2', '22222', 50000, '1234567891', 'E000001', NULL, NULL, 'Finance'),
('E000003', 'Mike', 'Brown', '1985-03-03', 'M', '103', '3 Main St', NULL, 'City3', '33333', 55000, '1234567892', 'E000001', NULL, NULL, 'Engineering'),
('E000004', 'Sara', 'Davis', '1995-04-04', 'F', '104', '4 Main St', NULL, 'City4', '44444', 52000, '1234567893', 'E000002', NULL, NULL, 'Marketing'),
('E000005', 'James', 'Wilson', '1970-05-05', 'M', '105', '5 Main St', NULL, 'City5', '55555', 70000, '1234567894', NULL, NULL, NULL, 'Operations'),
('E000006', 'Emily', 'Johnson', '1982-06-06', 'F', '106', '6 Main St', NULL, 'City6', '66666', 65000, '1234567895', 'E000003', NULL, NULL, 'HR'),
('E000007', 'Chris', 'Taylor', '1988-07-07', 'M', '107', '7 Main St', NULL, 'City7', '77777', 58000, '1234567896', 'E000003', NULL, NULL, 'Finance'),
('E000008', 'Laura', 'White', '1992-08-08', 'F', '108', '8 Main St', NULL, 'City8', '88888', 59000, '1234567897', 'E000004', NULL, NULL, 'Engineering');

INSERT INTO Warehouse (WH_Name, Contact_SSN, Contact_Number, Address_1, Address_2, City, Zip_code, Area)
VALUES
('WH001', 'E000001', '1231231234', '10 Industrial St', NULL, 'CityA', '12345', 5000),
('WH002', 'E000002', '2342342345', '20 Industrial St', NULL, 'CityB', '23456', 3000),
('WH003', 'E000003', '3453453456', '30 Industrial St', NULL, 'CityC', '34567', 4000),
('WH004', 'E000004', '4564564567', '40 Industrial St', NULL, 'CityD', '45678', 3500),
('WH005', 'E000005', '5675675678', '50 Industrial St', NULL, 'CityE', '56789', 2500),
('WH006', 'E000006', '6786786789', '60 Industrial St', NULL, 'CityF', '67890', 4500),
('WH007', 'E000007', '7897897890', '70 Industrial St', NULL, 'CityG', '78901', 4000),
('WH008', 'E000008', '8908908901', '80 Industrial St', NULL, 'CityH', '89012', 3000);

--Updating Employees with the correct warehouses
UPDATE Employee 
SET WH_Name = 'WH001'
WHERE SSN = 'E000001';

UPDATE Employee 
SET WH_Name = 'WH002'
WHERE SSN = 'E000002';

UPDATE Employee 
SET WH_Name = 'WH003'
WHERE SSN = 'E000003';

UPDATE Employee 
SET WH_Name = 'WH004'
WHERE SSN = 'E000004';

UPDATE Employee 
SET WH_Name = 'WH005'
WHERE SSN = 'E000005';

UPDATE Employee 
SET WH_Name = 'WH006'
WHERE SSN = 'E000006';

UPDATE Employee 
SET WH_Name = 'WH007'
WHERE SSN = 'E000007';

UPDATE Employee 
SET WH_Name = 'WH008'
WHERE SSN = 'E000008';

--------------------------------------

INSERT INTO Rooms (Room_ID, Room_Name, Room_Number, WH_Name)
VALUES
('R001', 'Storage A', 1, 'WH001'),
('R002', 'Storage B', 2, 'WH001'),
('R003', 'Assembly A', 3, 'WH002'),
('R004', 'Assembly B', 4, 'WH002'),
('R005', 'Packaging A', 5, 'WH003'),
('R006', 'Packaging B', 6, 'WH003'),
('R007', 'Dispatch A', 7, 'WH004'),
('R008', 'Dispatch B', 8, 'WH004');



----------------------------------------

--Updating Room_ID in employees

UPDATE Employee 
SET Room_ID = 'R001'
WHERE SSN = 'E000001';

UPDATE Employee 
SET Room_ID = 'R002'
WHERE SSN = 'E000002';

UPDATE Employee 
SET Room_ID = 'R003'
WHERE SSN = 'E000003';

UPDATE Employee 
SET Room_ID = 'R004'
WHERE SSN = 'E000004';

UPDATE Employee 
SET Room_ID = 'R005'
WHERE SSN = 'E000005';

UPDATE Employee 
SET Room_ID = 'R006'
WHERE SSN = 'E000006';

UPDATE Employee 
SET Room_ID = 'R007'
WHERE SSN = 'E000007';

UPDATE Employee 
SET Room_ID = 'R008'
WHERE SSN = 'E000008';

INSERT INTO Block (BK_ID, WH_Name, Area, Block_Name)
VALUES
('B001', 'WH001', 1000, 'Block A'),
('B002', 'WH001', 1200, 'Block B'),
('B003', 'WH002', 800, 'Block C'),
('B004', 'WH002', 900, 'Block D'),
('B005', 'WH003', 700, 'Block E'),
('B006', 'WH003', 850, 'Block F'),
('B007', 'WH004', 600, 'Block G'),
('B008', 'WH004', 750, 'Block H'),
('B009', 'WH005', 500, 'Block I'),
('B010', 'WH005', 600, 'Block J'),
('B011', 'WH006', 900, 'Block K'),
('B012', 'WH006', 1100, 'Block L'),
('B013', 'WH007', 800, 'Block M'),
('B014', 'WH007', 950, 'Block N'),
('B015', 'WH008', 700, 'Block O'),
('B016', 'WH008', 850, 'Block P');

INSERT INTO Block_Categories (Block_ID, Category)
VALUES
('B001', 'Sand Storage'),
('B002', 'Glass Storage'),
('B003', 'Pipes Storage'),
('B004', 'Doors Storage'),
('B005', 'Finished Goods'),
('B006', 'Raw Materials'),
('B007', 'Steel Storage'),
('B008', 'Cement Storage'),
('B009', 'Wooden Planks Storage'),
('B010', 'Paint Storage'),
('B011', 'Tools and Equipment Storage'),
('B012', 'Storage for Cement Bags'),
('B013', 'Storage for Construction Aggregates'),
('B014', 'Electrical Supplies Storage'),
('B015', 'Plumbing Materials Storage');




INSERT INTO Product_Category (Product_Name, Category)
VALUES
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'Metals'),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'Polymers'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'Cement'),
('Copper Pipe, 4m x 20mm ID x 1mm WT', 'Metals'),
('Wooden Door, 220x100x5cm', 'Wood'),
('Steel Door, 220x100x6cm', 'Metals'),
('Aluminum Door, 210x95x5cm', 'Metals'),
('Steel Beam, 8m x 250mm H x 150mm W', 'Metals'),
('Steel Truss, 4x3x0.7m', 'Metals'),
('Prefab Shed, 12x6x4m', 'Wood'),
('Wooden Decking, 2m x 20cm x 5cm', 'Wood'),
('PVC Sheet, 2.5m x 1.2m x 0.5cm', 'Polymers'),
('Steel Reinforcement Bar, 12mm x 6m', 'Metals'),
('Cement Block, 40x20x20cm', 'Cement'),
('Aluminum Window Frame, 1.5m x 1m', 'Metals'),
('Fiberglass Insulation Roll, 5m x 1.2m x 0.05m', 'Polymers'),
('Asphalt Shingles, 1m x 0.5m', 'Construction Materials'),
('Ceramic Tile, 30x30cm', 'Finishing Materials'),
('Marble Slab, 2m x 1m x 2cm', 'Finishing Materials');



INSERT INTO Product_RM (Product_Name, Material_Name, Quantity, Unit)
VALUES
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'Steel', 10.00, 'kg'),
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'PVC', 2.00, 'kg'),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'PVC', 5.00, 'kg'),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'Copper', 3.00, 'kg'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'Cement', 60.00, 'kg'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'Sand', 15.00, 'kg'),
('Copper Pipe, 4m x 20mm ID x 1mm WT', 'Copper', 10.00, 'kg'),
('Wooden Door, 220x100x5cm', 'Wood', 30.00, 'kg'),
('Wooden Door, 220x100x5cm', 'Steel', 5.00, 'kg'),
('Steel Door, 220x100x6cm', 'Steel', 40.00, 'kg'),
('Steel Door, 220x100x6cm', 'Aluminum', 5.00, 'kg'),
('Aluminum Door, 210x95x5cm', 'Aluminum', 30.00, 'kg'),
('Aluminum Door, 210x95x5cm', 'Steel', 8.00, 'kg'),
('Steel Beam, 8m x 250mm H x 150mm W', 'Steel', 100.00, 'kg'),
('Steel Truss, 4x3x0.7m', 'Steel', 150.00, 'kg'),
('Prefab Shed, 12x6x4m', 'Wood', 200.00, 'kg'),
('Prefab Shed, 12x6x4m', 'Steel', 50.00, 'kg'),
('Wooden Decking, 2m x 20cm x 5cm', 'Wood', 40.00, 'kg'),
('PVC Sheet, 2.5m x 1.2m x 0.5cm', 'PVC', 3.00, 'kg'),
('Steel Reinforcement Bar, 12mm x 6m', 'Steel', 15.00, 'kg'),
('Cement Block, 40x20x20cm', 'Cement', 40.00, 'kg'),
('Cement Block, 40x20x20cm', 'Sand', 10.00, 'kg'),
('Aluminum Window Frame, 1.5m x 1m', 'Aluminum', 10.00, 'kg'),
('Aluminum Window Frame, 1.5m x 1m', 'Glass', 2.00, 'kg'),
('Fiberglass Insulation Roll, 5m x 1.2m x 0.05m', 'Fiber Glass', 20.00, 'kg'),
('Asphalt Shingles, 1m x 0.5m', 'Asphalt', 8.00, 'kg'),
('Ceramic Tile, 30x30cm', 'Ceramic Tiles', 2.50, 'tile'),
('Marble Slab, 2m x 1m x 2cm', 'Marble', 25.00, 'kg');

INSERT INTO Material_Trans (Mat_Name, Supp_ID, Transaction_Date, Total_Revenue, Quantity, EmpSSN, Block_ID)
VALUES
('Steel', 'S000001', '2024-01-10', 1000.00, 20, 'E000001', 'B001'),
('Wood', 'S000002', '2024-01-11', 800.00, 40, 'E000002', 'B002'),
('Plastic', 'S000003', '2024-01-12', 200.00, 25, 'E000003', 'B003'),
('Glass', 'S000004', '2024-01-13', 500.00, 15, 'E000004', 'B004'),
('Copper', 'S000005', '2024-01-14', 1200.00, 10, 'E000005', 'B005'),
('Aluminum', 'S000006', '2024-01-15', 750.00, 30, 'E000006', 'B006'),
('Rubber', 'S000007', '2024-01-16', 300.00, 50, 'E000007', 'B007'),
('Fiber Glass', 'S000008', '2024-01-17', 900.00, 35, 'E000008', 'B008');

INSERT INTO Product_Trans (Prod_Name, Con_ID, Transaction_Date, Total_Revenue, Quantity, EmpSSN, Block_ID)
VALUES
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'C000001', '2024-02-01', 1500.00, 10, 'E000001', 'B001'),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'C000002', '2024-02-02', 2250.00, 30, 'E000002', 'B002'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'C000003', '2024-02-03', 1000.00, 20, 'E000003', 'B003'),
('Steel Beam, 8m x 250mm H x 150mm W', 'C000004', '2024-02-04', 3000.00, 10, 'E000004', 'B004'),
('Cement Block, 40x20x20cm', 'C000005', '2024-02-05', 5000.00, 10, 'E000005', 'B005'),
('Wooden Decking, 2m x 20cm x 5cm', 'C000006', '2024-02-06', 4000.00, 20, 'E000006', 'B006'),
('PVC Sheet, 2.5m x 1.2m x 0.5cm', 'C000007', '2024-02-07', 1200.00, 12, 'E000007', 'B007'),
('Steel Reinforcement Bar, 12mm x 6m', 'C000008', '2024-02-08', 2500.00, 10, 'E000008', 'B008');


INSERT INTO Contains_Material (Block_ID, Material_Name, Quantity)
VALUES
('B001', 'Steel', 15),
('B002', 'Wood', 30),
('B003', 'Plastic', 10),
('B004', 'Glass', 8),
('B005', 'Copper', 5),
('B006', 'Aluminum', 25),
('B007', 'Rubber', 40),
('B008', 'Fiber Glass', 20);


INSERT INTO Contains_Product (Block_ID, Product_Name, Quantity)
VALUES
('B001', 'Steel Pipe, 5m x 150mm OD x 12mm WT', 10),
('B002', 'PVC Pipe, 8m x 100mm OD x 7mm WT', 20),
('B003', 'Concrete Pipe, 2m x 800mm ID x 75mm WT', 15),
('B004', 'Steel Beam, 8m x 250mm H x 150mm W', 5),
('B005', 'Cement Block, 40x20x20cm', 7),
('B006', 'Wooden Decking, 2m x 20cm x 5cm', 10),
('B007', 'PVC Sheet, 2.5m x 1.2m x 0.5cm', 12),
('B008', 'Steel Reinforcement Bar, 12mm x 6m', 8);



INSERT INTO Equipment (Equipment_ID, Equip_Name, First_Used, Operation_Cost, Room_ID)
VALUES
('EQ001', 'Excavator', '2020-01-01', 500.00, 'R001'),
('EQ002', 'Forklift', '2021-05-15', 300.00, 'R002'),
('EQ003', 'Concrete Mixer', '2019-03-10', 700.00, 'R003'),
('EQ004', 'Crane', '2018-07-20', 1200.00, 'R004'),
('EQ005', 'Concrete Pump', '2022-02-28', 900.00, 'R005'),
('EQ006', 'Mobile Scaffolding', '2021-09-12', 200.00, 'R006'),
('EQ007', 'Rebar Bender', '2020-11-03', 150.00, 'R007'),
('EQ008', 'Weighing Scale', '2023-01-05', 100.00, 'R008');

INSERT INTO Machine (Machine_Nb, Machine_Name, First_Used, Operation_Cost, Room_ID)
VALUES
(1, 'Concrete Cutting Machine', '2018-01-01', 2000.00, 'R001'),
(2, 'Lathe Machine for Metal', '2019-06-15', 1500.00, 'R002'),
(3, 'Drill Press for Concrete', '2020-03-01', 1200.00, 'R003'),
(4, 'Welding Machine', '2021-09-05', 1800.00, 'R004'),
(5, 'Cement Mixer', '2017-12-10', 2500.00, 'R005'),
(6, 'Hydraulic Press for Steel', '2019-11-20', 2200.00, 'R006'),
(7, '3D Concrete Printer', '2022-07-01', 3000.00, 'R007'),
(8, 'Laser Cutting Machine for Metal', '2023-02-14', 3500.00, 'R008');


INSERT INTO Maintains_Equip (Equipment_ID, Cost, ME_Descr, ME_Date, EmpSSN)
VALUES
('EQ001', 200.00, 'Routine Maintenance', '2024-01-10', 'E000001'),
('EQ002', 150.00, 'Repair', '2024-01-11', 'E000002'),
('EQ003', 300.00, 'Part Replacement', '2024-01-12', 'E000003'),
('EQ004', 500.00, 'Overhaul', '2024-01-13', 'E000004'),
('EQ005', 400.00, 'Routine Maintenance', '2024-01-14', 'E000005'),
('EQ006', 100.00, 'Calibration', '2024-01-15', 'E000006'),
('EQ007', 80.00, 'Repair', '2024-01-16', 'E000007'),
('EQ008', 50.00, 'Routine Maintenance', '2024-01-17', 'E000008');


INSERT INTO Maintains_Mach (Machine_Number, Machine_Name, Cost, MM_Descr, MM_Date, EmpSSN)
VALUES
(1, 'Concrete Cutting Machine', 500.00, 'Routine Maintenance', '2024-02-01', 'E000001'),
(2, 'Lathe Machine for Metal', 400.00, 'Repair', '2024-02-02', 'E000002'),
(3, 'Drill Press for Concrete', 300.00, 'Calibration', '2024-02-03', 'E000003'),
(4, 'Welding Machine', 600.00, 'Overhaul', '2024-02-04', 'E000004'),
(5, 'Cement Mixer', 800.00, 'Part Replacement', '2024-02-05', 'E000005'),
(6, 'Hydraulic Press for Steel', 700.00, 'Routine Maintenance', '2024-02-06', 'E000006'),
(7, '3D Concrete Printer', 900.00, 'Upgrade', '2024-02-07', 'E000007'),
(8, 'Laser Cutting Machine for Metal', 1000.00, 'Routine Maintenance', '2024-02-08', 'E000008');



INSERT INTO Equip_Trans (Supp_ID, Cost, Trans_Date, Equipment_ID, Quantity, EmpSSN)
VALUES
('S000001', 1500.00, '2024-01-05', 'EQ001', 1, 'E000001'),
('S000002', 1200.00, '2024-01-06', 'EQ002', 2, 'E000002'),
('S000003', 1800.00, '2024-01-07', 'EQ003', 1, 'E000003'),
('S000004', 2500.00, '2024-01-08', 'EQ004', 1, 'E000004'),
('S000005', 2000.00, '2024-01-09', 'EQ005', 1, 'E000005'),
('S000006', 1000.00, '2024-01-10', 'EQ006', 2, 'E000006'),
('S000007', 800.00, '2024-01-11', 'EQ007', 3, 'E000007'),
('S000008', 700.00, '2024-01-12', 'EQ008', 1, 'E000008');


INSERT INTO Machine_Trans (Supp_ID, Cost, Trans_Date, Machine_Nb, Machine_Name, EmpSSN, Quantity)
VALUES
('S000001', 3000.00, '2024-01-15', 1, 'Concrete Cutting Machine', 'E000001', 1),
('S000002', 2500.00, '2024-01-16', 2, 'Lathe Machine for Metal', 'E000002', 1),
('S000003', 2000.00, '2024-01-17', 3, 'Drill Press for Concrete', 'E000003', 1),
('S000004', 3500.00, '2024-01-18', 4, 'Welding Machine', 'E000004', 1),
('S000005', 4000.00, '2024-01-19', 5, 'Cement Mixer', 'E000005', 1),
('S000006', 3000.00, '2024-01-20', 6, 'Hydraulic Press for Steel', 'E000006', 1),
('S000007', 4500.00, '2024-01-21', 7, '3D Concrete Printer', 'E000007', 1),
('S000008', 5000.00, '2024-01-22', 8, 'Laser Cutting Machine for Metal', 'E000008', 1),
('S000009', 3000.00, '2024-01-23', 1, 'Concrete Cutting Machine', 'E000001', 1),
('S000010', 2500.00, '2024-01-24', 2, 'Lathe Machine for Metal', 'E000002', 1),
('S000011', 2000.00, '2024-01-25', 3, 'Drill Press for Concrete', 'E000003', 1),
('S000012', 3500.00, '2024-01-26', 4, 'Welding Machine', 'E000004', 1),
('S000013', 4000.00, '2024-01-27', 5, 'Cement Mixer', 'E000005', 1),
('S000014', 3000.00, '2024-01-28', 6, 'Hydraulic Press for Steel', 'E000006', 1),
('S000015', 4500.00, '2024-01-29', 7, '3D Concrete Printer', 'E000007', 1),
('S000016', 5000.00, '2024-01-30', 8, 'Laser Cutting Machine for Metal', 'E000008', 1);


COMMIT;
