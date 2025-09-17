--SET search_path TO;

-- Ejercicio 1 — Filtro de empleados por nombre, cargo, turno y edad
-- Orden:
-- 1. Listar los empleados cuyo apellido empiece con 'M' y cuyo puesto contenga 'Manager'.
--    O bien, aquellos que trabajen en el turno 'Evening' o 'Night'.
-- 2. Además, los empleados deben tener una edad entre 30 y 40 años.
-- 3. Mostrar los siguientes campos:
--      - BusinessEntityID
--      - FirstName
--      - LastName
--      - JobTitle
--      - Department
--      - Shift
--      - HireDate
--      - StartDate
--      - Edad (calculada a partir de BirthDate)
-- 4. Ordenar el resultado por:
--      - Nombre del Departamento
--      - Apellido (LastName)
--      - Nombre (FirstName)


-- Ejercicio 2 — Órdenes de compra por estado
-- Orden:
-- 1. Listar las órdenes de compra realizadas entre el 1 de junio y el 31 de diciembre de 2014.
-- 2. Mostrar el estado de la orden en texto:
--      1 → 'En proceso'
--      2 → 'Aprobada'
--      3 → 'Rechazada'
--      4 → 'Completada'
-- 3. Contar la cantidad de órdenes en cada estado.
-- 4. Agrupar por estado, proveedor y método de envío.
-- 5. Ordenar de forma descendente por la cantidad de órdenes.


-- Ejercicio 3 — Empleados por departamento y turno
-- Orden:
-- 1. Mostrar los departamentos con el total de empleados asignados actualmente.
-- 2. Contar cuántos trabajan en turno Day, Evening y Night.
-- 3. Agrupar por departamento y ordenar alfabéticamente.


-- Ejercicio 4 — Órdenes de trabajo a tiempo y retrasadas por producto
-- Tablas a usar:
--   - Production.WorkOrder
--   - Production.Product
--
-- Orden:
-- 1. Listar los productos junto con:
--      - La cantidad total de órdenes de trabajo (workorders).
--      - La cantidad de órdenes terminadas a tiempo (a_tiempo), es decir,
--        aquellas cuyo EndDate no sea nulo y sea menor o igual al DueDate.
--      - La cantidad de órdenes retrasadas (retrasadas), es decir,
--        aquellas cuyo EndDate sea mayor al DueDate.
-- 2. Considerar únicamente las órdenes con StartDate dentro de los últimos 6 meses
--    a partir del 1 de enero de 2013.
-- 3. Agrupar los resultados por ProductID y nombre del producto.
-- 4. Mostrar únicamente los productos que tengan al menos una orden de trabajo.
-- 5. Ordenar los resultados de forma descendente por:
--      - Órdenes a tiempo
--      - Órdenes retrasadas
--      - Total de órdenes

--==========================
----------INDEX-------------
--==========================

CREATE TABLE persona (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre TEXT,
  apellido TEXT
);


INSERT INTO persona (nombre, apellido)
SELECT
  md5(random()::text),   
  (ARRAY['García','Martínez','Rodríguez','López','Pérez','Sánchez'])[floor(random()*6)+1]  
FROM generate_series(1,9000000);


EXPLAIN ANALYZE
SELECT * 
FROM persona
WHERE apellido = 'López';

CREATE INDEX idx_persona_apellido
ON persona(apellido);

DROP INDEX idx_persona_apellido

--==========================
----------VIEWS-------------
--==========================
CREATE VIEW EXAMPLE AS

-- Ejercicio 1
-- Se requiere diseñar una vista en la base de datos que permita visualizar las direcciones de domicilio asociadas a las personas registradas.

-- La vista debe proporcionar la siguiente información:

-- Id de persona
-- Nombre.
-- Apellido.
-- Nombre completo.
-- Dirección (líneas 1 y 2). En caso de que algún valor sea nulo, deberá mostrarse la leyenda “Sin dirección”.
-- Ciudad.
-- Estado o provincia.
-- Código postal.
-- País.



-- Ejercicio 2
-- Detalle de productos vendidos en los meses de enero y diciembre, mostrando las cantidades vendidas y filtrando los más vendidos de diciembre.

-- Descripción:
-- Crear una vista que muestre, para cada producto y mes:

-- Nombre del producto (product_name)
-- Mes de la venta (month) — enero o diciembre
-- Año de la venta (year)

