BEGIN;

CREATE TABLE Warehouse (
    WH_Name VARCHAR(100) NOT NULL,
    Contact_SSN VARCHAR(9),
    Contact_Number VARCHAR(15) NOT NULL,
    Address_1 VARCHAR(64) NOT NULL,
    Address_2 VARCHAR(64),
    City VARCHAR(50) NOT NULL,
    Zip_code VARCHAR(10) NOT NULL,
    Area INT NOT NULL,
    Constraint PK_Warehouse PRIMARY KEY (WH_Name)
);

CREATE TABLE Supplier (
    Supp_ID VARCHAR(9) NOT NULL,
    Supp_Name VARCHAR(50) NOT NULL,
    Supp_Nb VARCHAR(15) NOT NULL,
    Supp_Email VARCHAR(50) NOT NULL,
    Address_1 VARCHAR(64) NOT NULL,
    Address_2 VARCHAR(64),
    City VARCHAR(50) NOT NULL,
    Zip_Code VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY (Supp_ID)
);

CREATE TABLE Raw_Material (
    Material_Name VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Cost_per_unit DECIMAL(10, 2),
    Unit VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Raw_Material PRIMARY KEY (Material_Name)
);


CREATE TABLE Product (
    Product_Name VARCHAR(100) NOT NULL,
    Price_per_unit DECIMAL(10, 2) NOT NULL,
    Unit VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Product PRIMARY KEY (Product_Name)
);

CREATE TABLE Consumer (
    Con_ID VARCHAR(12) NOT NULL,
    Consumer_Name VARCHAR(50) NOT NULL,
    Consumer_Nb VARCHAR(50),
    Consumer_Email VARCHAR(30),
    Address_1 VARCHAR(64),
    Address_2 VARCHAR(64),
    City VARCHAR(50),
    Zip_Code VARCHAR(10),
    Constraint PK_Consumer PRIMARY KEY (Con_ID)
);



CREATE TABLE Rooms (
    Room_ID VARCHAR(12) NOT NULL,
    Room_Name VARCHAR(50) NOT NULL,
    Room_Number INT NOT NULL,
    WH_Name VARCHAR(100),
    CONSTRAINT PK_Rooms PRIMARY KEY (Room_ID),  
    Constraint FK_Rooms_WH_Name FOREIGN KEY (WH_Name) REFERENCES Warehouse(WH_Name)
);

CREATE TABLE Block (
    BK_ID VARCHAR(12) NOT NULL,
    WH_Name VARCHAR(100) NOT NULL,
    Area INT NOT NULL,
    Block_Name VARCHAR(100) NOT NULL,
    Constraint PK_Block PRIMARY KEY (BK_ID),
    Constraint FK_Block_WH_Name FOREIGN KEY (WH_Name) REFERENCES Warehouse(WH_Name)
);

CREATE TABLE Employee (
    SSN CHAR(9) NOT NULL,
    F_Name VARCHAR(50) NOT NULL,
    L_Name VARCHAR(50) NOT NULL,
    Birth_Date DATE NOT NULL,
    Gender CHAR(2) NOT NULL,
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

CREATE TABLE Department (
    Dep_Name VARCHAR(50) NOT NULL,
    Contact_Nb VARCHAR(15),
    Email VARCHAR(50) NOT NULL,
    ManagerSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Department PRIMARY KEY (Dep_Name),
    CONSTRAINT FK_Department_ManagerSSN FOREIGN KEY (ManagerSSN) REFERENCES Employee(SSN)
);


CREATE TABLE Block_Categories (
    Block_ID VARCHAR(12) NOT NULL,
    Category VARCHAR(50) NOT NULL ,
    CONSTRAINT PK_Block_Categories PRIMARY KEY (Block_ID, Category),
    Constraint FK_Block_Categories_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID)
);

CREATE TABLE Product_Category (
    Product_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Product_Category PRIMARY KEY (Product_Name, Category),
    Constraint FK_Product_Category_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name)
);

CREATE TABLE Product_RM (
    Product_Name VARCHAR(100) NOT NULL,
    Material_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_Product_RM PRIMARY KEY (Product_Name, Material_Name),
    CONSTRAINT FK_Product_RM_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name),
    CONSTRAINT FK_Product_RM_Material_Name FOREIGN KEY (Material_Name) REFERENCES Raw_Material(Material_Name)
);


