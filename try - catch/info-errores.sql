/*
En el ámbito de un bloque CATCH, se pueden utilizar las siguientes funciones del sistema
para obtener información acerca del error que provocó la ejecución del bloque CATCH:

● ERROR_NUMBER() devuelve el número del error.
● ERROR_SEVERITY() devuelve la gravedad.
● ERROR_STATE() devuelve el número de estado del error.
● ERROR_PROCEDURE() devuelve el nombre del procedimiento almacenado o desencadenador donde se
produjo el error.
● ERROR_LINE() devuelve el número de línea de la rutina que provocó el error.
● ERROR_MESSAGE() devuelve el texto completo del mensaje de error. El texto incluye los valores
proporcionados para los parámetros sustituibles, como las longitudes, nombres de objeto o tiempos .
● Estas funciones devuelven NULL si se las llama desde fuera del ámbito del bloque CATCH. Con ellas se
puede recuperar información sobre los errores desde cualquier lugar dentro del ámbito del bloque
CATCH. Por ejemplo, en el siguiente script se muestra un procedimiento almacenado que contiene
funciones de control de errores.Se llama al procedimiento almacenado en el bloque CATCH de una
construcción TRY…CATCH y se devuelve información sobre el error.
*/

BEGIN TRY
    SELECT 1/0;
END TRY

BEGIN CATCH
    SELECT ERROR_NUMBER() AS NumerodeError;
END CATCH;
-----
8134