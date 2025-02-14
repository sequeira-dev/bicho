-- Table: public.tipo_jogo
-- DROP TABLE IF EXISTS public.tipo_jogo;

CREATE TABLE IF NOT EXISTS public.tipo_jogo
(
    codigo integer NOT NULL DEFAULT nextval('tipo_jogo_codigo_seq'::regclass),
    nome text COLLATE pg_catalog."default" NOT NULL,
    descricao text COLLATE pg_catalog."default",
    ativo boolean,
    CONSTRAINT tipo_jogo_pkey PRIMARY KEY (codigo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_jogo
    OWNER to postgres;
	
	
--

-- Table: public.jogo
-- DROP TABLE IF EXISTS public.jogo;


CREATE TABLE IF NOT EXISTS public.jogo
(
    codigo integer NOT NULL DEFAULT nextval('jogo_codigo_seq'::regclass),
    data timestamp without time zone NOT NULL,
	tipo_jogo integer,
    descricao text COLLATE pg_catalog."default" NOT NULL,
    premio1 numeric NOT NULL,
	grupo1 numeric NOT NULL,
    premio2 numeric NOT NULL,
    grupo2 numeric NOT NULL,
    premio3 numeric NOT NULL,
    grupo3 numeric NOT NULL,
    premio4 numeric NOT NULL,
    grupo4 numeric NOT NULL,
    premio5 numeric NOT NULL,
    grupo5 numeric NOT NULL,
    CONSTRAINT jogo_pkey PRIMARY KEY (codigo),
    CONSTRAINT fk_tipo_jogo FOREIGN KEY (tipo_jogo)
        REFERENCES public.tipo_jogo (codigo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.jogo
    OWNER to postgres;