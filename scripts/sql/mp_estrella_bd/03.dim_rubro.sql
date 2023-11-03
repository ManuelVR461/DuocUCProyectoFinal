DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_rubro;

CREATE TABLE mp_estrella_db.dbo.dim_rubro (
	id_rubro                   int IDENTITY(1, 1) NOT NULL,
	rubro_primer_nivel         varchar(255),
	rubro_segundo_nivel        varchar(255),
	rubro_tercer_nivel         varchar(255),
	CONSTRAINT PK_rubro PRIMARY KEY (id_rubro)
);

INSERT INTO mp_estrella_db.dbo.dim_rubro(rubro_primer_nivel, rubro_segundo_nivel, rubro_tercer_nivel)
SELECT DISTINCT Rubro1, Rubro2, Rubro3
  FROM mercadopublico.dbo.licitaciones;