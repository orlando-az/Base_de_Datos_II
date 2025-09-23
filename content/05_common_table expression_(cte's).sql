-- Ejercicio 1: 
-- Calcular el stock total de cada producto sumando 
-- las cantidades disponibles 
-- en ProductInventory y mostrar el ID y 
-- nombre del producto junto con su total 
-- de stock, ordenando los resultados de mayor a 
-- menor cantidad.
WITH stock as(
SELECT pi.productid,sum(pi.quantity) as total_stock ,
p.productsubcategoryid
from 
production.productinventory pi
INNER JOIN production.product p on p.productid= pi.productid
group by pi.productid,p.productsubcategoryid
),
max_total as (
 select psc.name as sub_categoria,
 pc.name as categoria,
 max(s.total_stock) as total_max,
 psc.productsubcategoryid as subcategoryid
 from production.productsubcategory psc
 INNER JOIN production.productcategory pc on psc.productcategoryid =
 pc.productcategoryid 
 INNER JOIN stock s on s.productsubcategoryid = psc.productcategoryid
 group by psc.name,pc."name",subcategoryid
)
SELECT p.name as producto, s.total_stock, mt.total_max
subcategoria, categoria
FROM production.product p
INNER JOIN stock s on p.productid= s.productid
INNER JOIN max_total mt on mt.subcategoryid = 
p.productsubcategoryid


WITH stock as(
SELECT pi.productid,sum(pi.quantity) as total_stock 
from  production.productinventory pi
INNER JOIN production.product p on p.productid= pi.productid
GROUP by pi.productid
),
max_total as (
	select p.productsubcategoryid as max_subcateria_id, max(s.total_stock) as max_total 
	FROM stock s
	INNER JOIN production.product p on p.productid = s.productid
	group by p.productsubcategoryid
)
SELECT p.name as producto,
psc.name as subcategoria,pc.name as categoria,
s.total_stock, mt.max_total
FROM production.product p
INNER JOIN production.productsubcategory psc on 
psc.productsubcategoryid = p.productsubcategoryid
INNER JOIN production.productcategory pc on 
pc.productcategoryid= psc.productcategoryid
INNER JOIN stock s on s.productid = p.productid
INNER JOIN max_total mt on mt.max_subcateria_id = p.productsubcategoryid

-- Ejercicio 2:
-- Calcular la antigüedad de los empleados en años, meses y días, 
-- usando startdate y enddate (o la fecha actual si no hay fin), 
-- y mostrar los 3 empleados con mayor antigüedad, indicando su ID, 
-- días totales y la descomposición en años, meses y días.

WITH antiguedad as(
SELECT dh.businessentityid,
dh.startdate,
coalesce(dh.enddate,current_date) as enddate,
(coalesce(dh.enddate,current_date) - dh.startdate) as antiguedad
from humanresources.employeedepartmenthistory dh
)
SELECT p.firstname,p.lastname, atg.startdate,atg.enddate,
atg.antiguedad,
atg.antiguedad / 365 as anios,
(atg.antiguedad % 365) / 30 as meses,
(atg.antiguedad % 365) % 30 as dias
from humanresources.employee e
INNER JOIN person.person p on p.businessentityid= e.businessentityid
INNER join antiguedad atg on atg.businessentityid = e.businessentityid

-- Ejercicio 3:
-- Calcular los productos más vendidos por categoría, sumar su cantidad 
-- vendida (orderqty), 
-- determinar el ranking dentro de cada categoría y mostrar solo los top 3, 
-- incluyendo nombre del producto, categoría, cantidad vendida y posición en el ranking, 
-- usando un CTE para la agregación y el ranking
-- RANK() OVER ( PARTITION BY ORDER BY)
WITH ranking as (
SELECT p.productsubcategoryid,p.productid, sum(d.orderqty) as cantidad,
RANK() OVER ( PARTITION BY p.productsubcategoryid
ORDER BY sum(d.orderqty) desc ) as top
from sales.salesorderdetail d
inner join production.product p on p.productid= d.productid
GROUP by p.productsubcategoryid,p.productid
)
SELECT pr.name as producto ,psc.name as subcategoria, r.cantidad,
r.top as ranking
from production.product pr
INNER JOIN ranking r on r.productsubcategoryid = pr.productsubcategoryid
INNER join production.productsubcategory psc on psc.productsubcategoryid=
pr.productsubcategoryid
where r.top<=3
order by psc.name, r.top asc


