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



-- ============================================================
-- Ejercicio 2 — Pedidos posteriores a 2013 con alto total
-- Orden:
--   Listar los pedidos realizados después del año 2013
--   cuyo total sea mayor a 1000.
-- Campos sugeridos:
--   salesorderid, orderdate, totaldue
-- ============================================================



-- ============================================================
-- Ejercicio 3 — Productos que comienzan con B
-- Orden:
--   Mostrar los productos cuyo nombre comience con la letra 'B'.
-- Campos sugeridos:
--   productid, name
-- ============================================================



-- ============================================================
-- Ejercicio 4 — Pedidos realizados durante el año 2012
-- Orden:
--   Obtener los pedidos realizados entre el 1 de enero
--   y el 31 de diciembre del año 2012.
-- Campos sugeridos:
--   salesorderid, orderdate
-- ============================================================



-- ============================================================
-- Ejercicio 5 — Clientes por ciudad específica
-- Orden:
--   Listar los clientes que vivan en Seattle o New York,
--   mostrando el nombre del cliente y la ciudad.
-- Campos sugeridos:
--   first_name, last_name, city
-- ============================================================




-- ============================================================
-- Ejercicio 6 — Detalle de pedidos y productos vendidos
-- Orden:
--   Mostrar el número de pedido, el nombre del producto
--   y la cantidad vendida en cada línea de pedido.
-- Campos sugeridos:
--   salesorderid, product_name, orderqty
-- ============================================================




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