CREATE TABLE Emp_Occup (
    EmployeeSSN CHAR(9) NOT NULL,
    Occupation VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Emp_Occup PRIMARY KEY (EmployeeSSN, Occupation),
    Constraint FK_Emp_Occup_EmployeeSSN FOREIGN KEY (EmployeeSSN) REFERENCES Employee(SSN)
);


CREATE TABLE Dependents (
    DependantName VARCHAR(50) NOT NULL,
    Gender CHAR(2) NOT NULL,
    Relationship VARCHAR(10) NOT NULL,
    Birth_Day DATE NOT NULL,
    RelativeSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Dependents PRIMARY KEY (DependantName),
    CONSTRAINT FK_Dependents_RelativeSSN FOREIGN KEY (RelativeSSN) REFERENCES Employee(SSN)
);


CREATE TABLE Department_Occupies (
    Dep_Name VARCHAR(100) NOT NULL,
    Room_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Department_Occupies PRIMARY KEY (Dep_Name, Room_ID),
    CONSTRAINT FK_Department_Occupies_Dep_Name FOREIGN KEY (Dep_Name) REFERENCES Department(Dep_Name),
    CONSTRAINT FK_Department_Occupies_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Equipment (
    Equipment_ID INT NOT NULL,
    Equip_Name VARCHAR(50),
    First_Used DATE,
    Operation_Cost DECIMAL(10, 2),
    Room_ID VARCHAR(12),
    E_Status VARCHAR(1) DEFAULT 'S',
    CONSTRAINT PK_Equipment PRIMARY KEY (Equipment_ID),
    CONSTRAINT FK_Equipment_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
    );


CREATE TABLE Maintains_Equip (
    Equipment_ID INT NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    ME_Descr VARCHAR(255) NOT NULL,
    MES_DATE DATE NOT NULL,
    MEE_Date DATE ,
    EmpSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Maintains_Equip PRIMARY KEY (Equipment_ID, MES_Date, EmpSSN),
    CONSTRAINT FK_Maintains_Equip_Equipment_ID FOREIGN KEY (Equipment_ID) REFERENCES Equipment(Equipment_ID),
    CONSTRAINT FK_Maintains_Equip_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN)
);


CREATE TABLE Machine (
    Machine_Nb INT NOT NULL,
    Machine_Name VARCHAR(50) NOT NULL,
    First_Used DATE,
    M_Status VARCHAR(1) DEFAULT 'S',
    Operation_Cost DECIMAL(10, 2),
    Room_ID VARCHAR(12),
    CONSTRAINT PK_Machine PRIMARY KEY (Machine_Nb, Machine_Name),
    CONSTRAINT FK_Machine_Room_ID FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Maintains_Mach (
    Machine_Number INT NOT NULL,
    Machine_Name VARCHAR(50) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    MM_Descr VARCHAR(255),
    MMS_Date DATE NOT NULL,
    MME_Date DATE ,
    EmpSSN CHAR(9) NOT NULL,    
    CONSTRAINT PK_Maintains_Mach PRIMARY KEY (Machine_Number, Machine_Name, MMS_Date, EmpSSN),
    CONSTRAINT FK_Maintains_Mach_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Maintains_Mach_Machine FOREIGN KEY (Machine_Number, Machine_Name) REFERENCES Machine(Machine_Nb, Machine_Name)
);

CREATE TABLE Material_Trans (
    Mat_Name VARCHAR(50) NOT NULL,
    Supp_ID VARCHAR(9) NOT NULL,
    Transaction_Date DATE NOT NULL,
    Total_Revenue DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    Block_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Material_Trans PRIMARY KEY (Mat_Name, Supp_ID, Transaction_Date, EmpSSN, Block_ID),
    CONSTRAINT FK_Material_Trans_Supp_ID FOREIGN KEY (Supp_ID) REFERENCES Supplier(Supp_ID),
    CONSTRAINT FK_Material_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Material_Trans_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID)
);




CREATE TABLE Product_Trans (
    Prod_Name VARCHAR(100) NOT NULL,
    Con_ID VARCHAR(9) NOT NULL,
    Transaction_Date DATE NOT NULL,
    Total_Revenue DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    Block_ID VARCHAR(12) NOT NULL,
    CONSTRAINT PK_Product_Trans PRIMARY KEY (Prod_Name, Con_ID, Transaction_Date, EmpSSN, Block_ID),
    CONSTRAINT FK_Product_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN),
    CONSTRAINT FK_Product_Trans_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID),
    CONSTRAINT FK_Product_Trans_Prod_Name FOREIGN KEY (Prod_Name) REFERENCES Product(Product_Name),
    CONSTRAINT FK_Product_Trans_Conn_ID FOREIGN KEY (Con_ID) REFERENCES Consumer(Con_ID)
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
    Constraint FK_Contains_Product_Block_ID FOREIGN KEY (Block_ID) REFERENCES Block(BK_ID)
);


CREATE TABLE Equip_Trans (
    Supp_ID VARCHAR(9) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Trans_Date DATE NOT NULL,
    Equipment_Name VARCHAR(12) NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Equip_Trans PRIMARY KEY (Supp_ID, Trans_Date, Equipment_Name, EmpSSN),
    CONSTRAINT FK_Equip_Trans_Supp_ID FOREIGN KEY (Supp_ID) REFERENCES Supplier(Supp_ID),
    CONSTRAINT FK_Equip_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN)
);

CREATE TABLE Machine_Trans (
    Supp_ID VARCHAR(9) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    Trans_Date DATE NOT NULL,
    Machine_Nb INT NOT NULL,
    Machine_Name VARCHAR(50) NOT NULL,
    EmpSSN CHAR(9) NOT NULL,
    CONSTRAINT PK_Machine_Trans PRIMARY KEY (Supp_ID, Trans_Date, Machine_Nb, Machine_Name, EmpSSN),
    CONSTRAINT FK_Machine_Trans_Supp_ID FOREIGN KEY (Supp_ID) REFERENCES Supplier(Supp_ID),
    CONSTRAINT FK_Machine_Trans_EmpSSN FOREIGN KEY (EmpSSN) REFERENCES Employee(SSN)
);




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

INSERT INTO Employee (SSN, F_Name, L_Name, Birth_Date, Gender, Extension_Nb, Address_1, Address_2, City, Zip_Code, Wage, Personal_Nb, SupSSN, Room_ID, WH_Name, Dep_Name)
VALUES
('E000001', 'John', 'Doe', '1980-01-01', 'M', '101', '1 Main St', NULL, 'City1', '11111', 60000, '1234567890', NULL, 'R001', 'WH001', 'HR'),
('E000002', 'Jane', 'Smith', '1990-02-02', 'F', '102', '2 Main St', NULL, 'City2', '22222', 62000, '1234567891', 'E000001', 'R002', 'WH002', 'Logistics'),
('E000003', 'Mike', 'Brown', '1985-03-03', 'M', '103', '3 Main St', NULL, 'City3', '33333', 55000, '1234567892', 'E000001', 'R003', 'WH003', 'Finance'),
('E000004', 'Sara', 'Davis', '1995-04-04', 'F', '104', '4 Main St', NULL, 'City4', '44444', 52000, '1234567893', 'E000003', 'R004', 'WH004', 'Operations'),
('E000005', 'James', 'Wilson', '1970-05-05', 'M', '105', '5 Main St', NULL, 'City5', '55555', 70000, '1234567894', NULL, 'R005', 'WH005', 'IT'),
('E000006', 'Emily', 'Johnson', '1982-06-06', 'F', '106', '6 Main St', NULL, 'City6', '66666', 65000, '1234567895', 'E000003', 'R006', 'WH006', 'HR'),
('E000007', 'Chris', 'Taylor', '1988-07-07', 'M', '107', '7 Main St', NULL, 'City7', '77777', 58000, '1234567896', 'E000003', 'R007', 'WH007', 'Logistics'),
('E000008', 'Laura', 'White', '1992-08-08', 'F', '108', '8 Main St', NULL, 'City8', '88888', 59000, '1234567897', 'E000004', 'R008', 'WH008', 'Finance');

ALTER TABLE Warehouse
ADD CONSTRAINT FK_Warehouse_Contact_SSN FOREIGN KEY (Contact_SSN) REFERENCES Employee(SSN);

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



