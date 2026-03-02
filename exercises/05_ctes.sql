-- ============================================================
-- Ejercicio 1
-- ============================================================
-- El área financiera necesita conocer el total facturado por año.
--
-- Requerimientos:
-- 1. Crear una CTE que calcule el total anual de ventas usando
--    sales.salesorderheader.
-- 2. Extraer el año desde orderdate.
-- 3. Mostrar:
--       - Año
--       - Total facturado
-- 4. Ordenar por año ascendente.
-- ============================================================


-- ============================================================
-- Ejercicio 2
-- ============================================================
-- Identificar los clientes cuyo total de compras en un año
-- sea superior al promedio de ventas de ese mismo año.
--
-- Requerimientos:
-- 1. CTE 1: calcular el total comprado por customerid y año.
-- 2. CTE 2: calcular el promedio anual de ventas.
-- 3. Consulta final:
--       - Año
--       - CustomerID
--       - Total comprado
-- 4. Filtrar aquellos cuyo total anual sea mayor al promedio anual.
-- ============================================================



-- ============================================================
-- Ejercicio 3
-- ============================================================
-- Determinar el producto más vendido y el menos vendido
-- (en cantidad) por cada año.
--
-- Requerimientos:
-- 1. CTE 1: calcular la cantidad total vendida por producto y año.
-- 2. CTE 2: obtener el máximo y mínimo por año.
-- 3. Consulta final:
--       - Año
--       - Producto
--       - Cantidad total
--       - Indicar si es 'Más vendido' o 'Menos vendido'
-- ============================================================



-- ============================================================
-- Ejercicio 4
-- ============================================================
-- Generar un ranking anual de vendedores según total facturado.
--
-- Requerimientos:
-- 1. CTE: calcular total vendido por salespersonid y año.
-- 2. Aplicar RANK() o DENSE_RANK() particionado por año.
-- 3. Mostrar solo los 3 primeros vendedores por año.
-- 4. Mostrar:
--       - Año
--       - Nombre del vendedor
--       - Total vendido
--       - Ranking
-- ============================================================



-- ============================================================
-- Ejercicio 5
-- ============================================================
-- Identificar clientes que hayan realizado compras
-- en al menos 3 años consecutivos.
--
-- Requerimientos:
-- 1. CTE base: obtener años distintos de compra por cliente.
-- 2. Crear una CTE que detecte secuencias consecutivas.
-- 3. Mostrar:
--       - CustomerID
--       - Año inicial de la secuencia
--       - Longitud de la secuencia
-- 4. Filtrar secuencias mayores o iguales a 3 años.
-- ============================================================