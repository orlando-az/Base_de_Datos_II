show SEARCH_PATH
SET SEARCH_PATH TO humanresources, person,production,purchasing,sales

-- ============================================================
-- Ejercicio 1 — Empleados contratados después del promedio
-- Consigna:
--   Elaborar una consulta que muestre el listado de empleados
--   cuya fecha de contratación sea posterior al promedio
--   general de fechas de contratación registradas en la empresa.
-- ============================================================

select businessentityid, hiredate, extract(epoch from hiredate)
from employee
where extract(epoch from hiredate) >
(
 Select AVG(extract(epoch from hiredate))
 from employee as e
) 
-- ============================================================
-- Ejercicio 2 — Clientes sin pedidos
-- Consigna:
--   Elaborar una consulta que permita identificar los clientes
--   que no hayan realizado ningún pedido en el sistema.
-- ============================================================

Select * 
from customer
where customerid  
not in (
select customerid from salesorderheader
)

-- ============================================================
-- Ejercicio 3 — Empleados con ventas en 2013
-- Consigna:
--   Elaborar una consulta que identifique los empleados
--   que hayan participado en al menos una venta
--   realizada durante el año 2013.
-- Requisito:
--   Debe utilizarse EXISTS.
-- ============================================================
Select p.firstname, p.lastname
from employee as e 
INNER JOIN person as p  on p.businessentityid= e.businessentityid
where EXISTS(
SELECT 1
FROM salesorderheader as soh
where soh.salespersonid= p.businessentityid and extract(YEAR FROM orderdate) = 2013
)


-- ============================================================
-- Ejercicio 4 — Productos más caros que el promedio de su categoría
-- Consigna:
--   Elaborar una consulta que muestre los productos cuyo
--   precio de lista sea superior al promedio de precios
--   de su misma subcategoría.
-- ============================================================

-- ============================================================
-- Ejercicio 5 — Promedio anual de ventas
-- Consigna:
--   Elaborar una consulta que calcule el promedio de ventas
--   por año.
--   Primero se debe obtener el total de ventas por año
--   mediante una subconsulta en el FROM.
-- Entregar:
--   Año y promedio anual de ventas.
-- ============================================================
Select 
 anio,
 total_venda/ cantidad_pedidos as promedio_gestion,
 (
	select
	 AVG(total_venta)
	from(
	select extract(YEAR FROM orderdate) anio,
	sum(totaldue) as total_Venta
	from salesorderheader
	group by extract(YEAR FROM orderdate)
 	) tabla2
 ) as promedio_de_gestiones
from (
select extract(year from orderdate) as anio,
sum(totaldue)as  total_venda,
count(*) as cantidad_pedidos 
from salesorderheader
group by extract(year from orderdate)
) tabla1