INSERT INTO Product_RM (Product_Name, Material_Name, Quantity)
VALUES
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'Steel', 10.00 ),
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'PVC', 2.00),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'PVC', 5.00),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'Copper', 3.00),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'Cement', 60.00),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'Sand', 15.00),
('Copper Pipe, 4m x 20mm ID x 1mm WT', 'Copper', 10.00),
('Wooden Door, 220x100x5cm', 'Wood', 30.00),
('Wooden Door, 220x100x5cm', 'Steel', 5.00),
('Steel Door, 220x100x6cm', 'Steel', 40.00),
('Steel Door, 220x100x6cm', 'Aluminum', 5.00),
('Aluminum Door, 210x95x5cm', 'Aluminum', 30.00),
('Aluminum Door, 210x95x5cm', 'Steel', 8.00),
('Steel Beam, 8m x 250mm H x 150mm W', 'Steel', 100.00),
('Steel Truss, 4x3x0.7m', 'Steel', 150.00),
('Prefab Shed, 12x6x4m', 'Wood', 200.00),
('Prefab Shed, 12x6x4m', 'Steel', 50.00),
('Wooden Decking, 2m x 20cm x 5cm', 'Wood', 40.00),
('PVC Sheet, 2.5m x 1.2m x 0.5cm', 'PVC', 3.00),
('Steel Reinforcement Bar, 12mm x 6m', 'Steel', 15.00),
('Cement Block, 40x20x20cm', 'Cement', 40.00),
('Cement Block, 40x20x20cm', 'Sand', 10.00),
('Aluminum Window Frame, 1.5m x 1m', 'Aluminum', 10.00),
('Aluminum Window Frame, 1.5m x 1m', 'Glass', 2.00),
('Fiberglass Insulation Roll, 5m x 1.2m x 0.05m', 'Fiber Glass', 20.00),
('Asphalt Shingles, 1m x 0.5m', 'Asphalt', 8.00),
('Ceramic Tile, 30x30cm', 'Ceramic Tiles', 2.50),
('Marble Slab, 2m x 1m x 2cm', 'Marble', 25.00);

INSERT INTO Material_Trans (Mat_Name, Supp_ID, Transaction_Date, Total_Revenue, Quantity, Unit, Category, EmpSSN, Block_ID)
VALUES
('Steel', 'S000001', '2024-01-10', 1000.00, 20, 'kg', 'Metals', 'E000001', 'B001'),
('Wood', 'S000002', '2024-01-11', 800.00, 40, 'm³', 'Wood', 'E000002', 'B002'),
('Plastic', 'S000003', '2024-01-12', 200.00, 25, 'kg', 'Polymers', 'E000003', 'B003'),
('Glass', 'S000004', '2024-01-13', 500.00, 15, 'm²', 'Finishing Materials', 'E000004', 'B004'),
('Copper', 'S000005', '2024-01-14', 1200.00, 10, 'kg', 'Metals', 'E000005', 'B005'),
('Aluminum', 'S000006', '2024-01-15', 750.00, 30, 'kg', 'Metals', 'E000006', 'B006'),
('Rubber', 'S000007', '2024-01-16', 300.00, 50, 'kg', 'Polymers', 'E000007', 'B007'),
('Fiber Glass', 'S000008', '2024-01-17', 900.00, 35, 'kg', 'Polymers', 'E000008', 'B008');

-- here we have to create a trigger that inserts a new entry in the materials table, creating a new material so we have to add unit in this 
-- table to specify the unit later on in the transactions table that would violated 3NF property discussed in wednesday's lecture but that is for phase 4
-- we also have to create a trigger that would append the quantity included in this certain transaction to the amount present in the block(contains material)


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

--  create a trigger that would subtract the quantity sold from the total quantity present in the block in a certain warehouse(Contains product)


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



INSERT INTO Equipment (Equipment_ID, Equip_Name, First_Used, Operation_Cost, Room_ID, E_Status)
VALUES
('0000001', 'Excavator', '2020-01-01', 500.00, 'R001', 'S'),
('0000002', 'Forklift', '2021-05-15', 300.00, 'R002', 'S'),
('0000003', 'Concrete Mixer', '2019-03-10', 700.00, 'R003', 'S'),
('0000004', 'Crane', '2018-07-20', 1200.00, 'R004', 'S'),
('0000005', 'Concrete Pump', '2022-02-28', 900.00, 'R005', 'S'),
('0000006', 'Mobile Scaffolding', '2021-09-12', 200.00, 'R006', 'S'),
('0000007', 'Rebar Bender', '2020-11-03', 150.00, 'R007', 'S'),
('0000008', 'Weighing Scale', '2023-01-05', 100.00, 'R008', 'S');

