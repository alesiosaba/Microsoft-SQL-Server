-- El siguiente ejemplo abre una transacción explícita y confirma la operación DELETE.

BEGIN TRANSACTION;
DELETE FROM HumanResources.JobCandidate
    WHERE Job Candidate ID = 13;
COMMIT;

-- El siguiente ejemplo abre una transacción explícita y revierte la operación INSERT.

CREATE TABLE ValueTable (id INT);
BEGIN TRANSACTION;
    INSERT INTO ValueTable VALUES(1);
ROLLBACK;

-- El siguiente ejemplo abre una transacción explícita con el nombre Candidatos y confirma la operación DELETE.

BEGIN TRANSACTION Candidatos;
DELETE FROM HumanResources.JobCandidate
    WHERE JobCandidateID = 13;
COMMIT TRANSACTION Candidatos;

-- El siguiente ejemplo se nos solicita aumentar el precio de un producto,
-- con la condición que su nuevo valor debe superar al promedio.
-- Si el nuevo valor cumple con la condición se confirma de lo contrario se revierte la transacción.

BEGIN TRANSACTION
    DECLARE @Promedio Money;
    SELECT @Promedio=AVG(ListPrice) FROM Production.Product;
    
    UPDATE Production.Product
    SET ListPrice=ListPrice*1.5
    WHERE ProductId=707;
    
    IF (SELECT ListPrice FROM Production.Product WHERE ProductId=707)>@Promedio
        COMMIT TRANSACTION;
    ELSE
        ROLLBACK TRANSACTION;
GO