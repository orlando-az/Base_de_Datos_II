--=======================================================================
-- Ejercicio 1
-- Crear una función escalar llamada calcular_impuesto.
--
-- La función debe:
-- 1. Recibir un parámetro p_monto NUMERIC.
-- 2. Retornar el 13% del monto recibido.
--
-- Luego:
-- Utilizar la función en una consulta sobre sales.salesorderheader
-- mostrando:
--   - salesorderid
--   - totaldue
--   - impuesto_calculado
--=======================================================================

CREATE OR REPLACE FUNCTION sa.calcular_impuesto(monto NUMERIC)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN monto * 0.13;
END;
$$

select sa.calcular_impuesto(600)

select salesorderid as orden, 
totaldue as total_venta, 
sa.calcular_impuesto(totaldue) as impuesto
from sales.salesorderheader

--=======================================================================
-- Ejercicio 2
-- Crear una función llamada total_compras_cliente.
--
-- La función debe:
-- 1. Recibir un parámetro p_customerid INT.
-- 2. Calcular la suma total de totaldue en sales.salesorderheader
--    para ese cliente.
-- 3. Retornar 0 si el cliente no tiene compras.
--
-- Luego:
-- Ejecutar la función dentro de una consulta sobre sales.customer
-- mostrando:
--   - customerid
--   - total_compras
--=======================================================================

CREATE OR REPLACE FUNCTION compras_cliente(p_customerid int)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
	v_total_compra NUMERIC;
BEGIN
	Select sum(totaldue) INTO v_total_compra
	from sales.salesorderheader
	where customerid = p_customerid
	group by customerid;

	RETURN coalesce(v_total_compra,0);
END;
$$

drop FUNCTION compras_cliente

SELECT customerid as numero_cliente, 
compras_cliente(customerid)  as total_compra
FROM sales.customer
limit 100

--=======================================================================
-- Ejercicio 3
-- Crear una función llamada clasificar_producto.
--
-- La función debe:
-- 1. Recibir p_productid INT.
-- 2. Obtener el listprice desde production.product.
-- 3. Retornar:
--      'ALTO'  si listprice > 1000
--      'MEDIO' si listprice > 500
--      'BAJO'  en cualquier otro caso.
--
-- Luego:
-- Probar la función en una consulta mostrando:
--   - productid
--   - name
--   - clasificacion
--=======================================================================

--=======================================================================
-- Ejercicio 4
-- Crear una función que retorne tabla llamada historial_cliente.
--
-- La función debe:
-- 1. Recibir p_customerid INT.
-- 2. Retornar una tabla con:
--      - salesorderid
--      - orderdate
--      - totaldue
-- 3. Ordenar por orderdate DESC.
--
-- Luego:
-- Ejecutar la función como si fuera una tabla.
--=======================================================================

--=======================================================================
-- Ejercicio 5
-- Crear una función avanzada llamada top_productos_categoria.
--
-- La función debe:
-- 1. Recibir p_categoria INT.
-- 2. Realizar JOIN entre:
--      production.product
--      production.productsubcategory
--      production.productcategory
--      sales.salesorderdetail
-- 3. Calcular el total vendido (SUM linetotal) por producto.
-- 4. Retornar:
--      - productid
--      - nombre
--      - total_vendido
-- 5. Ordenar por total_vendido DESC.
-- 6. Retornar solo los 5 productos más vendidos.
--=======================================================================