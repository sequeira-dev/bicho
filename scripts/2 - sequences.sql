-- SEQUENCE: public.tipo_jogo_codigo_seq
-- DROP SEQUENCE IF EXISTS public.tipo_jogo_codigo_seq;

CREATE SEQUENCE IF NOT EXISTS public.tipo_jogo_codigo_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

ALTER SEQUENCE public.tipo_jogo_codigo_seq
    OWNED BY public.tipo_jogo.codigo;

ALTER SEQUENCE public.tipo_jogo_codigo_seq
    OWNER TO postgres;
	
--	

-- SEQUENCE: public.jogo_codigo_seq
-- DROP SEQUENCE IF EXISTS public.jogo_codigo_seq;

CREATE SEQUENCE IF NOT EXISTS public.jogo_codigo_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1;

ALTER SEQUENCE public.jogo_codigo_seq
    OWNED BY public.tipo_jogo.codigo;

ALTER SEQUENCE public.jogo_codigo_seq
    OWNER TO postgres;