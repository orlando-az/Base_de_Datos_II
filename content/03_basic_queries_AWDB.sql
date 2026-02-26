-- ============================================================
-- AdventureWorks (PostgreSQL) - Ejercicios de SQL (Versión sin resolver)
-- Descripción:
--   - Ejercicios de nivel básico a intermedio.
--   - Cobertura: SELECT, WHERE, LIKE/ILIKE, BETWEEN, IN,
--                JOINs, GROUP BY, HAVING, ORDER BY,
--                LIMIT / OFFSET.
--   - Restricción: No se emplean subconsultas ni CTEs.
--   - Esquemas usados: person, sales, production (AdventureWorks).
-- ============================================================



-- ============================================================
-- Ejercicio 1 — Clientes registrados
-- Orden:
--   Mostrar el nombre y apellido de todas las personas que
--   son clientes registrados en el sistema.
-- Campos sugeridos:
--   first_name, last_name
-- ============================================================

select p.firstname, p.lastname
from person.person as p
INNER JOIN sales.customer as c on p.businessentityid = c.personid


select* from person.person


-- ============================================================
-- Ejercicio 2 — Pedidos posteriores a 2013 con alto total
-- Orden:
--   Listar los pedidos realizados después del año 2013
--   cuyo total sea mayor a 1000.
-- Campos sugeridos:
--   salesorderid, orderdate, totaldue
-- ============================================================

select soh.salesorderid, soh.orderdate,soh.totaldue
from sales.salesorderheader as soh
where soh.orderdate >='2014-01-01' and soh.totaldue > 1000


-- ============================================================
-- Ejercicio 3 — Productos que comienzan con B
-- Orden:
--   Mostrar los productos cuyo nombre comience con la letra 'B'.
-- Campos sugeridos:
--   productid, name
-- ============================================================

select productid,name
from production.product
where name like 'B%'

-- ============================================================
-- Ejercicio 4 — Pedidos realizados durante el año 2012
-- Orden:
--   Obtener los pedidos realizados entre el 1 de enero
--   y el 31 de diciembre del año 2012.
-- Campos sugeridos:
--   salesorderid, orderdate
-- ============================================================

select salesorderid, orderdate from
sales.salesorderheader 
where orderdate between '2012-01-01' and '2012-12-31'


select salesorderid, orderdate,EXTRACT(YEAR FROM orderdate)
from sales.salesorderheader 
where EXTRACT(YEAR FROM orderdate) = 2012

-- ============================================================
-- Ejercicio 5 — Clientes por ciudad específica
-- Orden:
--   Listar los clientes que vivan en Seattle o New York,
--   mostrando el nombre del cliente y la ciudad.
-- Campos sugeridos:
--   first_name, last_name, city
-- ============================================================

select p.firstname, p.lastname,a.city
from person.person as p
INNER JOIN sales.customer as c on c.personid = p.businessentityid
INNER JOIN person.businessentity as b on p.businessentityid = b.businessentityid
INNER JOIN person.businessentityaddress bea on b.businessentityid = bea.businessentityid
INNER JOIN person.address as a on bea.addressid = a.addressid
where a.city in ('Seattle','New York')

select p.firstname, p.lastname,a.city
from person.person as p
INNER JOIN sales.customer as c on c.personid = p.businessentityid
INNER JOIN person.businessentityaddress bea on p.businessentityid = bea.businessentityid
INNER JOIN person.address as a on bea.addressid = a.addressid
where a.city in ('Seattle','New York')


-- ============================================================
-- Ejercicio 6 — Detalle de pedidos y productos vendidos
-- Orden:
--   Mostrar el número de pedido, el nombre del producto
--   y la cantidad vendida en cada línea de pedido.
-- Campos sugeridos:
--   salesorderid, product_name, orderqty
-- ============================================================

Select soh.salesorderid as "Numeropedido", p."name" as "Producto", sod.orderqty as "Cantidad"
from sales.salesorderheader soh 
INNER JOIN sales.salesorderdetail as sod ON soh.salesorderid = sod.salesorderid
INNER JOIN production.product as p ON p.productid = sod.productid
order by 3 desc

select * from sales.salesorderdetail

-- ============================================================
-- Ejercicio 7 — Productos con más de 100 unidades vendidas
-- Orden:
--   Mostrar los productos que se han vendido más de 100
--   veces en total.
-- Campos sugeridos:
--   product_name, total_vendida
-- Requisito:
--   Usar GROUP BY y HAVING.
-- ============================================================
select p."name" as "Producto", SUM(sod.orderqty) as "Total Vendido"
from sales.salesorderdetail as sod
INNER JOIN production.product as p ON sod.productid = p.productid
GROUP BY p.name
order by 2 desc

