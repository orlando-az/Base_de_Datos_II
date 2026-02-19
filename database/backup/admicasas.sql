--
-- PostgreSQL database dump
--

\restrict bU8WUm83TcndYgPnk61Or3lbaD8eHSGkPhSj1tbxiprBF3UwD8cfFiS3sUStYVd

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-18 23:29:17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 24611)
-- Name: contrato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contrato (
    id_contrato integer NOT NULL,
    id_departamento integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date,
    monto_mensual numeric(10,2) NOT NULL,
    deposito_garantia numeric(10,2),
    CONSTRAINT contrato_deposito_garantia_check CHECK ((deposito_garantia >= (0)::numeric)),
    CONSTRAINT contrato_monto_mensual_check CHECK ((monto_mensual > (0)::numeric))
);


ALTER TABLE public.contrato OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24610)
-- Name: contrato_id_contrato_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contrato_id_contrato_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contrato_id_contrato_seq OWNER TO postgres;

--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 223
-- Name: contrato_id_contrato_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contrato_id_contrato_seq OWNED BY public.contrato.id_contrato;


--
-- TOC entry 222 (class 1259 OID 24590)
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    id_departamento integer NOT NULL,
    numero character varying(10) NOT NULL,
    piso integer NOT NULL,
    area_m2 numeric(6,2),
    estado character varying(15) NOT NULL,
    id_propietario integer,
    CONSTRAINT departamento_area_m2_check CHECK ((area_m2 > (20)::numeric)),
    CONSTRAINT departamento_estado_check CHECK (((estado)::text = ANY ((ARRAY['ocupado'::character varying, 'disponible'::character varying])::text[]))),
    CONSTRAINT departamento_piso_check CHECK (((piso >= 1) AND (piso <= 12)))
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24589)
-- Name: departamento_id_departamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departamento_id_departamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departamento_id_departamento_seq OWNER TO postgres;

--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 221
-- Name: departamento_id_departamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departamento_id_departamento_seq OWNED BY public.departamento.id_departamento;


--
-- TOC entry 228 (class 1259 OID 24647)
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    id_empleado integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    cargo character varying(40) NOT NULL,
    salario numeric(10,2),
    CONSTRAINT empleado_salario_check CHECK ((salario > (2000)::numeric))
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24646)
-- Name: empleado_id_empleado_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.empleado_id_empleado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.empleado_id_empleado_seq OWNER TO postgres;

--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 227
-- Name: empleado_id_empleado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.empleado_id_empleado_seq OWNED BY public.empleado.id_empleado;


--
-- TOC entry 230 (class 1259 OID 24659)
-- Name: mantenimiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mantenimiento (
    id_mantenimiento integer NOT NULL,
    id_departamento integer NOT NULL,
    id_empleado integer,
    fecha date NOT NULL,
    descripcion text,
    costo numeric(10,2),
    CONSTRAINT mantenimiento_costo_check CHECK ((costo >= (0)::numeric))
);


ALTER TABLE public.mantenimiento OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24658)
-- Name: mantenimiento_id_mantenimiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mantenimiento_id_mantenimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mantenimiento_id_mantenimiento_seq OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 229
-- Name: mantenimiento_id_mantenimiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mantenimiento_id_mantenimiento_seq OWNED BY public.mantenimiento.id_mantenimiento;


--
-- TOC entry 226 (class 1259 OID 24629)
-- Name: pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pago (
    id_pago integer NOT NULL,
    id_contrato integer NOT NULL,
    fecha_pago date NOT NULL,
    monto numeric(10,2) NOT NULL,
    metodo_pago character varying(20),
    CONSTRAINT pago_metodo_pago_check CHECK (((metodo_pago)::text = ANY ((ARRAY['transferencia'::character varying, 'efectivo'::character varying, 'qr'::character varying])::text[]))),
    CONSTRAINT pago_monto_check CHECK ((monto > (0)::numeric))
);


ALTER TABLE public.pago OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24628)
-- Name: pago_id_pago_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pago_id_pago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pago_id_pago_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 225
-- Name: pago_id_pago_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pago_id_pago_seq OWNED BY public.pago.id_pago;


--
-- TOC entry 220 (class 1259 OID 24578)
-- Name: propietario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.propietario (
    id_propietario integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    telefono character varying(15),
    email character varying(120)
);


ALTER TABLE public.propietario OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24577)
-- Name: propietario_id_propietario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.propietario_id_propietario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.propietario_id_propietario_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 219
-- Name: propietario_id_propietario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.propietario_id_propietario_seq OWNED BY public.propietario.id_propietario;


