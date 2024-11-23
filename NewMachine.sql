-- Insert a new machine into the database, ensuring all necessary fields are provided.
CREATE OR REPLACE PROCEDURE AddNewMachine(
    IN machineNb INT,
    IN machineName VARCHAR(50),
    IN firstUsed DATE,
    IN operationCost DECIMAL(10, 2),
    IN roomId VARCHAR(12),
    IN machineStatus CHAR(1)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Machine (Machine_Nb, Machine_Name, First_Used, Operation_Cost, Room_ID, M_Status)
    VALUES (machineNb, machineName, firstUsed, operationCost, roomId, machineStatus);
END;
$$;

--TestCall
CALL AddNewMachine(9, 'Hydraulic Cutter', '2023-05-10', 2200.00, 'R002', 'S');