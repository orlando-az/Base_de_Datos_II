-- Ejercicio 1
-- Crea una vista que muestre por producto y por locationid la cantidad total en inventario 
-- filtra a los productos que tenga un inventario menor a 100

-- Ejercicio 2
-- Muestra los productos cuyo precio de lista sea mayor al precio promedio de su subcategoría.
-- Utiliza subconsultas.

-- Ejercicio 3
-- Crea un CTE que calcule el total de ventas por cliente en 2014. Luego, en la consulta principal, 
-- muestra solo los clientes cuyo total de ventas sea mayor a 10,000.

-- Ejercicio 4
-- Crea una función que reciba un año y devuelva el promedio de ventas de ese año.

-- Ejercicio 5
-- Genera un procedimiento que actualice la grade de un estudiante en una sección específica, 
-- solo si la matrícula está activa o completada.

-- Nota: Usa la base de datos de 'University'

-- Ejercicio 1:
-- Crear un trigger que antes de insertar o actualizar un registro 
-- en enrollment, ajuste la nota (grade) para que siempre esté entre 0 y 100.

-- Ejercicio 2: 
-- Crear un trigger que antes de insertar o actualizar una sección de clase (class_section), 
-- verifique que end_date no sea anterior a start_date. Si lo es, lanzar un error.

-- Ejercicio 3:
-- Crear un trigger que después de actualizar un estudiante (student), registre en 
-- student_audit los cambios del campo status junto con la fecha y hora del cambio.