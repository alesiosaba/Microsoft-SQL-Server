-- IMPLICIT_TRANSACTIONS
-- Establece el modo BEGIN TRANSACTION en implícito para la conexión.
-- SET IMPLICIT_TRANSACTIONS ON

----------------------------------------------------------------------------------------------------------

SET IMPLICIT_TRANSACTIONS ON
-- En este caso no es necesario abrir una transacción explícita y se confirma el
-- UPDATE.
UPDATE production.product
    SET ListPrice= 50
    WHERE ProductId= 707;
COMMIT;

SELECT ListPrice FROM Production.Product WHERE ProductId= 707;
---------->
50

-- Es necesario abrir una transacción de manera explícita.
SET IMPLICIT_TRANSACTIONS OFF
-- En este caso no se abre ninguna transacción por lo que genera un error.
UPDATE production.product
    SET ListPrice= 0
    WHERE ProductId= 707;
ROLLBACK;
----------
ERROR: La solicitud ROLLBACK TRANSACTION no tiene la correspondiente BEGIN TRANSACTION.

SET IMPLICIT_TRANSACTIONS OFF
-- En este caso se abre una transacción explícita y se confirma el UPDATE.
BEGIN TRAN
    UPDATE production.product
    SET ListPrice= 1000
    WHERE ProductId= 707;
COMMIT;

SELECT ListPrice FROM Production.Product WHERE ProductId= 707;
---------->
1000