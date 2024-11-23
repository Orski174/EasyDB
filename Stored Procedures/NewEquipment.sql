CREATE OR REPLACE PROCEDURE AddNewEquipment(
    IN equipmentId INT,
    IN equipmentName VARCHAR(50),
    IN firstUsed DATE,
    IN operationCost DECIMAL(10, 2),
    IN roomId VARCHAR(12),
    IN equipmentStatus CHAR(1)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Equipment (Equipment_ID, Equip_Name, First_Used, Operation_Cost, Room_ID, E_Status)
    VALUES (equipmentId, equipmentName, firstUsed, operationCost, roomId, equipmentStatus);
END;
$$;

--TestCall
CALL AddNewEquipment(9, 'Hydraulic Jack', '2024-01-10', 1500.00, 'R004', 'S');