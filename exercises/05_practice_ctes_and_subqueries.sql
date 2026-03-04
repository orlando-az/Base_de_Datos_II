-- ======================================================================
--                              SUBQUERIES
-- ======================================================================
--=======================================================================
-- Ejercicio 1
-- El área comercial necesita identificar el producto más costoso dentro
-- de cada subcategoría y verificar si dicho producto ha sido vendido
-- al menos una vez en el sistema.

-- Determinar el precio máximo (listprice) por subcategoría.
-- Mostrar el producto que posea dicho precio.
-- Indicar mediante una columna adicional si el producto registra ventas.
--=======================================================================

--=======================================================================
-- Ejercicio 2
-- El área de marketing desea identificar clientes que hayan comprado
-- TODOS los productos pertenecientes a una subcategoría específica.

-- Seleccionar los productos de la subcategoría indicada.
-- Calcular cuántos productos existen en dicha subcategoría.
-- Determinar qué clientes compraron la totalidad de esos productos.
--=======================================================================

-- ======================================================================
--                              CTES
-- ======================================================================

--=======================================================================
-- Ejercicio 3
-- El área de logística necesita detectar productos que actualmente
-- tienen inventario registrado pero no poseen ventas históricas.

-- Obtener el conjunto de productos presentes en inventario.
-- Obtener el conjunto de productos vendidos.
-- Identificar aquellos productos que estén en inventario
-- pero no aparezcan en el historial de ventas.
--=======================================================================

--=======================================================================
-- Ejercicio 4
-- Recursos Humanos requiere conocer la cantidad de empleados activos
-- por departamento para evaluar la distribución organizacional.

-- Considerar únicamente empleados sin fecha de finalización (enddate).
-- Agrupar por departamento.
-- Ordenar los resultados de mayor a menor cantidad de empleados.
--=======================================================================

--=======================================================================
-- Ejercicio 5
-- El área estratégica necesita determinar qué territorio posee
-- la mayor cantidad de clientes registrados.

-- Contabilizar los clientes por territorio.
-- Excluir territorios nulos.
-- Identificar el territorio con el valor máximo.
--=======================================================================

--=======================================================================
-- Ejercicio 6
-- La gerencia comercial desea identificar el segundo producto más caro
-- del catálogo utilizando funciones de ventana.

-- Deberán investigar las funciones de ventana RANK(), DENSE_RANK()
-- y ROW_NUMBER() en PostgreSQL.

-- Determinar cuál de ellas es conceptualmente correcta cuando se
-- trabaja con valores repetidos (precios iguales).

-- Aplicar la función adecuada para:
--   1) Generar un ranking de precios ordenado de mayor a menor.
--   2) Asignar correctamente la posición considerando precios iguales.
--   3) Obtener el/los producto(s) que ocupen la segunda posición.

-- No se permite el uso de subconsultas correlacionadas ni conteos manuales.
--=======================================================================

WITH ranking AS (
    SELECT productid,
           name,
           listprice,
           DENSE_RANK() OVER (ORDER BY listprice DESC) AS posicion
    FROM production.product
)
SELECT productid, name, listprice
FROM ranking
WHERE posicion = 2;

--=======================================================================
-- Ejercicio 7
-- El área de fidelización requiere detectar clientes inactivos,
-- entendiendo como tales aquellos cuya última compra se haya realizado
-- hace más de 2 años respecto a la fecha máxima registrada en el sistema.
--
-- IMPORTANTE
-- La comparación de fechas debe realizarse obligatoriamente utilizando
-- el tipo de dato INTERVAL.
-- Deberá investigar la sintaxis correcta para restar
-- intervalos de tiempo a una fecha en PostgreSQL.
--
-- Obtener la última fecha de compra por cliente.
-- Obtener la fecha máxima de compra del sistema.
-- Comparar ambas fechas utilizando INTERVAL para determinar
-- aquellos clientes cuya inactividad sea superior a 2 años.
--=======================================================================

WITH ultima_compra AS (
    SELECT customerid,
           MAX(orderdate) AS ultima_fecha
    FROM sales.salesorderheader
    GROUP BY customerid
),
fecha_max AS (
    SELECT MAX(orderdate) AS fecha_maxima
    FROM sales.salesorderheader
)
SELECT uc.customerid,
       uc.ultima_fecha
FROM ultima_compra uc
INNER JOIN fecha_max fm
        ON uc.ultima_fecha < (fm.fecha_maxima - INTERVAL '2 years')
ORDER BY uc.ultima_fecha;