-- ============================================================
-- Ejercicio 8 — Paginación de pedidos más caros
-- Orden:
--   Mostrar los 5 pedidos más caros, omitiendo los primeros 5
--   resultados (paginación).
-- Campos sugeridos:
--   salesorderid, totaldue
-- Requisito:
--   Usar ORDER BY, LIMIT y OFFSET.
-- ============================================================

Select soh.salesorderid, soh.totaldue
from sales.salesorderheader as soh
ORDER BY 2 desc
LIMIT 5
OFFSET 20

-- ============================================================
-- Ejercicio 9 — Ventas realizadas por empleados de tipo Sales
-- Orden:
--   Mostrar ventas mayores a 5000 realizadas en 2013 o 2014
--   por empleados cuyo cargo contenga 'Sales' y que
--   pertenezcan a los territorios Northwest o Southwest.
-- Campos sugeridos:
--   nombre_empleado, jobtitle, territorio,
--   salesorderid, orderdate, totaldue
-- ============================================================

SELECT 
    p.firstname || ' ' || p.lastname AS nombre_empleado,
    e.jobtitle,
    st.name AS territorio,
    soh.salesorderid,
    soh.orderdate,
    soh.totaldue
FROM sales.salesorderheader soh
INNER JOIN sales.salesperson sp ON soh.salespersonid = sp.businessentityid
INNER JOIN humanresources.employee e ON sp.businessentityid = e.businessentityid
INNER JOIN person.person p ON e.businessentityid = p.businessentityid
INNER JOIN sales.salesterritory st ON sp.territoryid = st.territoryid
WHERE soh.totaldue > 5000
  AND EXTRACT(YEAR FROM soh.orderdate) IN (2013, 2014)
  AND e.jobtitle ILIKE '%Sales%'
  AND st.name IN ('Northwest', 'Southwest')
ORDER BY soh.orderdate;

-- ============================================================
-- Ejercicio 10 — Productos Red o Black con alto volumen
-- Orden:
--   Mostrar productos de color Red o Black cuyo nombre
--   comience con 'R', que se hayan vendido más de 200
--   unidades en pedidos con status 1 o 5.
-- Campos sugeridos:
--   productid, nombre_producto, color,
--   precio_lista, total_unidades_vendidas
-- ============================================================

SELECT 
    p.productid,
    p.name AS nombre_producto,
    p.color,
    p.listprice AS precio_lista,
    SUM(sod.orderqty) AS total_unidades_vendidas
FROM production.product p
INNER JOIN sales.salesorderdetail sod ON p.productid = sod.productid
INNER JOIN sales.salesorderheader soh ON sod.salesorderid = soh.salesorderid
WHERE p.color IN ('Red', 'Black')
  AND p.name ILIKE 'R%'
  AND soh.status IN (1, 5)
GROUP BY p.productid,p.name,p.color,p.listprice
HAVING SUM(sod.orderqty) > 200
ORDER BY total_unidades_vendidas DESC;

-- ============================================================
-- Ejercicio 11 — Clasificación de productos por rango de precio
-- Orden:
--   Mostrar los productos cuyo nombre contenga 'Bike'
--   o 'Road', clasificándolos según su precio de lista.
--
--   Clasificación:
--     'Alto'   → listprice > 2000
--     'Medio'  → listprice entre 1000 y 2000
--     'Bajo'   → listprice < 1000
--
-- Campos sugeridos:
--   productid, nombre_producto,
--   categoria, listprice, nivel_precio
-- ============================================================

SELECT
    p.productid,
    p.name AS nombre_producto,
    pc.name AS categoria,
    p.listprice,
    CASE
        WHEN p.listprice > 2000 THEN 'Alto'
        WHEN p.listprice BETWEEN 1000 AND 2000 THEN 'Medio'
        ELSE 'Bajo'
    END AS nivel_precio
FROM production.product p
INNER JOIN production.productsubcategory ps
    ON p.productsubcategoryid = ps.productsubcategoryid
INNER JOIN production.productcategory pc
    ON ps.productcategoryid = pc.productcategoryid
WHERE p.name ILIKE '%Bike%'
   OR p.name ILIKE '%Road%'
ORDER BY p.listprice DESC;