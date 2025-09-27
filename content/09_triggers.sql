-- Ejercicio 1:
-- Crear una función trigger que, antes de insertar o 
-- actualizar un registro en enrollment,
-- verifique si grade es menor que 0 y, en ese caso, 
-- lo ajuste automáticamente a 0.
-- Luego, crear un trigger que ejecute esta función en 
-- cada fila.

-- CREATE OR REPLACE FUNCTION ()
-- RETURNS TRIGGER 
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
-- END;
-- $$

-- CREATE TRIGGER 
-- BEFORE INSERT OR UPDATE ON 
-- FOR EACH ROW
-- EXECUTE FUNCTION

CREATE OR REPLACE FUNCTION update_grade()
RETURNS TRIGGER
LANGUAGE plpgsql as $$
BEGIN
	IF NEW.grade < 0 THEN
	NEW.grade := 0;
	RETURN NEW;
	ELSE
	RETURN NEW;
	END IF;
END;
$$
CREATE TRIGGER tg_update_grade
BEFORE INSERT OR UPDATE ON enrollment
FOR EACH ROW
EXECUTE FUNCTION update_grade()

INSERT INTO enrollment(student_id,section_id,enrolled_on,status,grade)
values (2,5,current_date,'completed',-10)

UPDATE enrollment
SET grade=-10
where id=25

-- Ejercicio 2
-- Crear un trigger que muestre un aviso cada vez que se inserte una 
-- sección de clase (class_section) sin un instructor asignado 
-- (instructor_id es NULL).

CREATE OR REPLACE FUNCTION fn_class_section()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF NEW.modality is null then
	 RAISE EXCEPTION 'La modalidad no puede ser nula';
	else if NEW.modality not in ('onsite','online') then
	 RAISE EXCEPTION 'La modalidad solo puede ser onsite o online';
	else
	RETURN NEW;
	END IF;
	END IF;
END;
$$

create TRIGGER insert_class_section
AFTER INSERT ON class_section
FOR EACH ROW
EXECUTE FUNCTION fn_class_section()

select * from class_section
INSERT INTO class_section
(course_id,instructor_id,start_date,end_date,modality,campus)
VALUES(1,2,current_date,'2025-09-30','onsite','central')

CREATE OR REPLACE FUNCTION fn_class_section()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	IF NEW.modality is null then
	 RAISE EXCEPTION 'La modalidad no puede ser nula';
	ELSif NEW.modality not in ('onsite','online') then
	 RAISE EXCEPTION 'La modalidad solo puede ser onsite o online';
	END IF;
	
	RETURN NEW;
END;
$$

-- Ejercicio 3
-- Registrar en una tabla de auditoría cada vez que se modifique 
-- el estado de un estudiante (status) en la tabla student.
-- Crea una tabla llamada student_audit con las siguientes columnas:

