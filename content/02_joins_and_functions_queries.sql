-- ============================================================
-- Ejercicio 1 — Identificación de clientes y sus órdenes
-- Consigna: Listar los clientes junto a sus nombres y la fecha de emisión de las órdenes que realizaron.
-- Tablas: person.person, sales.customer, sales.salesorderheader
-- ============================================================

select p.firstname,p.lastname, h.salesorderid from person.person p
INNER JOIN sales.customer c on p.businessentityid = c.personid
INNER JOIN sales.salesorderheader h on h.customerid= c.customerid

-- ============================================================
-- Ejercicio 2 — Productos vendidos con sus categorías
-- Consigna: Mostrar los productos vendidos con su subcategoría y categoría correspondiente.
-- Tablas: sales.salesorderdetail, production.product, production.productsubcategory,
-- production.productcategory
-- ============================================================

SELECT p."name" as Producto,sc."name" as SubCategoria, c."name" as Categoria
from production.product p
INNER join sales.salesorderdetail d on p.productid = d.productid
INNER JOIN production.productsubcategory sc on 
sc.productsubcategoryid = p.productsubcategoryid
INNER JOIN production.productcategory c on c.productcategoryid= sc.productcategoryid

-- ============================================================
-- Ejercicio 3 — Total de ventas por cliente
-- Consigna: Calcular el monto total vendido por cada cliente.
-- Tablas: sales.salesorderheader
-- ============================================================

SELECT customerid,sum(subtotal) as total_cliente
FROM sales.salesorderheader
GROUP by customerid
order by 1

-- ============================================================
-- Ejercicio 4 — Precio promedio de productos por categoría
-- Consigna: Determinar el precio promedio de lista agrupado por categoría.
-- Tablas: production.product, production.productsubcategory, production.productcategory
-- ============================================================

SELECT pc.name as Categoria, ROUND(avg(p.listprice),2) as PrecioPromedio
from production.product p 
INNER JOIN production.productsubcategory psc 
on p.productsubcategoryid = psc.productsubcategoryid
INNER JOIN production.productcategory pc on psc.productcategoryid= pc.productcategoryid
GROUP by pc.name;


-- ============================================================
-- Ejercicio 5 — Órdenes con variedad de productos
-- Consigna: Identificar las órdenes que incluyen más de cinco productos distintos.
-- Tablas: sales.salesorderdetail
-- ============================================================

select salesorderid, count(distinct productid) as total_productos
from sales.salesorderdetail
GROUP by salesorderid
HAVING count(distinct productid)>5
order by 2

-- ============================================================
-- Ejercicio 6 — Existencias de inventario por ubicación
-- Consigna: Mostrar la cantidad total disponible en inventario por producto y ubicación.
-- Tablas: production.product, production.productinventory
-- ============================================================

SELECT  p.name as producto, i.locationid as localidad, sum(i.quantity) as total
from  production.product p 
INNER JOIN production.productinventory i on p.productid = i.productid
GROUP by p.name, i.locationid

-- ============================================================
-- Ejercicio 7 — Órdenes agrupadas por año y mes
-- Consigna: Determinar cuántas órdenes se realizaron en cada mes de cada año.
-- Tablas: sales.salesorderheader
-- ============================================================

SELECT
EXTRACT(YEAR FROM orderdate) as anio,
EXTRACT(MONTH FROM orderdate) as mes,
count(salesorderid) as total
from sales.salesorderheader
GROUP by anio,mes
ORDER by anio,mes,total


-- ============================================================
-- Ejercicio 8 — Los productos más vendidos
-- Consigna: Identificar los diez productos con mayor volumen de ventas.
-- Tablas: sales.salesorderdetail, production.product
-- ============================================================

SELECT p.productid,  p.name,count(*) as total
from production.product p
INNER JOIN sales.salesorderdetail d on p.productid = d.productid
group by p.productid, p."name"
order by total desc
LIMIT 10

-- ============================================================
-- Ejercicio 9 — Clientes, correos electrónicos y número de órdenes
-- Consigna: Listar los clientes con su nombre completo, correo electrónico y cantidad de órdenes realizadas.
-- Tablas: person.person, person.emailaddress, sales.customer, sales.salesorderheader
-- ============================================================