INSERT INTO Machine (Machine_Nb, Machine_Name, First_Used, Operation_Cost, Room_ID, M_Status)
VALUES
(1, 'Concrete Cutting Machine', '2018-01-01', 2000.00, 'R001', 'S'),
(2, 'Lathe Machine for Metal', '2019-06-15', 1500.00, 'R002', 'S'),
(3, 'Drill Press for Concrete', '2020-03-01', 1200.00, 'R003', 'M'),
(4, 'Welding Machine', '2021-09-05', 1800.00, 'R004', 'M'),
(5, 'Cement Mixer', '2017-12-10', 2500.00, 'R005', 'A'),
(6, 'Hydraulic Press for Steel', '2019-11-20', 2200.00, 'R006', 'A'),
(7, '3D Concrete Printer', '2022-07-01', 3000.00, 'R007', 'A'),
(8, 'Laser Cutting Machine for Metal', '2023-02-14', 3500.00, 'R008', 'A');



INSERT INTO Maintains_Equip (Equipment_ID, Cost, ME_Descr, MES_DATE, MEE_Date, EmpSSN)
VALUES
('0000001', 200.00, 'Routine Maintenance', '2024-01-10', '2024-01-11', 'E000001'),
('0000002', 150.00, 'Repair', '2024-01-11', '2024-01-13', 'E000002'),
('0000003', 300.00, 'Part Replacement', '2024-01-08', '2024-01-12', 'E000003'),
('0000004', 500.00, 'Overhaul', '2024-01-13', '2024-01-13', 'E000004'),
('0000005', 400.00, 'Routine Maintenance', '2024-01-14', '2024-01-14', 'E000005'),
('0000006', 100.00, 'Calibration', '2024-01-11', '2024-01-15', 'E000006'),
('0000007', 80.00, 'Repair', '2024-01-14', '2024-01-16', 'E000007'),
('0000008', 50.00, 'Routine Maintenance', '2024-01-17', '2024-01-19', 'E000008');


INSERT INTO Maintains_Mach (Machine_Number, Machine_Name, Cost, MM_Descr, MMS_Date, MME_Date, EmpSSN)
VALUES
(4, 'Welding Machine', 600.00, 'Overhaul', '2024-02-04', NULL, 'E000004'),
(5, 'Cement Mixer', 800.00, 'Part Replacement', '2024-02-05', NULL, 'E000005'),
(6, 'Hydraulic Press for Steel', 700.00, 'Routine Maintenance', '2024-02-06', NULL, 'E000006'),
(7, '3D Concrete Printer', 900.00, 'Upgrade', '2024-02-07', NULL, 'E000007'),
(8, 'Laser Cutting Machine for Metal', 1000.00, 'Routine Maintenance', '2024-02-08', NULL, 'E000008');



INSERT INTO Equip_Trans (Supp_ID, Cost, Trans_Date, Equipment_Name, EmpSSN)
VALUES
('S000001', 1500.00, '2024-01-05', 'Laptop', 'E000001'),
('S000002', 1200.00, '2024-01-06', 'Printer', 'E000002'),
('S000003', 1800.00, '2024-01-07', 'Projector', 'E000003'),
('S000004', 2500.00, '2024-01-08', 'Scanner', 'E000004'),
('S000005', 2000.00, '2024-01-09', 'Desktop', 'E000005'),
('S000006', 1000.00, '2024-01-10', 'Tablet', 'E000006'),
('S000007', 800.00, '2024-01-11', 'Monitor', 'E000007'),
('S000008', 700.00, '2024-01-12', 'Keyboard', 'E000008');



INSERT INTO Machine_Trans (Supp_ID, Cost, Trans_Date, Machine_Nb, Machine_Name, EmpSSN)
VALUES
('S000001', 3000.00, '2024-01-15', 1, 'Concrete Cutting Machine', 'E000001'),
('S000002', 2500.00, '2024-01-16', 2, 'Lathe Machine for Metal', 'E000002'),
('S000003', 2000.00, '2024-01-17', 3, 'Drill Press for Concrete', 'E000003'),
('S000004', 3500.00, '2024-01-18', 4, 'Welding Machine', 'E000004'),
('S000005', 4000.00, '2024-01-19', 5, 'Cement Mixer', 'E000005'),
('S000006', 3000.00, '2024-01-20', 6, 'Hydraulic Press for Steel', 'E000006'),
('S000007', 4500.00, '2024-01-21', 7, '3D Concrete Printer', 'E000007'),
('S000008', 5000.00, '2024-01-22', 8, 'Laser Cutting Machine for Metal', 'E000008');


