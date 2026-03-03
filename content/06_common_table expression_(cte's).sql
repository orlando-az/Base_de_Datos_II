--=======================================================================
-- Ejercicio 1
-- El área financiera requiere identificar los años cuyo total de ventas
-- haya superado los 10 millones.

-- Calcular el total vendido por año.
-- Filtrar únicamente aquellos años cuyo total sea mayor a 10,000,000.
--=======================================================================


WITH nombre_cte AS (
    SELECT columnas
    FROM tabla
    WHERE condicion
)
SELECT *
FROM nombre_cte;

WITH venta_total as (
select extract(YEAR FROM soh.orderdate) as anio, 
ROUND(SUM(soh.totaldue)) as total_venta
from
sales.salesorderheader as soh
group by extract(YEAR FROM soh.orderdate)
)
Select * 
from venta_total
where total_venta > 15000000

--=======================================================================
-- Ejercicio 2
-- Identificar los clientes que hayan realizado más de
-- 5 productos distintos en el sistema.
--
-- Calcular la cantidad de pedidos distintos por cliente.
-- Mostrar nombre, apellido y cantidad de pedidos.
-- Utilizar un CTE para aislar el conteo.
--=======================================================================

WITH pedidos_cliente as (
	select distinct soh.customerid as clienteid,count( sod.productid) cantidad_productos
	from sales.salesorderdetail	as sod
	inner join sales.salesorderheader as soh on sod.salesorderid= soh.salesorderid
	group by soh.customerid
	order by 1,2
)
select p.firstname,p.lastname, pc.cantidad_productos
from person.person as p
INNER JOIN pedidos_cliente AS pc ON pc.clienteid = p.businessentityid
where pc.cantidad_productos > 5

--=======================================================================
-- Ejercicio 3
--
-- El área de Recursos Humanos necesita identificar a los empleados
-- con mayor antigüedad dentro de la organización.
--
-- A partir de las fechas startdate y enddate (considerando la fecha
-- actual cuando enddate sea NULL), se solicita:
--
-- 1. Calcular la antigüedad total en días.
-- 2. Calcular la antigüedad descompuesta en años, meses y días.
-- 3. Mostrar únicamente los 3 empleados con mayor antigüedad.
--
-- El resultado debe incluir:
-- - ID del empleado
-- - Días totales trabajados
-- - Años
-- - Meses
-- - Días
--
-- Utilizar CTE para estructurar la solución.
--=======================================================================
With fechas as(
select dh.businessentityid, dh.startdate as fecha_ini,
COALESCE(dh.enddate,CURRENT_DATE) as fecha_fin
from humanresources.employeedepartmenthistory dh
),
intervalos as (
select (fecha_fin - fecha_ini) as dias_totales,
AGE(fecha_fin,fecha_ini) as rango
from fechas 
) 
select dias_totales,
extract(YEAR FROM rango) as anio,
extract(MONTH FROM rango) as mes,
extract(DAY FROM rango) as dias
from intervalos
ORDER BY 1 DESC
LIMIT 3

	


--=======================================================================
-- Ejercicio 4
--
-- El área comercial desea identificar el producto más vendido
-- y el producto menos vendido en términos de cantidad total.
--
-- Se solicita:
-- 1. Calcular la cantidad total vendida por producto.
-- 2. Identificar el producto con mayor cantidad vendida.
-- 3. Identificar el producto con menor cantidad vendida.
-- 4. Mostrar nombre del producto y cantidad total.
--
-- Utilizar CTE para organizar la solución.
--=======================================================================

MAX -- VALOR MAXIMO DE UNA SELECCION
MIN -- VALOR MINIMO DE LA SELECCION

select  min(businessentityid) from person.person

WITH producto_cantidades as (
  select productid ,sum(orderqty) as cantidad from
  sales.salesorderdetail
  group by productid
 ),
 extremos as (
	select max(cantidad) as cantidad_maxima,
	min(cantidad) cantidad_minima
	from producto_cantidades
 )
select p.name, pc.cantidad
from production.product as p
INNER JOIN producto_cantidades as pc ON pc.productid = p.productid
WHERE pc.cantidad = (select cantidad_maxima from extremos)
or pc.cantidad = (select cantidad_minima from extremos)