--
-- TOC entry 4782 (class 2604 OID 24614)
-- Name: contrato id_contrato; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrato ALTER COLUMN id_contrato SET DEFAULT nextval('public.contrato_id_contrato_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 24593)
-- Name: departamento id_departamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento ALTER COLUMN id_departamento SET DEFAULT nextval('public.departamento_id_departamento_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 24650)
-- Name: empleado id_empleado; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado ALTER COLUMN id_empleado SET DEFAULT nextval('public.empleado_id_empleado_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 24662)
-- Name: mantenimiento id_mantenimiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento ALTER COLUMN id_mantenimiento SET DEFAULT nextval('public.mantenimiento_id_mantenimiento_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 24632)
-- Name: pago id_pago; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago ALTER COLUMN id_pago SET DEFAULT nextval('public.pago_id_pago_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 24581)
-- Name: propietario id_propietario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propietario ALTER COLUMN id_propietario SET DEFAULT nextval('public.propietario_id_propietario_seq'::regclass);


--
-- TOC entry 4968 (class 0 OID 24611)
-- Dependencies: 224
-- Data for Name: contrato; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (1, 1, '2024-04-09', NULL, 2537.99, 1566.93);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (2, 2, '2023-01-29', '2025-12-31', 2776.06, 3104.77);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (3, 3, '2023-03-17', '2025-12-31', 2379.51, 3214.52);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (4, 5, '2023-04-27', '2025-12-31', 1908.82, 2211.64);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (5, 6, '2023-07-11', NULL, 3093.16, 2964.81);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (6, 7, '2023-12-01', '2025-12-31', 2588.81, 2883.88);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (7, 9, '2023-04-28', NULL, 2636.20, 2891.58);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (8, 10, '2023-06-30', NULL, 2283.45, 2321.33);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (9, 11, '2023-01-12', NULL, 3254.23, 2820.45);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (10, 13, '2023-10-04', NULL, 1568.43, 2943.17);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (11, 14, '2023-04-22', '2025-12-31', 1972.20, 1773.80);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (12, 15, '2024-02-15', '2025-12-31', 1643.99, 2359.86);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (13, 17, '2023-12-04', NULL, 3303.83, 2326.42);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (14, 18, '2023-06-28', NULL, 3291.36, 2139.96);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (15, 19, '2023-06-02', NULL, 3021.45, 2746.63);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (16, 21, '2024-03-02', NULL, 2107.36, 1936.42);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (17, 22, '2024-03-09', '2025-12-31', 2793.05, 1658.15);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (18, 23, '2024-05-02', NULL, 2332.16, 3282.53);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (19, 25, '2023-08-02', NULL, 2607.33, 2485.16);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (20, 26, '2023-12-06', NULL, 1502.43, 2486.89);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (21, 27, '2023-06-21', '2025-12-31', 2236.67, 2155.41);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (22, 29, '2024-04-11', '2025-12-31', 1648.73, 3395.81);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (23, 30, '2024-01-08', '2025-12-31', 2878.14, 1573.36);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (24, 31, '2024-04-13', NULL, 2792.57, 2504.71);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (25, 33, '2024-05-09', '2025-12-31', 2838.87, 2898.42);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (26, 34, '2023-11-17', '2025-12-31', 1709.89, 3428.83);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (27, 35, '2024-02-02', NULL, 3446.21, 2437.79);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (28, 37, '2024-01-19', NULL, 3107.14, 1569.81);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (29, 38, '2023-02-27', NULL, 3376.11, 2478.00);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (30, 39, '2023-07-02', NULL, 3297.62, 2982.85);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (31, 41, '2023-03-17', '2025-12-31', 2435.10, 2201.17);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (32, 42, '2023-11-06', '2025-12-31', 3389.50, 2160.36);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (33, 43, '2024-03-25', '2025-12-31', 2344.80, 2321.03);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (34, 45, '2023-06-21', NULL, 3361.10, 1931.78);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (35, 46, '2023-08-10', NULL, 3201.28, 3234.33);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (36, 47, '2023-12-07', NULL, 2248.99, 2471.16);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (37, 49, '2024-03-11', NULL, 3052.30, 1852.55);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (38, 50, '2023-06-15', '2025-12-31', 2974.91, 1808.10);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (39, 51, '2023-07-24', NULL, 1965.82, 3000.74);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (40, 53, '2023-09-25', NULL, 2057.89, 2366.24);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (41, 54, '2023-11-11', '2025-12-31', 1914.79, 2432.54);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (42, 55, '2023-01-30', NULL, 2199.92, 1863.95);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (43, 57, '2023-08-28', NULL, 1832.50, 3389.86);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (44, 58, '2023-04-03', NULL, 2397.22, 1613.63);
INSERT INTO public.contrato (id_contrato, id_departamento, fecha_inicio, fecha_fin, monto_mensual, deposito_garantia) VALUES (45, 59, '2023-01-24', '2025-12-31', 1666.31, 2356.01);


--
-- TOC entry 4966 (class 0 OID 24590)
-- Dependencies: 222
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (1, '101', 2, 84.68, 'ocupado', 2);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (2, '102', 3, 83.21, 'ocupado', 3);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (3, '103', 4, 95.80, 'ocupado', 4);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (4, '104', 5, 71.53, 'disponible', 5);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (5, '105', 6, 45.68, 'ocupado', 6);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (6, '106', 7, 94.71, 'ocupado', 7);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (7, '107', 8, 105.02, 'ocupado', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (8, '108', 9, 89.46, 'disponible', 9);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (9, '109', 10, 96.23, 'ocupado', 10);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (10, '110', 11, 80.14, 'ocupado', 11);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (11, '111', 12, 66.36, 'ocupado', 12);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (12, '112', 1, 75.94, 'disponible', 13);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (13, '113', 2, 115.91, 'ocupado', 14);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (14, '114', 3, 102.27, 'ocupado', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (15, '115', 4, 70.22, 'ocupado', 16);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (16, '116', 5, 76.58, 'disponible', 17);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (17, '117', 6, 102.07, 'ocupado', 18);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (18, '118', 7, 60.18, 'ocupado', 19);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (19, '119', 8, 123.56, 'ocupado', 20);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (20, '120', 9, 74.03, 'disponible', 21);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (21, '121', 10, 83.33, 'ocupado', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (22, '122', 11, 61.44, 'ocupado', 23);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (23, '123', 12, 110.78, 'ocupado', 24);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (24, '124', 1, 83.09, 'disponible', 25);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (25, '125', 2, 112.02, 'ocupado', 26);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (26, '126', 3, 87.20, 'ocupado', 27);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (27, '127', 4, 86.24, 'ocupado', 28);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (28, '128', 5, 88.91, 'disponible', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (29, '129', 6, 100.95, 'ocupado', 30);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (30, '130', 7, 64.09, 'ocupado', 31);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (31, '131', 8, 100.53, 'ocupado', 32);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (32, '132', 9, 119.42, 'disponible', 33);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (33, '133', 10, 77.32, 'ocupado', 34);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (34, '134', 11, 96.73, 'ocupado', 35);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (35, '135', 12, 63.51, 'ocupado', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (36, '136', 1, 124.33, 'disponible', 37);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (37, '137', 2, 73.85, 'ocupado', 38);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (38, '138', 3, 92.90, 'ocupado', 39);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (39, '139', 4, 45.68, 'ocupado', 40);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (40, '140', 5, 102.05, 'disponible', 41);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (41, '141', 6, 86.12, 'ocupado', 42);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (42, '142', 7, 77.16, 'ocupado', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (43, '143', 8, 80.28, 'ocupado', 44);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (44, '144', 9, 83.61, 'disponible', 45);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (45, '145', 10, 67.61, 'ocupado', 46);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (46, '146', 11, 120.06, 'ocupado', 47);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (47, '147', 12, 45.66, 'ocupado', 48);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (48, '148', 1, 78.04, 'disponible', 49);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (49, '149', 2, 107.66, 'ocupado', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (50, '150', 3, 63.44, 'ocupado', 1);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (51, '151', 4, 86.66, 'ocupado', 2);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (52, '152', 5, 99.65, 'disponible', 3);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (53, '153', 6, 101.36, 'ocupado', 4);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (54, '154', 7, 80.92, 'ocupado', 5);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (55, '155', 8, 96.55, 'ocupado', 6);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (56, '156', 9, 49.66, 'disponible', NULL);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (57, '157', 10, 72.92, 'ocupado', 8);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (58, '158', 11, 119.14, 'ocupado', 9);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (59, '159', 12, 83.41, 'ocupado', 10);
INSERT INTO public.departamento (id_departamento, numero, piso, area_m2, estado, id_propietario) VALUES (60, '160', 1, 62.12, 'disponible', 11);


--
-- TOC entry 4972 (class 0 OID 24647)
-- Dependencies: 228
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (1, 'Pedro', 'Lopez', 'Conserje', 5148.08);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (2, 'Juan', 'Perez', 'Seguridad', 4011.96);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (3, 'Luis', 'Sanchez', 'Electricista', 5080.33);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (4, 'Mario', 'Torrez', 'Plomero', 3841.06);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (5, 'Ricardo', 'Gutierrez', 'Jardinero', 3549.03);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (6, 'Sofia', 'Rojas', 'Administrador', 5019.83);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (7, 'Gabriela', 'Flores', 'Supervisor', 3222.69);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (8, 'Andrea', 'Ramirez', 'Técnico HVAC', 2590.11);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (9, 'Valeria', 'Castro', 'Auxiliar Administrativo', 3108.14);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (10, 'Carlos', 'Suarez', 'Mantenimiento General', 3660.40);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (11, 'Miguel', 'Morales', 'Conserje', 4111.55);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (12, 'Daniel', 'Ortiz', 'Seguridad', 4538.42);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (13, 'Fernando', 'Mendoza', 'Electricista', 4808.63);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (14, 'Hector', 'Aguilar', 'Plomero', 5864.33);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (15, 'Raul', 'Chavez', 'Jardinero', 5484.80);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (16, 'Elena', 'Alvarez', 'Administrador', 4025.99);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (17, 'Patricia', 'Romero', 'Supervisor', 4007.15);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (18, 'Lucia', 'Herrera', 'Técnico HVAC', 3118.81);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (19, 'Claudia', 'Cardenas', 'Auxiliar Administrativo', 2977.82);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (20, 'Tatiana', 'Navarro', 'Mantenimiento General', 4099.42);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (21, 'Ruben', 'Paredes', 'Conserje', 4774.20);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (22, 'Victor', 'Salazar', 'Seguridad', 3958.45);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (23, 'Marco', 'Arias', 'Electricista', 3979.60);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (24, 'Alberto', 'Valdez', 'Plomero', 4460.34);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (25, 'Roberto', 'Quiroga', 'Jardinero', 3403.03);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (26, 'Natalia', 'Velasco', 'Administrador', 3109.30);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (27, 'Paola', 'Cabrera', 'Supervisor', 3116.44);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (28, 'Carla', 'Mamani', 'Técnico HVAC', 4590.95);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (29, 'Monica', 'Choque', 'Auxiliar Administrativo', 3199.25);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (30, 'Diana', 'Quispe', 'Mantenimiento General', 5750.22);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (31, 'Eduardo', 'Condori', 'Conserje', 5653.67);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (32, 'Oscar', 'Huanca', 'Seguridad', 3919.91);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (33, 'Cristian', 'Luna', 'Electricista', 3771.14);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (34, 'Ivan', 'Peña', 'Plomero', 3687.56);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (35, 'Pablo', 'Reyes', 'Jardinero', 3805.61);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (36, 'Mariana', 'Molina', 'Administrador', 4355.14);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (37, 'Rocio', 'Campos', 'Supervisor', 2750.59);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (38, 'Susana', 'Rivera', 'Técnico HVAC', 2837.50);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (39, 'Gloria', 'Delgado', 'Auxiliar Administrativo', 3486.43);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (40, 'Camila', 'Cortez', 'Mantenimiento General', 3772.24);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (41, 'Jorge', 'Ramos', 'Conserje', 4191.22);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (42, 'Diego', 'Medina', 'Seguridad', 3066.46);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (43, 'Jose', 'Fuentes', 'Electricista', 3041.43);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (44, 'Sergio', 'Rios', 'Plomero', 4600.05);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (45, 'Julio', 'Escobar', 'Jardinero', 5337.21);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (46, 'Laura', 'Arce', 'Administrador', 5686.31);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (47, 'Ana', 'Sandoval', 'Supervisor', 4884.08);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (48, 'Maria', 'Lopez', 'Técnico HVAC', 3665.53);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (49, 'Veronica', 'Perez', 'Auxiliar Administrativo', 4529.34);
INSERT INTO public.empleado (id_empleado, nombre, apellido, cargo, salario) VALUES (50, 'Silvia', 'Sanchez', 'Mantenimiento General', 3874.01);


--
-- TOC entry 4974 (class 0 OID 24659)
-- Dependencies: 230
-- Data for Name: mantenimiento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (1, 58, 27, '2024-10-10', 'Reparación de tubería', 945.84);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (2, 8, 30, '2024-06-21', 'Cambio de luminarias', 145.48);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (3, 58, 21, '2024-06-25', 'Revisión eléctrica general', 860.04);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (4, 31, 14, '2024-09-17', 'Mantenimiento preventivo', 805.90);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (5, 47, 48, '2024-02-29', 'Cambio de cerradura', 678.95);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (6, 47, NULL, '2024-01-31', 'Pintado de pasillos', 742.90);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (7, 60, 35, '2024-12-21', 'Impermeabilización', 725.54);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (8, 25, 47, '2024-03-15', 'Mantenimiento de ascensor', 307.58);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (9, 44, 44, '2024-02-05', 'Revisión de cámaras de seguridad', 1008.05);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (10, 22, 7, '2024-11-04', 'Mantenimiento de jardín', 293.62);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (11, 47, NULL, '2024-08-08', 'Reparación de tubería', 558.45);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (12, 6, 10, '2024-08-15', 'Cambio de luminarias', 939.28);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (13, 49, 37, '2024-05-29', 'Revisión eléctrica general', 691.88);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (14, 52, 35, '2024-06-24', 'Mantenimiento preventivo', 330.44);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (15, 37, 46, '2024-09-14', 'Cambio de cerradura', 940.73);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (16, 54, 4, '2024-10-23', 'Pintado de pasillos', 366.11);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (17, 33, 48, '2024-11-26', 'Impermeabilización', 909.27);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (18, 33, 11, '2024-11-10', 'Mantenimiento de ascensor', 905.03);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (19, 36, 44, '2024-02-05', 'Revisión de cámaras de seguridad', 193.35);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (20, 5, NULL, '2024-12-30', 'Mantenimiento de jardín', 619.34);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (21, 3, 41, '2024-11-18', 'Reparación de tubería', 992.52);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (22, 37, 28, '2024-06-18', 'Cambio de luminarias', 1080.41);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (23, 57, 46, '2024-02-11', 'Revisión eléctrica general', 903.42);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (24, 32, 7, '2024-04-12', 'Mantenimiento preventivo', 904.93);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (25, 56, 42, '2024-09-17', 'Cambio de cerradura', 376.05);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (26, 30, 48, '2024-11-12', 'Pintado de pasillos', 857.78);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (27, 29, 30, '2024-07-16', 'Impermeabilización', 512.92);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (28, 34, 12, '2024-12-09', 'Mantenimiento de ascensor', 806.84);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (29, 53, 21, '2024-10-04', 'Revisión de cámaras de seguridad', 775.59);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (30, 11, 48, '2024-12-12', 'Mantenimiento de jardín', 928.69);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (31, 57, 31, '2024-02-06', 'Reparación de tubería', 777.97);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (32, 27, 38, '2024-11-28', 'Cambio de luminarias', 655.10);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (33, 22, 5, '2024-11-18', 'Revisión eléctrica general', 666.53);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (34, 15, 38, '2024-11-13', 'Mantenimiento preventivo', 303.83);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (35, 13, 36, '2024-12-18', 'Cambio de cerradura', 468.13);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (36, 41, 45, '2024-09-30', 'Pintado de pasillos', 909.44);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (37, 14, 4, '2024-10-04', 'Impermeabilización', 946.22);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (38, 10, 39, '2024-10-07', 'Mantenimiento de ascensor', 1060.65);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (39, 7, 5, '2024-02-07', 'Revisión de cámaras de seguridad', 552.30);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (40, 34, 16, '2024-01-21', 'Mantenimiento de jardín', 851.94);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (41, 45, 47, '2024-12-18', 'Reparación de tubería', 758.97);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (42, 52, 15, '2024-05-06', 'Cambio de luminarias', 1082.13);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (43, 36, 50, '2024-09-13', 'Revisión eléctrica general', 1015.87);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (44, 25, 6, '2024-08-23', 'Mantenimiento preventivo', 599.98);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (45, 44, 36, '2024-11-06', 'Cambio de cerradura', 1110.66);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (46, 10, 42, '2024-08-26', 'Pintado de pasillos', 908.61);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (47, 31, 31, '2024-02-18', 'Impermeabilización', 1110.51);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (48, 3, 33, '2024-05-02', 'Mantenimiento de ascensor', 286.03);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (49, 28, 8, '2024-11-30', 'Revisión de cámaras de seguridad', 1103.12);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (50, 14, 42, '2024-06-03', 'Mantenimiento de jardín', 498.50);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (51, 27, 11, '2024-06-18', 'Reparación de tubería', 320.77);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (52, 52, 27, '2024-02-20', 'Cambio de luminarias', 316.51);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (53, 20, 3, '2024-07-01', 'Revisión eléctrica general', 220.64);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (54, 2, 32, '2024-02-22', 'Mantenimiento preventivo', 644.18);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (55, 44, 34, '2024-08-26', 'Cambio de cerradura', 578.94);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (56, 30, 15, '2024-08-12', 'Pintado de pasillos', 975.06);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (57, 51, NULL, '2024-11-02', 'Impermeabilización', 379.92);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (58, 21, 39, '2024-06-13', 'Mantenimiento de ascensor', 958.91);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (59, 7, 49, '2024-07-10', 'Revisión de cámaras de seguridad', 758.91);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (60, 19, 32, '2024-07-26', 'Mantenimiento de jardín', 236.64);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (61, 46, 44, '2024-03-10', 'Reparación de tubería', 629.75);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (62, 38, 4, '2024-04-12', 'Cambio de luminarias', 604.90);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (63, 53, 6, '2024-08-01', 'Revisión eléctrica general', 512.58);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (64, 23, NULL, '2024-08-25', 'Mantenimiento preventivo', 664.82);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (65, 4, 3, '2024-10-02', 'Cambio de cerradura', 217.23);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (66, 23, 38, '2024-12-25', 'Pintado de pasillos', 927.89);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (67, 42, 32, '2024-05-10', 'Impermeabilización', 693.29);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (68, 40, 10, '2024-01-29', 'Mantenimiento de ascensor', 883.64);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (69, 43, 48, '2024-01-24', 'Revisión de cámaras de seguridad', 729.79);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (70, 51, 46, '2024-11-17', 'Mantenimiento de jardín', 855.97);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (71, 7, NULL, '2024-05-18', 'Reparación de tubería', 1021.64);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (72, 36, 16, '2024-04-12', 'Cambio de luminarias', 238.30);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (73, 26, 34, '2024-07-09', 'Revisión eléctrica general', 373.75);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (74, 4, NULL, '2024-04-11', 'Mantenimiento preventivo', 197.83);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (75, 59, 23, '2024-10-26', 'Cambio de cerradura', 657.86);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (76, 35, 30, '2024-05-26', 'Pintado de pasillos', 682.05);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (77, 20, 47, '2024-12-02', 'Impermeabilización', 264.03);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (78, 57, 35, '2024-05-18', 'Mantenimiento de ascensor', 960.49);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (79, 53, 29, '2024-07-02', 'Revisión de cámaras de seguridad', 1102.65);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (80, 53, 33, '2024-04-28', 'Mantenimiento de jardín', 997.44);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (81, 7, 26, '2024-05-16', 'Reparación de tubería', 401.24);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (82, 57, 7, '2024-07-19', 'Cambio de luminarias', 386.17);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (83, 10, 47, '2024-02-12', 'Revisión eléctrica general', 605.03);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (84, 33, 45, '2024-11-10', 'Mantenimiento preventivo', 809.58);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (85, 41, 49, '2024-11-10', 'Cambio de cerradura', 327.75);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (86, 6, NULL, '2024-01-06', 'Pintado de pasillos', 479.20);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (87, 7, 49, '2024-04-21', 'Impermeabilización', 1106.30);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (88, 47, 14, '2024-04-13', 'Mantenimiento de ascensor', 389.21);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (89, 48, 8, '2024-07-09', 'Revisión de cámaras de seguridad', 812.57);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (90, 55, 8, '2024-05-24', 'Mantenimiento de jardín', 747.19);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (91, 42, 2, '2024-05-09', 'Reparación de tubería', 552.71);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (92, 34, 40, '2024-09-06', 'Cambio de luminarias', 918.08);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (93, 9, NULL, '2024-10-22', 'Revisión eléctrica general', 764.73);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (94, 2, 20, '2024-08-13', 'Mantenimiento preventivo', 609.34);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (95, 8, 12, '2024-03-01', 'Cambio de cerradura', 437.83);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (96, 5, 11, '2024-11-12', 'Pintado de pasillos', 202.94);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (97, 22, 47, '2024-02-20', 'Impermeabilización', 384.06);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (98, 18, 14, '2024-03-22', 'Mantenimiento de ascensor', 434.40);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (99, 55, 11, '2024-06-12', 'Revisión de cámaras de seguridad', 815.85);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (100, 58, 29, '2024-06-09', 'Mantenimiento de jardín', 622.83);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (101, 39, 28, '2024-03-08', 'Reparación de tubería', 321.48);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (102, 28, 23, '2024-02-10', 'Cambio de luminarias', 908.36);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (103, 35, 20, '2024-01-25', 'Revisión eléctrica general', 1100.91);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (104, 12, 3, '2024-03-24', 'Mantenimiento preventivo', 787.14);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (105, 31, 35, '2024-07-04', 'Cambio de cerradura', 268.57);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (106, 47, 33, '2024-07-09', 'Pintado de pasillos', 780.59);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (107, 6, 33, '2024-06-11', 'Impermeabilización', 342.18);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (108, 58, 37, '2024-05-20', 'Mantenimiento de ascensor', 822.34);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (109, 21, 30, '2024-10-10', 'Revisión de cámaras de seguridad', 483.22);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (110, 19, 47, '2024-07-31', 'Mantenimiento de jardín', 1070.34);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (111, 7, 37, '2024-01-03', 'Reparación de tubería', 790.81);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (112, 26, 41, '2024-05-04', 'Cambio de luminarias', 848.20);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (113, 36, 6, '2024-07-17', 'Revisión eléctrica general', 125.51);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (114, 16, 12, '2024-05-08', 'Mantenimiento preventivo', 1084.76);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (115, 45, 39, '2024-02-23', 'Cambio de cerradura', 1071.83);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (116, 27, 37, '2024-06-18', 'Pintado de pasillos', 357.11);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (117, 23, 31, '2024-09-18', 'Impermeabilización', 884.54);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (118, 57, 41, '2024-08-07', 'Mantenimiento de ascensor', 450.97);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (119, 6, 31, '2024-08-02', 'Revisión de cámaras de seguridad', 548.84);
INSERT INTO public.mantenimiento (id_mantenimiento, id_departamento, id_empleado, fecha, descripcion, costo) VALUES (120, 37, 49, '2024-02-16', 'Mantenimiento de jardín', 255.82);


--
-- TOC entry 4970 (class 0 OID 24629)
-- Dependencies: 226
-- Data for Name: pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (1, 1, '2024-05-09', 2537.99, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (2, 2, '2023-02-28', 2776.06, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (3, 3, '2023-04-17', 2379.51, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (4, 4, '2023-05-27', 1908.82, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (5, 5, '2023-08-11', 3093.16, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (6, 6, '2024-01-01', 2588.81, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (7, 7, '2023-05-28', 2636.20, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (8, 8, '2023-07-30', 2283.45, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (9, 9, '2023-02-12', 3254.23, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (10, 10, '2023-11-04', 1568.43, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (11, 11, '2023-05-22', 1972.20, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (12, 12, '2024-03-15', 1643.99, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (13, 13, '2024-01-04', 3303.83, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (14, 14, '2023-07-28', 3291.36, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (15, 15, '2023-07-02', 3021.45, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (16, 16, '2024-04-02', 2107.36, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (17, 17, '2024-04-09', 2793.05, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (18, 18, '2024-06-02', 2332.16, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (19, 19, '2023-09-02', 2607.33, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (20, 20, '2024-01-06', 1502.43, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (21, 21, '2023-07-21', 2236.67, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (22, 22, '2024-05-11', 1648.73, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (23, 23, '2024-02-08', 2878.14, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (24, 24, '2024-05-13', 2792.57, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (25, 25, '2024-06-09', 2838.87, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (26, 26, '2023-12-17', 1709.89, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (27, 27, '2024-03-02', 3446.21, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (28, 28, '2024-02-19', 3107.14, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (29, 29, '2023-03-27', 3376.11, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (30, 30, '2023-08-02', 3297.62, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (31, 31, '2023-04-17', 2435.10, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (32, 32, '2023-12-06', 3389.50, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (33, 33, '2024-04-25', 2344.80, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (34, 34, '2023-07-21', 3361.10, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (35, 35, '2023-09-10', 3201.28, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (36, 36, '2024-01-07', 2248.99, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (37, 37, '2024-04-11', 3052.30, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (38, 38, '2023-07-15', 2974.91, 'efectivo');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (39, 39, '2023-08-24', 1965.82, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (40, 40, '2023-10-25', 2057.89, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (41, 41, '2023-12-11', 1914.79, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (42, 42, '2023-02-28', 2199.92, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (43, 43, '2023-09-28', 1832.50, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (44, 44, '2023-05-03', 2397.22, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (45, 45, '2023-02-24', 1666.31, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (46, 1, '2024-06-09', 2537.99, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (47, 2, '2023-03-29', 2776.06, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (48, 3, '2023-05-17', 2379.51, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (49, 4, '2023-06-27', 1908.82, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (50, 5, '2023-09-11', 3093.16, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (51, 6, '2024-02-01', 2588.81, 'efectivo');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (52, 7, '2023-06-28', 2636.20, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (53, 8, '2023-08-30', 2283.45, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (54, 9, '2023-03-12', 3254.23, 'efectivo');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (55, 10, '2023-12-04', 1568.43, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (56, 11, '2023-06-22', 1972.20, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (57, 12, '2024-04-15', 1643.99, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (58, 13, '2024-02-04', 3303.83, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (59, 14, '2023-08-28', 3291.36, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (60, 15, '2023-08-02', 3021.45, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (61, 16, '2024-05-02', 2107.36, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (62, 17, '2024-05-09', 2793.05, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (63, 18, '2024-07-02', 2332.16, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (64, 19, '2023-10-02', 2607.33, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (65, 20, '2024-02-06', 1502.43, 'efectivo');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (66, 21, '2023-08-21', 2236.67, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (67, 22, '2024-06-11', 1648.73, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (68, 23, '2024-03-08', 2878.14, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (69, 24, '2024-06-13', 2792.57, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (70, 25, '2024-07-09', 2838.87, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (71, 26, '2024-01-17', 1709.89, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (72, 27, '2024-04-02', 3446.21, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (73, 28, '2024-03-19', 3107.14, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (74, 29, '2023-04-27', 3376.11, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (75, 30, '2023-09-02', 3297.62, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (76, 31, '2023-05-17', 2435.10, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (77, 32, '2024-01-06', 3389.50, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (78, 33, '2024-05-25', 2344.80, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (79, 34, '2023-08-21', 3361.10, 'efectivo');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (80, 35, '2023-10-10', 3201.28, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (81, 36, '2024-02-07', 2248.99, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (82, 37, '2024-05-11', 3052.30, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (83, 38, '2023-08-15', 2974.91, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (84, 39, '2023-09-24', 1965.82, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (85, 40, '2023-11-25', 2057.89, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (86, 41, '2024-01-11', 1914.79, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (87, 42, '2023-03-30', 2199.92, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (88, 43, '2023-10-28', 1832.50, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (89, 44, '2023-06-03', 2397.22, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (90, 45, '2023-03-24', 1666.31, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (91, 1, '2024-07-09', 2537.99, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (92, 2, '2023-04-29', 2776.06, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (93, 3, '2023-06-17', 2379.51, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (94, 4, '2023-07-27', 1908.82, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (95, 5, '2023-10-11', 3093.16, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (96, 6, '2024-03-01', 2588.81, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (97, 7, '2023-07-28', 2636.20, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (98, 8, '2023-09-30', 2283.45, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (99, 9, '2023-04-12', 3254.23, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (100, 10, '2024-01-04', 1568.43, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (101, 11, '2023-07-22', 1972.20, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (102, 12, '2024-05-15', 1643.99, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (103, 13, '2024-03-04', 3303.83, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (104, 14, '2023-09-28', 3291.36, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (105, 15, '2023-09-02', 3021.45, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (106, 16, '2024-06-02', 2107.36, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (107, 17, '2024-06-09', 2793.05, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (108, 18, '2024-08-02', 2332.16, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (109, 19, '2023-11-02', 2607.33, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (110, 20, '2024-03-06', 1502.43, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (111, 21, '2023-09-21', 2236.67, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (112, 22, '2024-07-11', 1648.73, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (113, 23, '2024-04-08', 2878.14, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (114, 24, '2024-07-13', 2792.57, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (115, 25, '2024-08-09', 2838.87, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (116, 26, '2024-02-17', 1709.89, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (117, 27, '2024-05-02', 3446.21, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (118, 28, '2024-04-19', 3107.14, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (119, 29, '2023-05-27', 3376.11, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (120, 30, '2023-10-02', 3297.62, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (121, 31, '2023-06-17', 2435.10, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (122, 32, '2024-02-06', 3389.50, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (123, 33, '2024-06-25', 2344.80, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (124, 34, '2023-09-21', 3361.10, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (125, 35, '2023-11-10', 3201.28, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (126, 36, '2024-03-07', 2248.99, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (127, 37, '2024-06-11', 3052.30, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (128, 38, '2023-09-15', 2974.91, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (129, 39, '2023-10-24', 1965.82, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (130, 40, '2023-12-25', 2057.89, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (131, 41, '2024-02-11', 1914.79, 'qr');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (132, 42, '2023-04-30', 2199.92, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (133, 43, '2023-11-28', 1832.50, 'efectivo');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (134, 44, '2023-07-03', 2397.22, 'transferencia');
INSERT INTO public.pago (id_pago, id_contrato, fecha_pago, monto, metodo_pago) VALUES (135, 45, '2023-04-24', 1666.31, 'transferencia');


--
-- TOC entry 4964 (class 0 OID 24578)
-- Dependencies: 220
-- Data for Name: propietario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (1, 'Carlos', 'Lopez', '76000001', 'carlos.lopez1@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (2, 'Luis', 'Martinez', '76000002', 'luis.martinez2@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (3, 'Jorge', 'Rodriguez', '76000003', 'jorge.rodriguez3@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (4, 'Miguel', 'Perez', '76000004', 'miguel.perez4@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (5, 'Andres', 'Sanchez', '76000005', 'andres.sanchez5@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (6, 'Fernando', 'Vargas', '76000006', 'fernando.vargas6@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (7, 'Ricardo', 'Torrez', '76000007', 'ricardo.torrez7@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (8, 'Daniel', 'Gutierrez', '76000008', 'daniel.gutierrez8@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (9, 'Diego', 'Rojas', '76000009', 'diego.rojas9@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (10, 'Jose', 'Flores', '76000010', 'jose.flores10@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (11, 'Ana', 'Ramirez', '76000011', 'ana.ramirez11@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (12, 'Maria', 'Castro', '76000012', 'maria.castro12@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (13, 'Laura', 'Suarez', '76000013', 'laura.suarez13@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (14, 'Patricia', 'Morales', '76000014', 'patricia.morales14@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (15, 'Sofia', 'Ortiz', '76000015', 'sofia.ortiz15@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (16, 'Gabriela', 'Mendoza', '76000016', 'gabriela.mendoza16@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (17, 'Daniela', 'Aguilar', '76000017', 'daniela.aguilar17@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (18, 'Claudia', 'Chavez', '76000018', 'claudia.chavez18@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (19, 'Valeria', 'Alvarez', '76000019', 'valeria.alvarez19@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (20, 'Camila', 'Romero', '76000020', 'camila.romero20@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (21, 'Ruben', 'Herrera', '76000021', 'ruben.herrera21@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (22, 'Victor', 'Cardenas', '76000022', 'victor.cardenas22@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (23, 'Marco', 'Navarro', '76000023', 'marco.navarro23@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (24, 'Alberto', 'Paredes', '76000024', 'alberto.paredes24@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (25, 'Roberto', 'Salazar', '76000025', 'roberto.salazar25@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (26, 'Elena', 'Arias', '76000026', 'elena.arias26@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (27, 'Paola', 'Valdez', '76000027', 'paola.valdez27@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (28, 'Lucia', 'Quiroga', '76000028', 'lucia.quiroga28@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (29, 'Carla', 'Velasco', '76000029', 'carla.velasco29@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (30, 'Monica', 'Cabrera', '76000030', 'monica.cabrera30@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (31, 'Hector', 'Mamani', '76000031', 'hector.mamani31@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (32, 'Raul', 'Choque', '76000032', 'raul.choque32@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (33, 'Sergio', 'Quispe', '76000033', 'sergio.quispe33@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (34, 'Julio', 'Condori', '76000034', 'julio.condori34@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (35, 'Mario', 'Huanca', '76000035', 'mario.huanca35@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (36, 'Natalia', 'Luna', '76000036', 'natalia.luna36@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (37, 'Andrea', 'Peña', '76000037', 'andrea.peña37@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (38, 'Veronica', 'Reyes', '76000038', 'veronica.reyes38@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (39, 'Silvia', 'Molina', '76000039', 'silvia.molina39@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (40, 'Tatiana', 'Campos', '76000040', 'tatiana.campos40@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (41, 'Pablo', 'Rivera', '76000041', 'pablo.rivera41@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (42, 'Eduardo', 'Delgado', '76000042', 'eduardo.delgado42@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (43, 'Oscar', 'Cortez', '76000043', 'oscar.cortez43@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (44, 'Cristian', 'Ramos', '76000044', 'cristian.ramos44@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (45, 'Ivan', 'Medina', '76000045', 'ivan.medina45@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (46, 'Mariana', 'Fuentes', '76000046', 'mariana.fuentes46@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (47, 'Rocio', 'Rios', '76000047', 'rocio.rios47@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (48, 'Diana', 'Escobar', '76000048', 'diana.escobar48@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (49, 'Susana', 'Arce', '76000049', 'susana.arce49@gmail.com');
INSERT INTO public.propietario (id_propietario, nombre, apellido, telefono, email) VALUES (50, 'Gloria', 'Sandoval', '76000050', 'gloria.sandoval50@gmail.com');


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 223
-- Name: contrato_id_contrato_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contrato_id_contrato_seq', 45, true);


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 221
-- Name: departamento_id_departamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departamento_id_departamento_seq', 60, true);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 227
-- Name: empleado_id_empleado_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.empleado_id_empleado_seq', 50, true);


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 229
-- Name: mantenimiento_id_mantenimiento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mantenimiento_id_mantenimiento_seq', 120, true);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 225
-- Name: pago_id_pago_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pago_id_pago_seq', 135, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 219
-- Name: propietario_id_propietario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.propietario_id_propietario_seq', 50, true);


--
-- TOC entry 4804 (class 2606 OID 24622)
-- Name: contrato contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_pkey PRIMARY KEY (id_contrato);


--
-- TOC entry 4800 (class 2606 OID 24604)
-- Name: departamento departamento_numero_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_numero_key UNIQUE (numero);


--
-- TOC entry 4802 (class 2606 OID 24602)
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (id_departamento);


--
-- TOC entry 4808 (class 2606 OID 24657)
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (id_empleado);


--
-- TOC entry 4810 (class 2606 OID 24670)
-- Name: mantenimiento mantenimiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_pkey PRIMARY KEY (id_mantenimiento);


--
-- TOC entry 4806 (class 2606 OID 24640)
-- Name: pago pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4796 (class 2606 OID 24588)
-- Name: propietario propietario_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propietario
    ADD CONSTRAINT propietario_email_key UNIQUE (email);


--
-- TOC entry 4798 (class 2606 OID 24586)
-- Name: propietario propietario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.propietario
    ADD CONSTRAINT propietario_pkey PRIMARY KEY (id_propietario);


--
-- TOC entry 4812 (class 2606 OID 24623)
-- Name: contrato contrato_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamento(id_departamento);


--
-- TOC entry 4811 (class 2606 OID 24605)
-- Name: departamento departamento_id_propietario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_id_propietario_fkey FOREIGN KEY (id_propietario) REFERENCES public.propietario(id_propietario);


--
-- TOC entry 4814 (class 2606 OID 24671)
-- Name: mantenimiento mantenimiento_id_departamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_id_departamento_fkey FOREIGN KEY (id_departamento) REFERENCES public.departamento(id_departamento);


--
-- TOC entry 4815 (class 2606 OID 24676)
-- Name: mantenimiento mantenimiento_id_empleado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mantenimiento
    ADD CONSTRAINT mantenimiento_id_empleado_fkey FOREIGN KEY (id_empleado) REFERENCES public.empleado(id_empleado);


--
-- TOC entry 4813 (class 2606 OID 24641)
-- Name: pago pago_id_contrato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_contrato_fkey FOREIGN KEY (id_contrato) REFERENCES public.contrato(id_contrato);


-- Completed on 2026-02-18 23:29:18

--
-- PostgreSQL database dump complete
--

\unrestrict bU8WUm83TcndYgPnk61Or3lbaD8eHSGkPhSj1tbxiprBF3UwD8cfFiS3sUStYVd