INSERT INTO Department (Dep_Name, Contact_Nb, Email, ManagerSSN)
VALUES
('HR', '1112223333', 'hr@example.com', 'E000001'),
('Logistics', '4445556666', 'logistics@example.com', 'E000002'),
('Finance', '7778889999', 'finance@example.com', 'E000003'),
('Operations', '3334445555', 'operations@example.com', 'E000004'),
('IT', '9998887777', 'it@example.com', 'E000005');

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Dep_Name FOREIGN KEY (Dep_Name) REFERENCES Department(Dep_Name);


INSERT INTO Emp_Occup (EmployeeSSN, Occupation)
VALUES
('E000001', 'Manager'),
('E000002', 'Supervisor'),
('E000003', 'Technician'),
('E000004', 'Clerk'),
('E000005', 'Engineer'),
('E000006', 'Consultant'),
('E000007', 'Analyst'),
('E000008', 'Operator');

INSERT INTO Dependents (DependantName, Gender, Relationship, Birth_Day, RelativeSSN)
VALUES
('Emily Doe', 'F', 'Daughter', '2010-05-15', 'E000001'),
('Michael Doe', 'M', 'Son', '2012-08-20', 'E000001'),
('Sophia Smith', 'F', 'Daughter', '2015-09-10', 'E000002'),
('Liam Brown', 'M', 'Son', '2018-11-30', 'E000003'),
('Olivia Davis', 'F', 'Daughter', '2017-04-25', 'E000004');


INSERT INTO Department_Occupies (Dep_Name, Room_ID)
VALUES
('HR', 'R001'),
('Logistics', 'R002'),
('Finance', 'R003'),
('Operations', 'R004'),
('IT', 'R005');




-- Adding more transactions for E000001
INSERT INTO Product_Trans (Prod_Name, Con_ID, Transaction_Date, Total_Revenue, Quantity, EmpSSN, Block_ID)
VALUES
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'C000002', '2024-02-09', 1200.00, 5, 'E000001', 'B001'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'C000003', '2024-02-10', 2500.00, 3, 'E000001', 'B001');

-- Adding more transactions for E000002
INSERT INTO Product_Trans (Prod_Name, Con_ID, Transaction_Date, Total_Revenue, Quantity, EmpSSN, Block_ID)
VALUES
('Steel Beam, 8m x 250mm H x 150mm W', 'C000004', '2024-02-09', 3000.00, 2, 'E000002', 'B002'),
('Wooden Door, 220x100x5cm', 'C000005', '2024-02-10', 1800.00, 1, 'E000002', 'B002');

-- Adding more transactions for E000003
INSERT INTO Product_Trans (Prod_Name, Con_ID, Transaction_Date, Total_Revenue, Quantity, EmpSSN, Block_ID)
VALUES
('Aluminum Door, 210x95x5cm', 'C000006', '2024-02-11', 1500.00, 1, 'E000003', 'B003'),
('Fiberglass Insulation Roll, 5m x 1.2m x 0.05m', 'C000007', '2024-02-12', 1200.00, 2, 'E000003', 'B003'),
('Asphalt Shingles, 1m x 0.5m', 'C000008', '2024-02-13', 800.00, 3, 'E000003', 'B003');



--Adding more Maintains_Mach entries
INSERT INTO Maintains_Mach (Machine_Number, Machine_Name, Cost, MM_Descr, MMS_Date, MME_Date, EmpSSN)
VALUES
(3, 'Drill Press for Concrete', 2000.00, 'Routine Maintenance', '2024-03-01', NULL, 'E000004');



--Adding more products and product_trans
INSERT INTO Product (Product_Name, Price_per_unit, Unit)
VALUES
('Reinforced Steel Beam', 120.00, 'meter');


INSERT INTO Product_Trans (Prod_Name, Con_ID, Transaction_Date, Total_Revenue, Quantity, EmpSSN, Block_ID)
VALUES
('Reinforced Steel Beam', 'C000001', '2024-07-01', 2400.00, 20, 'E000001', 'B001'),
('Steel Pipe, 5m x 150mm OD x 12mm WT', 'C000002', '2024-06-15', 3200.00, 25, 'E000002', 'B002'),
('Concrete Pipe, 2m x 800mm ID x 75mm WT', 'C000003', '2024-05-20', 5000.00, 30, 'E000003', 'B003'),
('PVC Pipe, 8m x 100mm OD x 7mm WT', 'C000004', '2024-07-10', 1500.00, 10, 'E000004', 'B004'),
('Wooden Door, 220x100x5cm', 'C000005', '2024-06-25', 4500.00, 15, 'E000005', 'B005');



COMMIT;
