--=======================================================================
-- Ejercicio 1
-- Crear una función llamada total_productos_orden.
--
-- La función debe:
-- 1. Recibir un parámetro p_salesorderid INT.
-- 2. Calcular la suma de orderqty desde sales.salesorderdetail
--    para esa orden.
-- 3. Retornar 0 si la orden no tiene productos.
--
-- Luego:
-- Utilizar la función en una consulta sobre sales.salesorderheader
-- mostrando:
--   - salesorderid
--   - totaldue
--   - total_productos
--=======================================================================

CREATE OR REPLACE FUNCTION sa.total_productos_orden(p_salesorderid INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total_productos INT;
BEGIN
    SELECT SUM(orderqty)
    INTO v_total_productos
    FROM sales.salesorderdetail
    WHERE salesorderid = p_salesorderid;

    RETURN COALESCE(v_total_productos,0);
END;
$$;

SELECT 
salesorderid,
totaldue,
sa.total_productos_orden(salesorderid) AS total_productos
FROM sales.salesorderheader
LIMIT 100;

--=======================================================================
-- Ejercicio 2
-- Crear una función llamada precio_promedio_subcategoria.
--
-- La función debe:
-- 1. Recibir un parámetro p_subcategoryid INT.
-- 2. Calcular el promedio (AVG) de listprice
--    desde production.product para esa subcategoría.
-- 3. Retornar 0 si no existen productos.
--
-- Luego:
-- Ejecutar la función en una consulta mostrando:
--   - productsubcategoryid
--   - name
--   - precio_promedio
--=======================================================================

CREATE OR REPLACE FUNCTION sa.precio_promedio_subcategoria(p_subcategoryid INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    v_promedio NUMERIC;
BEGIN
    SELECT AVG(listprice)
    INTO v_promedio
    FROM production.product
    WHERE productsubcategoryid = p_subcategoryid;

    RETURN COALESCE(v_promedio,0);
END;
$$;

SELECT 
productsubcategoryid,
name,
sa.precio_promedio_subcategoria(productsubcategoryid) AS precio_promedio
FROM production.productsubcategory;

--=======================================================================
-- Ejercicio 3
-- Crear una función llamada estado_cliente.
--
-- La función debe:
-- 1. Recibir un parámetro p_customerid INT.
-- 2. Calcular el total de compras del cliente
--    usando sales.salesorderheader.
-- 3. Clasificar al cliente como:
--       'CLIENTE VIP'    si total > 20000
--       'CLIENTE NORMAL' si total > 5000
--       'CLIENTE BAJO'   en cualquier otro caso.
--
-- Luego:
-- Probar la función en una consulta mostrando:
--   - customerid
--   - estado_cliente
--=======================================================================

CREATE OR REPLACE FUNCTION sa.estado_cliente(p_customerid INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    v_total NUMERIC;
BEGIN
    SELECT SUM(totaldue)
    INTO v_total
    FROM sales.salesorderheader
    WHERE customerid = p_customerid;

    v_total := COALESCE(v_total,0);

    IF v_total > 20000 THEN
        RETURN 'CLIENTE VIP';
    ELSIF v_total > 5000 THEN
        RETURN 'CLIENTE NORMAL';
    ELSE
        RETURN 'CLIENTE BAJO';
    END IF;
END;
$$;





