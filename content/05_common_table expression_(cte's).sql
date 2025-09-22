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
-- Ejercicio 2:
-- Calcular la antigüedad de los empleados en años, meses y días, 
-- usando startdate y enddate (o la fecha actual si no hay fin), 
-- y mostrar los 3 empleados con mayor antigüedad, indicando su ID, 
-- días totales y la descomposición en años, meses y días.

-- Ejercicio 3:
-- Calcular los productos más vendidos por categoría, sumar su cantidad vendida (orderqty), 
-- determinar el ranking dentro de cada categoría y mostrar solo los top 3, 
-- incluyendo nombre del producto, categoría, cantidad vendida y posición en el ranking, 
-- usando un CTE para la agregación y el ranking
-- RANK() OVER ( PARTITION BY ORDER BY)

