CREATE TABLE Product_RM (
    Product_Name VARCHAR(100) NOT NULL,
    Material_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT PK_Product_RM PRIMARY KEY (Product_Name, Material_Name),
    CONSTRAINT FK_Product_RM_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name),
    CONSTRAINT FK_Product_RM_Material_Name FOREIGN KEY (Material_Name) REFERENCES Material(Material_Name)
);


-- After inserting into Product and raw_materials tables
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