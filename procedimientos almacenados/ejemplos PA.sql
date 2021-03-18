
-- El siguiente ejemplo crea un procedimiento almacenado llamado PA_Empleados que obtiene un
-- listado con el Apellido, Nombre y Departamento de los empleados.

CREATE PROCEDURE dbo.PA_Empleados
AS
    SELECT LastName, FirstName, Department
    FROM HumanResources.vEmployeeDepartmentHistory;
GO
-- LLAMADO O INVOCACIÓN
EXEC dbo.PA_Empleados;
GO

-------------------------------------------------------------------------------------------------------------

-- El siguiente ejemplo crea un procedimiento almacenado llamado PA_Empleados que obtiene un
-- listado con el Apellido, Nombre y Departamento de los empleados filtrando por Apellido y Nombre.

CREATE PROCEDURE dbo.PA_Empleados
    @LastName VARCHAR(50),
    @FirstName VARCHAR(50)
AS
    SELECT LastName, FirstName, Department
    FROM HumanResources.vEmployeeDepartmentHistory
    WHERE FirstName = @FirstName AND LastName = @LastName;
GO
-- Invocación al SP pasando los parámetros teniendo en cuenta el orden
EXEC dbo.PA_Empleados 'Ackerman', 'Pilar';
-- Invocación al SP pasando los parámetros sin tener en cuenta el orden
EXEC dbo.PA_Empleados @FirstName = 'Pilar', @LastName = 'Ackerman';
GO

-------------------------------------------------------------------------------------------------------------

-- El siguiente ejemplo crea un procedimiento almacenado llamado PA_Empleados que obtiene un
-- listado con datos del empleado cuyo Apellido y Nombre son pasados como valores de parámetros,
-- por otro lado el procedimiento no recibe valores en sus parámetros mostrará los datos de Arifin
-- Zainal.

CREATE PROCEDURE dbo.PA_Empleados
    @LastName VARCHAR(50)='Arifin',
    @FirstName VARCHAR(50)='Zainal'
AS
    SELECT
        LastName, FirstName,Department
    FROM
        HumanResources.vEmployeeDepartmentHistory
    WHERE
            FirstName = @FirstName
            AND LastName = @LastName;
GO
-- Invocación al SP pasando nombre y apellido del empleado
EXEC dbo.PA_Empleados 'Ackerman', 'Pilar';
-- Invocación al SP usando los valores predeterminados
EXEC dbo.PA_Empleados;
GO

-------------------------------------------------------------------------------------------------------------

-- Crear un procedimiento con parámetros de entrada y salida.
-- El siguiente ejemplo crea un procedimiento almacenado llamado PA_Empleados que recibe Nombre
-- y Apellido del empleado y guarda en el parámetro de salida el nombre del departamento.

CREATE PROCEDURE dbo.PA_Empleados
    @LastName VARCHAR(50)='Arifin',
    @FirstName VARCHAR(50)='Zainal',
    @Department VARCHAR(50) OUTPUT
AS
    SELECT
        @Department=[Department]
    FROM
        HumanResources.vEmployeeDepartmentHistory
    WHERE
        FirstName = @FirstName
        AND LastName = @LastName;
GO
-- Declaro la variable donde se guardará el departamento del empleado
DECLARE @Departamento VARCHAR(50);
-- Obtengo el departamento de Akerman
EXEC dbo.PA_Empleados 'Ackerman', 'Pilar', @Departamento OUTPUT;
GO

-------------------------------------------------------------------------------------------------------------

-- Crear un procedimiento con valor de retorno
-- El siguiente ejemplo crea un procedimiento almacenado llamado PA_Empleados que recibe Nombre
-- y Apellido del empleado y retorna cero si no tiene departamento o uno en caso contrario.

CREATE PROCEDURE dbo.PA_Empleados
    @LastName VARCHAR(50)='Arifin',
    @FirstName VARCHAR(50)='Zainal'
AS
    DECLARE @Department VARCHAR(50);
    
    SELECT
        @Department=[Department]
    FROM
        HumanResources.vEmployeeDepartmentHistory
    WHERE
        FirstName = @FirstName
    AND LastName = @LastName;
    
    IF @Department IS NULL
        RETURN 0;
    ELSE
        RETURN 1;
GO

DECLARE @Resultado TINYINT;
-- Guardo el valor de retorno en la variable resultado
EXEC @Resultado=dbo.PA_Empleados 'Ackerman', 'Pilar';
GO

-------------------------------------------------------------------------------------------------------------

-- Crear un procedimiento combinando parámetros y valor de retorno
-- El siguiente ejemplo crea un procedimiento almacenado llamado PA_Empleados que recibe Nombre
-- y Apellido del empleado y retorna cero si no tiene departamento almacenando Desconocido en el
-- parámetro de salida o uno en caso contrario y el nombre del departamento.

CREATE PROCEDURE dbo.PA_Empleados
    @LastName VARCHAR(50)='Arifin',
    @FirstName VARCHAR(50)='Zainal',
    @Department VARCHAR(50) OUTPUT
AS
    SELECT
        @Department=Department
    FROM
        HumanResources.vEmployeeDepartmentHistory
    WHERE
        FirstName = @FirstName
        AND LastName = @LastName;

    -- Si el empleado no tiene departamento
    IF @Department IS NULL
        BEGIN
            SET @Department='Departamento Desconocido';
            RETURN 0;
        END
    ELSE
        RETURN 1;
GO

DECLARE @Resultado TINYINT;
DECLARE @Departamento VARCHAR(50);
EXEC @Resultado=dbo.PA_Empleados 'Ackerman', 'Pilar', @Departamento OUTPUT;
GO

-------------------------------------------------------------------------------------------------------------

-- En el siguiente ejemplo se muestra cómo insertar datos de una tabla mediante el uso de un
-- procedimiento almacenado.
-- La instrucción INSERT usa la cláusula EXECUTE para llamar a un procedimiento almacenado que
-- contiene la instrucción SELECT.

CREATE TABLE dbo.Empleados
(
    Nombre varchar(50),
    Apellido varchar(50),
    Departamento varchar(50)
);

CREATE PROCEDURE dbo.PA_Empleados
AS
    SELECT LastName, FirstName, Department
    FROM HumanResources.vEmployeeDepartmentHistory;
GO

INSERT INTO dbo.Empleados 
EXEC dbo.PA_Empleados;
GO
