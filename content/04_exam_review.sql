-- ============================================================
-- AdventureWorks (PostgreSQL)
-- ============================================================


-- ============================================================
-- Ejercicio 1 — Clientes con alto volumen de compras
-- Orden:
--   Mostrar los clientes que hayan realizado más de 10 órdenes
--   y cuya suma total de subtotal supere 20000.
--   Mostrar: customerid, total_ordenes, total_comprado.
--   Ordenar por total_comprado desc.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 2 — Productos con baja rotación
-- Orden:
--   Mostrar los productos cuyo total vendido (orderqty)
--   sea menor a 50 unidades.
--   Mostrar: productid, name, total_vendido.
--   Considerar únicamente productos que sí hayan sido vendidos.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 3 — Ventas por año y estado
-- Orden:
--   Mostrar el total facturado (subtotal) por año y por status.
--   Mostrar: año, status, total_facturado.
--   Ordenar por año ascendente y total_facturado desc.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 4 — Categorías con más de 20 productos
-- Orden:
--   Mostrar las categorías que tengan más de 20 productos.
--   Mostrar: category_name, total_productos.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 5 — Órdenes con más de 3 productos distintos
-- Orden:
--   Mostrar las órdenes que contengan más de 3 productos distintos.
--   Mostrar: salesorderid, total_productos_distintos.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 6 — Clasificación de clientes por facturación
-- Orden:
--   Mostrar cada cliente con su total comprado y clasificarlo:
--     'Premium'  → total > 50000
--     'Regular'  → total entre 10000 y 50000
--     'Bajo'     → menor a 10000
--   Mostrar: customerid, total_comprado, categoria_cliente.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 7 — Productos más vendidos por color
-- Orden:
--   Mostrar por cada color:
--     - total de productos distintos
--     - total de unidades vendidas
--   Excluir colores NULL.
--   Ordenar por total_unidades desc.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 8 — Empleados de ventas con alto rendimiento
-- Orden:
--   Mostrar los empleados cuyo cargo contenga 'Sales'
--   y cuya suma de ventas (subtotal) supere 30000.
--   Mostrar: nombre_empleado, jobtitle, total_vendido.
-- ============================================================
-- (Escribir consulta aquí)


-- ============================================================
-- Ejercicio 9 — Inventario crítico por ubicación
-- Orden:
--   Mostrar las ubicaciones (locationid) cuya suma total
--   de quantity sea menor a 300 unidades.
--   Mostrar: locationid, total_inventario.
-- ============================================================
-- (Escribir consulta aquí)

-- ============================================================