-- SAVE TRANSACTION
-- Establece un punto de retorno dentro de una transacción.
-- Un usuario puede establecer un punto de retorno, o marcador, dentro de una transacción.
-- El punto de retorno define una ubicación a la que la transacción puede volver
-- si se cancela parte de la transacción de forma condicional.

-- El siguiente ejemplo se intenta ingresar un producto y luego establecer su precio
-- y de ser posible guardar el usuario que lo ingreso

-----------------------------------------------------------------------------------------------------

-- Entidades necesarias
CREATE TABLE Productos (ProductoID INT, Producto VARCHAR(25), Precio MONEY);
CREATE TABLE ProductosLog (ProductoID INT, Usuario VARCHAR(25));

-----------------------------------------------------------------------------------------------------

-- Abro una transacción
BEGIN TRAN
    -- Inserta el producto
    INSERT INTO Productos VALUES(1,'Televisor',0);
    -- Registra la operación y el usuario que la realizó
    BEGIN TRAN Log
        INSERT INTO ProductosLog VALUES(1, 'JuanPerez');
    ROLLBACK; -- Algo malo ha ocurrido y se revierte la operación
    -- Actualiza el precio
    UPDATE Productos
    SET Precio=100
    WHERE PRODUCTO=1
COMMIT -- Confirma el alta del producto
-- La solicitud COMMIT TRANSACTION no tiene la correspondiente BEGIN TRANSACTION.


SELECT * FROM Productos WHERE ProductoID=1;
------------
(0 rows affected)
SELECT * FROM ProductosLog WHERE ProductoID=1;
------------
(0 rows affected)

---------------------------------------------------------------------------------------------------

-- Abro una transacción
BEGIN TRAN
    -- Inserta el producto
    INSERT INTO Productos VALUES(1,'Televisor',0);
    -- Registra la operación y el usuario que la realizó
    SAVE TRAN registro
        INSERT INTO ProductosLog VALUES(1, 'JuanPerez');
    ROLLBACK TRAN registro -- Algo malo ha ocurrido y se revierte la operación
    -- Actualiza el precio
    UPDATE Productos
    SET Precio=100
    WHERE ProductoID=1;
COMMIT -- Confirma el alta del producto

SELECT * FROM Productos WHERE ProductoID=1;
------------
(1 rows affected)
SELECT * FROM ProductosLog WHERE ProductoID=1;
------------
(0 rows affected)