-- TRY - CATCH
-- Si se produce un error en el bloque TRY, el control se transfiere a otro grupo de instrucciones que está
-- incluido en un bloque CATCH.

BEGIN TRY
    BEGIN TRANSACTION
        INSERT [dbo].[Errores](id) VALUES (1)
        UPDATE [dbo].[Errores] SET [Valor]=1/0 WHERE ID=1;
    COMMIT TRANSACTION
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH

SELECT * FROM [dbo].[Errores];

