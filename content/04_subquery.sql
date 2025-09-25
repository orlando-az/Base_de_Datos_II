-- Ejercicio 1 — Productos con precio superior al promedio de su subcategoría
-- Listar productid, name y listprice de productos cuyo ListPrice sea mayor 
-- que el precio promedio de su misma subcategoría.

SELECT 
    p.productid,
    p.name,
    p.listprice
FROM production.product p
INNER JOIN production.productsubcategory ps
    ON p.productsubcategoryid = ps.productsubcategoryid
WHERE p.listprice > (
    SELECT AVG(p2.listprice)
    FROM production.product p2
    WHERE p2.productsubcategoryid = p.productsubcategoryid
)
ORDER BY ps.name, p.listprice DESC;

-- Ejercicio 2 — Clientes con pedidos superiores al promedio
-- Obtenga el ID, el nombre y la cantidad de pedidos de aquellos clientes 
-- cuya cantidad total de pedidos sea mayor al promedio de pedidos realizados por cliente.

SELECT 
    c.customerid,
    c.firstname,
    c.lastname,
    COUNT(soh.salesorderid) AS cantidad_pedidos
FROM sales.customer c
INNER JOIN sales.salesorderheader soh
    ON c.customerid = soh.customerid
GROUP BY c.customerid, c.firstname, c.lastname
HAVING COUNT(soh.salesorderid) > (
    SELECT AVG(cantidad) 
    FROM (
        SELECT COUNT(*) AS cantidad
        FROM sales.salesorderheader
        GROUP BY customerid
    ) AS sub
)
ORDER BY cantidad_pedidos DESC;

-- Ejercicio 3
-- Listar customerid, nombre y apellido de clientes que realizaron al menos un pedido en 2013 y ninguno en 2012.

SELECT 
    c.customerid,
    c.firstname,
    c.lastname
FROM sales.customer c
INNER JOIN sales.salesorderheader soh
    ON c.customerid = soh.customerid
WHERE EXTRACT(YEAR FROM soh.orderdate) = 2013
AND c.customerid NOT IN (
    SELECT customerid
    FROM sales.salesorderheader
    WHERE EXTRACT(YEAR FROM orderdate) = 2012
)
GROUP BY c.customerid, c.firstname, c.lastname
ORDER BY c.lastname, c.firstname;

-- Ejercicio 4 — Pedido más caro de cada cliente
-- Enunciado: Listar cada cliente con su pedido más caro.

SELECT 
    c.customerid,
    c.firstname,
    c.lastname,
    soh.salesorderid,
    soh.totaldue AS total_pedido
FROM sales.customer c
INNER JOIN sales.salesorderheader soh
    ON c.customerid = soh.customerid
INNER JOIN (
    SELECT customerid, MAX(totaldue) AS max_total
    FROM sales.salesorderheader
    GROUP BY customerid
) AS max_pedidos
    ON soh.customerid = max_pedidos.customerid
    AND soh.totaldue = max_pedidos.max_total
ORDER BY c.customerid;
