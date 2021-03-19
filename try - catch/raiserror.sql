-- RAISERROR
/*
Genera un mensaje de error e inicia el procesamiento de errores de la sesión. RAISERROR puede hacer
referencia a un mensaje definido por el usuario almacenado en la vista de catálogo sys.messages o puede
generar un mensaje dinámicamente. El mensaje se devuelve como un mensaje de error de servidor a la
aplicación que realiza la llamada o a un bloque CATCH asociado de una construcción TRY…CATCH. Las
nuevas aplicaciones deben usar THROW en su lugar.
*/

BEGIN TRY
    BEGIN TRANSACTION
        UPDATE [dbo].[Errores] SET [Valor]=1/0 WHERE ID=1;
    COMMIT TRANSACTION
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    RAISERROR (
        'Algo malo ha ocurrido ', -- Mensaje personalizado.
        16,                       -- Severidad.
        1                         -- Estado.
              );
END CATCH
---------------------------------------
Msg 50000, Level 16, State 1, Line 17
Algo malo ha ocurrido