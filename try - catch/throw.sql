-- THROW
-- Produce una excepción y transfiere la ejecución a un bloque CATCH de una construcción TRY...CATCH.
/*
La instrucción anterior a la instrucción THROW debe ir seguida del terminador de instrucción punto y coma (;).
Si una construcción TRY...CATCH no está disponible, el lote de instrucciones se finaliza. Se establecen el número de
línea y el procedimiento donde se produce la excepción. La gravedad se establece en 16.
Si la instrucción THROW se especifica sin parámetros, debe aparecer dentro de un bloque CATCH. Esto hace que se
produzca la excepción detectada. Cualquier error que se produzca en una instrucción THROW hace que el lote de
instrucciones se finalice.
*/

BEGIN TRY
    BEGIN TRANSACTION
        UPDATE [dbo].[Errores] SET [Valor]=1/0 WHERE ID=1;
    COMMIT TRANSACTION
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH
---------------------------------------
(0 rows affected)
Msg 8134, Level 16, State 1, Line 6
Error de división entre cero.
