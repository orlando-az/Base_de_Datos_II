-- ============================================================
-- CONTENIDO
-- Cubre: SELECT, WHERE, LIKE/ILIKE, BETWEEN, IN, JOINs, GROUP BY/HAVING,
-- ORDER BY, LIMIT/OFFSET
-- Instrucciones: Ejecutar cada consulta en PostgreSQL usando la base de datos de ejemplo.
-- Observar los resultados y analizar qué hace cada cláusula.
-- ============================================================

-- 1) SELECT simple – sin filtros ni condiciones
-- Muestra todos los registros de las tablas student e instructor especificadas.

-- Todos los estudiantes
SELECT * FROM student;

-- Todos los instructores
SELECT * FROM instructor;

-- 2) WHERE – operadores de comparación y lógicos
-- Filtrar resultados según condiciones con =, <>, !=, >=, <=, AND, OR.

SELECT id, first_name, last_name, enrollment_date, status
FROM student
WHERE status = 'active'
  AND enrollment_date >= DATE '2023-01-01';


SELECT id, full_name, department, salary
FROM instructor
WHERE (salary BETWEEN 2000 AND 5000)
   OR department = 'Matemáticas';

-- 3) LIKE / ILIKE
-- Buscar patrones de texto, con sensibilidad (LIKE) o sin sensibilidad (ILIKE) a mayúsculas.

SELECT id, first_name, last_name, email
FROM student
WHERE last_name LIKE 'A%';

SELECT id, first_name, last_name, email
FROM student
WHERE email ILIKE '%mail%';

-- 4) BETWEEN (fechas y números)
-- Seleccionar valores en un rango (incluye límites).

-- Cursos con créditos entre 3 y 5
SELECT id, name, credits, department
FROM course
WHERE credits BETWEEN 3 AND 5;

-- Secciones que se dictaron durante el 2024
SELECT cs.id, cs.course_id, cs.instructor_id, cs.start_date, cs.end_date
FROM class_section cs
WHERE cs.start_date BETWEEN DATE '2025-01-01' AND DATE '2025-09-30';

-- 5) IN / NOT IN
-- Comparar un valor contra una lista de valores posibles.

SELECT id, first_name, last_name, city
FROM student
WHERE city IN ('La Paz','Cochabamba','Santa Cruz');

SELECT id, course_id, modality, campus
FROM class_section
WHERE modality NOT IN ('online');

-- 6) JOINs con alias
-- Combinar datos de varias tablas.
-- INNER JOIN: solo coincidencias en ambas tablas.

SELECT e.id AS enrollment_id,
       s.id AS student_id,
       s.first_name, 
       s.last_name,
       c.id AS course_id,
       c.name AS course_name,
       e.enrolled_on, e.status, e.grade
FROM enrollment e
INNER JOIN student s   ON e.student_id = s.id
INNER JOIN class_section cs ON e.section_id = cs.id
INNER JOIN course c    ON cs.course_id = c.id;

-- LEFT JOIN: todos los registros de la tabla izquierda.

SELECT c.id AS course_id, c.name,
       COUNT(e.id) AS total_inscritos
FROM course c
LEFT JOIN class_section cs ON cs.course_id = c.id
LEFT JOIN enrollment e     ON e.section_id = cs.id
GROUP BY c.id, c.name
ORDER BY total_inscritos DESC;

-- RIGHT JOIN: todos los registros de la tabla derecha.

SELECT cs.id AS section_id, cs.course_id, cs.start_date, cs.end_date,
       COUNT(e.id) AS inscritos
FROM enrollment e
RIGHT JOIN class_section cs ON e.section_id = cs.id
GROUP BY cs.id, cs.course_id, cs.start_date, cs.end_date;

-- FULL JOIN: todos los registros de ambas tablas.

SELECT s.id AS student_id, s.first_name || ' ' || s.last_name AS student_name,
       e.id AS enrollment_id, e.enrolled_on
FROM student s
FULL JOIN enrollment e ON s.id = e.student_id;

-- 7) GROUP BY + HAVING
-- Agrupar resultados y filtrar agregados.

-- 1) Cantidad de estudiantes por ciudad
SELECT city, COUNT(*) AS cantidad_estudiantes
FROM student
GROUP BY city
ORDER BY cantidad_estudiantes DESC;

-- 2) Cursos con más de 1 inscritos (se cuenta por curso, no por sección)

SELECT c.id AS course_id, c.name,
       COUNT(e.id) AS total_inscritos
FROM course c
INNER JOIN class_section cs ON cs.course_id = c.id
INNER JOIN enrollment e     ON e.section_id = cs.id AND e.status = 'enrolled'
GROUP BY c.id, c.name
HAVING COUNT(e.id) > 1
ORDER BY total_inscritos DESC;

-- 8) ORDER BY + LIMIT/OFFSET
-- Ordenar resultados y limitar la cantidad devuelta.

SELECT id, first_name, last_name, enrollment_date
FROM student
ORDER BY last_name ASC, first_name ASC
LIMIT 10;

SELECT id, first_name, last_name, email
FROM student
ORDER BY id
LIMIT 5 OFFSET 10;