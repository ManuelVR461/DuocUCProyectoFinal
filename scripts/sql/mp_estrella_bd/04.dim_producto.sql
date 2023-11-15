DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_producto;

CREATE TABLE mp_estrella_db.dbo.dim_producto (
	id_producto      int not null,
	producto         varchar(255),
	CONSTRAINT PK_producto PRIMARY KEY (id_producto)
);

INSERT INTO mp_estrella_db.dbo.dim_producto
SELECT DISTINCT l.CodigoProductoONU, l.NombreProductoGenerico
  FROM mercadopublico.dbo.licitaciones l
 INNER JOIN mp_estrella_db.dbo.dim_rubro r
         ON r.rubro_primer_nivel = l.rubro1
		AND r.rubro_segundo_nivel = l.rubro2
		AND r.rubro_tercer_nivel = l.rubro3;
