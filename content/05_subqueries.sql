--Listar todos los productos con precio mayor al promedio

Select p.name, p.listprice
from production.product as p
where p.listprice > (
SELECT AVG(p2.listprice)
from production.product AS p2
where p2.listprice>0
)
order by 2

---Clientes
--- 19820
--- 19119

select * 
from sales.customer as c
where c.customerid not in 
(
select soh.customerid
from sales.salesorderheader as soh
)


--Productos más caros que el promedio de su categoría
select p.name as Producto,p.listprice as Precio
from production.product as p
INNER JOIN (
select p2.productid , AVG(p2.listprice)
from production.product as p2
INNER JOIN production.productsubcategory sc ON sc.productsubcategoryid = p2.productsubcategoryid
group by p2.productid
) AS promedio_subcategoria ON p.productid = promedio_subcategoria.productid

