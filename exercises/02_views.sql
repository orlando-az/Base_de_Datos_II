-- Ejercicio 1 

-- Objetivo: Resumen de ventas por cliente y año.
-- Descripción: Crear una vista que muestre, para cada cliente y año:

-- Nombre completo del cliente.
-- Año del pedido.
-- Número total de pedidos.
-- Total gastado.
-- Agrupar por cliente y año.


-- Ejercicio 2 

-- Objetivo: Detalle de órdenes por proveedor y producto.

-- Mostrar:

-- Nombre del proveedor
-- Nombre del producto
-- Total de unidades pedidas
-- Costo total de la compra
-- Fecha del pedido más reciente


--Ejercicio 3

select
    st.name as territory_name,
    p.firstname || ' ' || p.lastname as customer_name,
    sum(soh.totaldue) as total_sales,
    ROUND(avg(soh.totaldue),2) as promedio_orden
from sales.salesorderheader soh
join sales.customer c on soh.customerid = c.customerid
inner join person.person p on c.personid = p.businessentityid
inner join sales.salesterritory st on soh.territoryid = st.territoryid
where extract(year from soh.orderdate) = 2013
group by st.name, customer_name
having count(soh.salesorderid) >= 10
order by st.name, total_sales desc;