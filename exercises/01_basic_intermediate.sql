-- ============================================================
-- AdventureWorks (PostgreSQL) - 30 Ejercicios de SQL (Versión sin resolver)
-- Descripción:
--   - Ejercicios desde nivel básico a intermedio.
--   - Cobertura: SELECT, WHERE, LIKE/ILIKE, BETWEEN, IN,
--                JOINs, GROUP BY, HAVING, ORDER BY, LIMIT/OFFSET,
--                CASE, COALESCE.
--   - Restricción: No se emplean subconsultas ni CTEs.
--   - Esquemas usados: production, sales, person (AdventureWorks).
-- ============================================================

-- ============================================================
-- Ejercicio 1 — Productos negros con precio válido
-- Orden: Listar los productos cuyo color sea "Black" y cuyo precio de lista
--        (listprice) sea diferente de 0. Mostrar: productid, name, listprice.
--        Ordenar los resultados por listprice descendente y productid ascendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 2 — Órdenes con subtotal o flete elevado
-- Orden: Listar las órdenes cuyo subtotal esté entre 1000 y 2000,
--        o cuyo valor de transporte (freight) sea mayor a 100.
--        Mostrar: salesorderid, orderdate, subtotal, freight.
--        Ordenar los resultados por orderdate descendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 3 — Productos en rango de precios
-- Orden: Listar los productos cuyo precio de lista esté entre 500 y 1500.
--        Mostrar: productid, name, listprice. Ordenar por listprice ascendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 4 — Productos con número no estándar
-- Orden: Mostrar los productos cuyo número (productnumber) contenga un guion '-'
--        pero no termine con '-S'. Mostrar: productid, productnumber, name.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 5 — Productos con prefijo "Mountain"
-- Orden: Listar los productos cuyo nombre (name) comience con "Mountain",
--        sin distinguir mayúsculas o minúsculas. Mostrar: productid, name.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 6 — Productos de colores seleccionados
-- Orden: Listar los productos cuyo color sea "Red", "Black" o "Silver",
--        y cuyo listprice sea mayor o igual a 750.
--        Mostrar: productid, name, color, listprice.
--        Ordenar por color y dentro de cada color por listprice descendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 7 — Correos electrónicos válidos
-- Orden: Listar las direcciones de correo que terminen en ".com" o ".org",
--        excluyendo aquellas que pertenezcan al dominio "adventure-works.com".
--        Mostrar: businessentityid, emailaddress.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 8 — Órdenes de clientes en un conjunto específico
-- Orden: Listar las órdenes realizadas por clientes con IDs 11000, 12000 o 13000.
--        Mostrar: salesorderid, customerid, orderdate, subtotal.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 9 — Productos sin peso asignado
-- Orden: Listar los productos que no tengan valor de peso (weight) asignado.
--        Mostrar: productid, name, weight.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 10 — Productos con peso conocido
-- Orden: Listar los productos que tengan peso (weight) definido y mayor a 50.
--        Mostrar: productid, name, weight. Ordenar por weight ascendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 11 — Órdenes por estado de envío
-- Orden: Listar las órdenes cuyo estado (status) sea distinto de 5.
--        Mostrar: salesorderid, orderdate, status.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 12 — Clientes y sus correos electrónicos
-- Orden: Mostrar los clientes con su nombre (lastname, firstname) y su dirección de correo.
--        Usar INNER JOIN entre person.person y person.emailaddress.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 13 — Productos con categoría y subcategoría
-- Orden: Listar los productos junto a su categoría y subcategoría.
--        Usar INNER JOIN entre production.product, production.productsubcategory,
--        y production.productcategory. Mostrar: productid, name, subcategory, category.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 14 — Productos en inventario
-- Orden: Mostrar los productos que tienen registros en la tabla productinventory.
--        Usar INNER JOIN entre production.product y production.productinventory.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 15 — Órdenes y detalles de venta
-- Orden: Listar las órdenes junto a los productos vendidos en cada una.
--        Usar INNER JOIN entre sales.salesorderheader y sales.salesorderdetail.
--        Mostrar: salesorderid, productid, orderqty, unitprice.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 16 — Clientes y sus órdenes (RIGHT JOIN)
-- Orden: Listar todos los clientes y, si corresponde, las órdenes que han realizado.
--        Usar RIGHT JOIN entre sales.salesorderheader y sales.customer.
--        Mostrar: customerid, salesorderid, orderdate.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 17 — Productos con valor calculado
-- Orden: Mostrar los productos con su precio de lista y un valor adicional
--        que indique "Caro" si el precio es mayor a 1000 y "Económico" en caso contrario.
--        Usar CASE.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 18 — Órdenes con estado traducido
-- Orden: Mostrar las órdenes con su estado y una descripción textual:
--        "Procesada" si status=5, "Pendiente" en otro caso. Usar CASE.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 19 — Productos con categoría de peso
-- Orden: Clasificar los productos en categorías de peso:
--        "Liviano" (weight < 20), "Mediano" (20–60), "Pesado" (>60).
--        Usar CASE y COALESCE para mostrar "Sin peso" en valores nulos.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 20 — Conteo de productos por color
-- Orden: Contar cuántos productos existen por cada color.
--        Mostrar: color, total_productos. Ordenar por total desc.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 21 — Precio promedio y conteo de productos por subcategoría
-- Orden: Calcular el precio promedio de lista (listprice) y el total de productos
--        en cada subcategoría. Mostrar: productsubcategoryid, promedio_precio y cantidad_productos.
--        Ordenar por cantidad_productos descendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 22 — Órdenes con total mayor a 5000
-- Orden: Listar las órdenes cuyo subtotal sea mayor a 5000.
--        Mostrar: salesorderid, subtotal. Ordenar por subtotal desc.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 23 — Productos distintos por tamaño
-- Orden: Listar los tamaños (size) distintos de los productos registrados.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 24 — Órdenes agrupadas por año
-- Orden: Contar cuántas órdenes se realizaron por año (orderdate).
--        Mostrar: año, total_ordenes.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 25 — Máximo precio por categoría
-- Orden: Listar el precio máximo encontrado en cada categoría de producto.
--        Mostrar: categoryid, max(listprice).
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 26 — Inventario dentro de un rango
-- Orden: Calcular la suma de la cantidad en inventario (quantity) agrupada por ubicación (locationid).
--        Mostrar únicamente aquellas ubicaciones cuyo total de inventario
--        se encuentre entre 200 y 800 unidades.
--        Incluir: locationid y total_inventario. Ordenar por total_inventario ascendente.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 27 — Promedio de subtotal por cliente
-- Orden: Calcular el promedio de subtotal de órdenes por cada cliente.
--        Mostrar: customerid, promedio_subtotal.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 28 — Órdenes con más de 5 productos
-- Orden: Listar las órdenes que tienen más de 5 productos distintos en su detalle.
--        Mostrar: salesorderid, total_productos.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 29 — Cantidad total vendida por producto
-- Orden: Calcular la suma de orderqty por cada producto vendido.
--        Mostrar: productid, cantidad_total.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================
-- Ejercicio 30 — Productos de precio alto (paginación)
-- Orden: Listar los productos cuyo precio de lista sea más alto.
--        Mostrar los productos desde la sexta posición en adelante,
--        obteniendo únicamente los siguientes 10 registros.
--        Incluir: productid, name y listprice, ordenados por listprice descendente.
-- ============================================================
-- (Escribir consulta aquí)