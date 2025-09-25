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

SELECT 
    e.businessentityid,
    p.firstname,
    p.lastname,
    e.jobtitle,
    d.name AS department,
    s.name AS shift,
    e.hiredate,
    edh.startdate,
    EXTRACT(YEAR FROM AGE(p.birthdate)) AS edad
FROM humanresources.employee e
INNER JOIN person.person p 
    ON e.businessentityid = p.businessentityid
INNER JOIN humanresources.employeedepartmenthistory edh 
    ON e.businessentityid = edh.businessentityid
INNER JOIN humanresources.department d 
    ON edh.departmentid = d.departmentid
INNER JOIN humanresources.shift s 
    ON edh.shiftid = s.shiftid
WHERE 
    (
        (p.lastname LIKE 'M%' AND e.jobtitle ILIKE '%Manager%')
        OR s.name IN ('Evening', 'Night')
    )
    AND EXTRACT(YEAR FROM AGE(p.birthdate)) BETWEEN 30 AND 40
ORDER BY d.name, p.lastname, p.firstname;

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

SELECT
    CASE po.status
        WHEN 1 THEN 'En proceso'
        WHEN 2 THEN 'Aprobada'
        WHEN 3 THEN 'Rechazada'
        WHEN 4 THEN 'Completada'
    END AS estado,
    v.vendorname,
    sm.shipmethod,
    COUNT(*) AS cantidad_ordenes
FROM purchasing.purchaseorderheader po
INNER JOIN purchasing.vendor v 
    ON po.vendorid = v.vendorid
INNER JOIN purchasing.shipmethod sm 
    ON po.shipmethodid = sm.shipmethodid
WHERE po.orderdate BETWEEN '2014-06-01' AND '2014-12-31'
GROUP BY po.status, v.vendorname, sm.shipmethod
ORDER BY cantidad_ordenes DESC;

-- Ejercicio 3 — Empleados por departamento y turno
-- Orden:
-- 1. Mostrar los departamentos con el total de empleados asignados actualmente.
-- 2. Contar cuántos trabajan en turno Day, Evening y Night.
-- 3. Agrupar por departamento y ordenar alfabéticamente.

SELECT 
    d.name AS departamento,
    COUNT(*) AS total_empleados,
    SUM(CASE WHEN s.name = 'Day' THEN 1 ELSE 0 END) AS turno_day,
    SUM(CASE WHEN s.name = 'Evening' THEN 1 ELSE 0 END) AS turno_evening,
    SUM(CASE WHEN s.name = 'Night' THEN 1 ELSE 0 END) AS turno_night
FROM humanresources.employeedepartmenthistory edh
INNER JOIN humanresources.department d 
    ON edh.departmentid = d.departmentid
INNER JOIN humanresources.shift s 
    ON edh.shiftid = s.shiftid
WHERE edh.enddate IS NULL  
GROUP BY d.name
ORDER BY d.name;

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

SELECT 
    p.productid,
    p.name AS product_name,
    COUNT(*) AS total_workorders,
    SUM(CASE WHEN w.enddate IS NOT NULL AND w.enddate <= w.duedate THEN 1 ELSE 0 END) AS a_tiempo,
    SUM(CASE WHEN w.enddate IS NOT NULL AND w.enddate > w.duedate THEN 1 ELSE 0 END) AS retrasadas
FROM production.workorder w
INNER JOIN production.product p
    ON w.productid = p.productid
WHERE w.startdate BETWEEN '2012-07-01' AND '2013-01-01'  
GROUP BY p.productid, p.name
HAVING COUNT(*) > 0  
ORDER BY a_tiempo DESC, retrasadas DESC, total_workorders DESC;

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

CREATE OR REPLACE VIEW vw_persona_direcciones AS
SELECT
    p.businessentityid AS persona_id,
    p.firstname AS nombre,
    p.lastname AS apellido,
    (p.firstname || ' ' || p.lastname) AS nombre_completo,
    COALESCE(a.addressline1, 'Sin dirección') AS direccion_linea1,
    COALESCE(a.addressline2, 'Sin dirección') AS direccion_linea2,
    a.city AS ciudad,
    a.stateprovince AS estado_provincia,
    a.postalcode AS codigo_postal,
    c.name AS pais
FROM person.person p
INNER JOIN person.businessentityaddress bea
    ON p.businessentityid = bea.businessentityid
INNER JOIN person.address a
    ON bea.addressid = a.addressid
INNER JOIN person.stateprovince sp
    ON a.stateprovinceid = sp.stateprovinceid
INNER JOIN person.countryregion c
    ON sp.countryregioncode = c.countryregioncode;

-- Ejercicio 2
-- Detalle de productos vendidos en los meses de enero y diciembre, mostrando las cantidades vendidas y filtrando los más vendidos de diciembre.

-- Descripción:
-- Crear una vista que muestre, para cada producto y mes:

-- Nombre del producto (product_name)
-- Mes de la venta (month) — enero o diciembre
-- Año de la venta (year)

CREATE OR REPLACE VIEW vw_productos_enero_diciembre AS
SELECT
    p.name AS product_name,
    TO_CHAR(sod.orderdate, 'Month') AS mes,
    EXTRACT(YEAR FROM sod.orderdate) AS year,
    SUM(sod.orderqty) AS cantidad_vendida
FROM sales.salesorderdetail sod
INNER JOIN production.product p
    ON sod.productid = p.productid
WHERE EXTRACT(MONTH FROM sod.orderdate) IN (1, 12)  
GROUP BY p.name, TO_CHAR(sod.orderdate, 'Month'), EXTRACT(YEAR FROM sod.orderdate)
HAVING EXTRACT(MONTH FROM sod.orderdate) = 12  
ORDER BY cantidad_vendida DESC;
