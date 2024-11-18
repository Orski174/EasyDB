CREATE TABLE Product_RM (
    Product_Name VARCHAR(50) NOT NULL,
    Material_Name VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Unit VARCHAR(10) NOT NULL,
    CONSTRAINT PK_Product_RM PRIMARY KEY (Product_Name, Material_Name),
    CONSTRAINT FK_Product_RM_Product_Name FOREIGN KEY (Product_Name) REFERENCES Product(Product_Name),
    CONSTRAINT FK_Product_RM_Material_Name FOREIGN KEY (Material_Name) REFERENCES Material(Material_Name)
);