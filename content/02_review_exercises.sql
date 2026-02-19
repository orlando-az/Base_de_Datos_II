-- ============================================================
-- CONTENIDO
-- Cubre: SELECT, WHERE, JOIN, LEFT JOIN, GROUP BY, SUM,
-- ORDER BY, BETWEEN, IS NULL
-- Instrucciones: Ejecutar cada consulta en PostgreSQL usando
-- la base de datos del sistema de Administración de Condominio.
-- Observar los resultados y analizar qué hace cada cláusula.
-- ============================================================


-- ============================================================
-- 1) Listar todos los propietarios ordenados por apellido.
-- Mostrar: nombre, apellido, teléfono y email.
-- Ordenar alfabéticamente por apellido.
-- ============================================================


-- ============================================================
-- 2) Mostrar los departamentos disponibles.
-- Mostrar: número, piso y área en m2.
-- Ordenar por piso.
-- ============================================================


-- ============================================================
-- 3) Mostrar los contratos activos.
-- Un contrato activo es aquel cuya fecha_fin es NULL.
-- Mostrar: id_contrato, id_departamento, fecha_inicio y monto_mensual.
-- ============================================================


-- ============================================================
-- 4) Mostrar los pagos realizados en el año 2024.
-- Mostrar: id_pago, id_contrato, fecha_pago y monto.
-- Ordenar por fecha_pago.
-- ============================================================


-- ============================================================
-- 5) Mostrar el número de departamento y el nombre completo
-- del propietario.
-- Usar INNER JOIN entre:
--   departamento
--   propietario
-- Mostrar: numero, nombre, apellido.
-- ============================================================


-- ============================================================
-- 6) Mostrar TODOS los departamentos y su contrato (si existe).
-- Usar LEFT JOIN.
-- Tablas:
--   departamento
--   contrato
-- Mostrar:
--   numero
--   id_contrato
--   monto_mensual
-- Objetivo: que aparezcan departamentos sin contrato con NULL.
-- ============================================================


-- ============================================================
-- 7) Mostrar TODOS los empleados y los mantenimientos
-- que realizaron (si realizaron alguno).
-- Usar LEFT JOIN.
-- Tablas:
--   empleado
--   mantenimiento
-- Mostrar:
--   nombre
--   apellido
--   descripcion
--   fecha
-- Objetivo: ver empleados sin mantenimientos (NULL).
-- ============================================================


-- ============================================================
-- AGRUPACIÓN
-- ============================================================

-- ============================================================
-- 8) Calcular el total pagado por cada contrato.
-- Usar:
--   JOIN entre contrato y pago
--   SUM
--   GROUP BY
-- Mostrar:
--   id_contrato
--   total_pagado
-- Ordenar de mayor a menor.
-- ============================================================


-- ============================================================
-- 9) Mostrar el costo total de mantenimiento por departamento.
-- Usar:
--   JOIN
--   SUM
--   GROUP BY
-- Mostrar:
--   numero
--   total_mantenimiento
-- ============================================================


-- ============================================================
-- 10) Mostrar los departamentos que NO tienen propietario asignado.
-- Usar:
--   LEFT JOIN
--   WHERE id_propietario IS NULL
-- Mostrar:
--   numero
--   piso
-- ============================================================
