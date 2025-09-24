-- Ejercicio 1:
-- Cree una función llamada fn_fullname
-- que reciba como parámetro el identificador de una persona y 
-- retorne el nombre completo de esa persona.
-- CREATE OR REPLACE FUNCTION ()
-- RETURNS TEXT
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE ;
-- BEGIN
--   ;
--   RETURN;
-- END;
-- $$;

CREATE or REPLACE FUNCTION person.fn_fullname(person_id int)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
	v_fullname TEXT;
BEGIN
	SELECT firstname || ' '  || lastname
	into v_fullname
	FROM person.person
	where businessentityid = person_id;
	RETURN v_fullname;
END;
$$

SELECT person.fn_fullname(50)

-- Ejercicio 2
-- Crear una función total_customer que reciba como parámetros 
-- el id de cliente y un año, 
-- y retorne el total de compras realizadas por ese cliente en ese año.

CREATE OR REPLACE FUNCTION sales.total_customer(customer_id int, anio int)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
 v_total NUMERIC;
BEGIN
	select sum(totaldue)
	into v_total
	from sales.salesorderheader
	where customer_id=customerid and EXTRACT(YEAR FROM orderdate)=anio;
	return v_total;
END;
$$

SELECT sales.total_customer(29825,2014)

select * from sales.salesorderheader
where customerid=29825

-- Ejercicio 3
-- Definir una función  que tome como entrada el id de un producto y 
-- devuelva una tabla con el id
-- y el nombre de los proveedores asociados.
-- CREATE OR REPLACE FUNCTION ()
-- RETURNS TABLE()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--   RETURN QUERY
-- END;
-- $$;

CREATE OR REPLACE FUNCTION purchasing.fn_vendor_product(product_id int)
RETURNS TABLE(vendor_id int, vendor_name TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	Select pv.productid, v.name::TEXT
	from purchasing.productvendor pv
	INNER JOIN purchasing.vendor v on 
	pv.businessentityid= v.businessentityid
	where pv.productid= product_id;
END;
$$

select purchasing.fn_vendor_product(938)


SELECT productid, count( businessentityid) 
FROM purchasing.productvendor
group by productid
having count(businessentityid)>1

SELECT * from purchasing.productvendor
where businessentityid=1672



-- Ejercicio 4
-- Crear una función que reciba un id del cliente y un año, y devuelva la categoría del cliente 
-- (Premium, Regular o Básico) según el total de compras en ese año.


