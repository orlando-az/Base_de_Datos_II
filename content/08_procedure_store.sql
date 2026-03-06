-- ============================================================
-- EJERCICIO 1
-- Registro de propietario con validación de email
-- ============================================================
-- Crear un procedimiento que:
-- 1) Reciba nombre, apellido, teléfono y email.
-- 2) Verifique que el email no exista.
-- 3) Si no existe, inserte el propietario.
-- 4) Si existe, mostrar un mensaje y no insertar.


-- ============================================================
-- EJERCICIO 1
-- Registro de propietario con validación de email
-- ============================================================

CREATE OR REPLACE PROCEDURE validar_email(p_nombre TEXT,
p_apellido TEXT,
p_telefono TEXT,
p_email TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
	idpropietario INT;
BEGIN
	select id_propietario INTO idpropietario
	from propietario
	where p_email = email;

	if idpropietario is not null then 
	 RAISE NOTICE 'Email ya existe';
	end if;
	
	INSERT INTO propietario(nombre,apellido,telefono,email)
	values(p_nombre,p_apellido,p_telefono,p_email);
END;
$$;

-- ============================================================
-- EJERCICIO 2
-- Registro de contrato con control de disponibilidad
-- ============================================================
-- Crear un procedimiento que:
-- 1) Reciba datos del contrato.
-- 2) Verifique que el departamento esté en estado 'disponible'.
-- 3) Si está disponible, registre el contrato.
-- 4) Actualice el estado del departamento a 'ocupado'.
-- 5) Si no está disponible, mostrar mensaje.
---SELECT -->FUNCTION
-- CALL

select * from propietario

CALL validar_email('ernesto','torrez','74896322','ernesto.torrez1@gmail.com')

INSERT INTO usuarios(nombre, email)
VALUES ('Juan', 'juan@gmail.com');

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE EXTENSION IF NOT EXISTS pg_nanoid;
insert into prueba(texto) values('valor 3')

select * from prueba

CREATE OR REPLACE FUNCTION nanoid(size int DEFAULT 50)
RETURNS text AS $$
DECLARE
  alphabet text := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  id text := '';
  i int := 0;
BEGIN
  FOR i IN 1..size LOOP
    id := id || substr(alphabet, (get_byte(gen_random_bytes(1),0) % length(alphabet)) + 1, 1);
  END LOOP;
  RETURN id;
END;
$$ LANGUAGE plpgsql;

delete from prueba where id='dfda'

CREATE OR REPLACE procedure validar_disponibilidad(
	iddepartamento int,
	fechaini date,
	fechafin date,
	monto numeric,
	deposito numeric
)
LANGUAGE plpgsql
AS $$
DECLARE
	estado_departamento text;
BEGIN
	select estado into estado_departamento
	from
	departamento
	where id_departamento = iddepartamento;

	if estado_departamento ='ocupado' THEN
		RAISE NOTICE 'El departamento no esta disponible';
	END IF;

	INSERT INTO contrato(id_departamento,fecha_inicio,fecha_fin,monto_mensual,deposito_garantia)
	VALUES(iddepartamento,fechaini,fechafin,monto,deposito);

	UPDATE departamento
	SET estado='ocupado'
	where id_departamento=iddepartamento;
	
END;
$$

SELECT * FROM departamento

select * from contrato

CALL validar_disponibilidad(8, '2026-03-06','2026-04-06',2000,10000)

-- ============================================================
-- EJERCICIO 3
-- Registro de pago validando contrato
-- ============================================================
-- Crear un procedimiento que:
-- 1) Reciba id_contrato, fecha_pago, monto y metodo_pago.
-- 2) Verifique que el contrato exista.
-- 3) Verifique que el monto sea mayor a 0.
-- 4) Si todo es correcto, registre el pago.

CREATE OR REPLACE PROCEDURE registrar_pago(
    p_id_contrato INT,
    p_fecha_pago DATE,
    p_monto NUMERIC,
    p_metodo_pago TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    existe INT;
BEGIN

    SELECT COUNT(*)
    INTO existe
    FROM contratos
    WHERE id_contrato = p_id_contrato;

    IF existe = 0 THEN
        RAISE NOTICE 'El contrato no existe';
        RETURN;
    END IF;

    IF p_monto <= 0 THEN
        RAISE NOTICE 'El monto debe ser mayor a 0';
        RETURN;
    END IF;

    INSERT INTO pagos(id_contrato, fecha_pago, monto, metodo_pago)
    VALUES (p_id_contrato, p_fecha_pago, p_monto, p_metodo_pago);

    RAISE NOTICE 'Pago registrado correctamente';

END;
$$;

-- ============================================================
-- EJERCICIO 4
-- Registro de mantenimiento con control de errores
-- ============================================================
-- Crear un procedimiento que:
-- 1) Reciba datos del mantenimiento.
-- 2) Inserte el registro.
-- 3) Capture errores por claves foráneas inválidas.
-- 4) Muestre un mensaje en caso de error.

CREATE OR REPLACE PROCEDURE registrar_mantenimiento(
    p_id_departamento INT,
    p_fecha DATE,
    p_descripcion TEXT,
    p_costo NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO mantenimientos(id_departamento, fecha, descripcion, costo)
    VALUES (p_id_departamento, p_fecha, p_descripcion, p_costo);

    RAISE NOTICE 'Mantenimiento registrado correctamente';

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'Error: departamento no válido';

    WHEN OTHERS THEN
        RAISE NOTICE 'Error inesperado';
END;
$$;

-- ============================================================
-- EJERCICIO 5
-- Finalización de contrato
-- ============================================================
-- Crear un procedimiento que:
-- 1) Reciba id_contrato y fecha_fin.
-- 2) Verifique que el contrato no esté finalizado.
-- 3) Actualice la fecha_fin.
-- 4) Cambie el estado del departamento a 'disponible'.

CREATE OR REPLACE PROCEDURE finalizar_contrato(
    p_id_contrato INT,
    p_fecha_fin DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    estado_actual DATE;
    dep_id INT;
BEGIN

    SELECT fecha_fin, id_departamento
    INTO estado_actual, dep_id
    FROM contratos
    WHERE id_contrato = p_id_contrato;

    IF estado_actual IS NOT NULL THEN
        RAISE NOTICE 'El contrato ya está finalizado';
        RETURN;
    END IF;

    UPDATE contratos
    SET fecha_fin = p_fecha_fin
    WHERE id_contrato = p_id_contrato;

    UPDATE departamentos
    SET estado = 'disponible'
    WHERE id_departamento = dep_id;

    RAISE NOTICE 'Contrato finalizado correctamente';

END;
$$;