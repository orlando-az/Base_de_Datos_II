-- Ejercicio 1:
-- Crear una función trigger que, antes de insertar o actualizar un registro en enrollment,
-- verifique si grade es menor que 0 y, en ese caso, lo ajuste automáticamente a 0.
-- Luego, crear un trigger que ejecute esta función en cada fila.

-- CREATE OR REPLACE FUNCTION ()
-- RETURNS TRIGGER 
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- END;
-- $$

-- CREATE TRIGGER 
-- BEFORE INSERT OR UPDATE ON 
-- FOR EACH ROW
-- EXECUTE FUNCTION


-- Ejercicio 2
-- Crear un trigger que muestre un aviso cada vez que se inserte una 
-- sección de clase (class_section) sin un instructor asignado (instructor_id es NULL).

-- Ejercicio 3
-- Registrar en una tabla de auditoría cada vez que se modifique 
-- el estado de un estudiante (status) en la tabla student.
-- Crea una tabla llamada student_audit con las siguientes columnas:

