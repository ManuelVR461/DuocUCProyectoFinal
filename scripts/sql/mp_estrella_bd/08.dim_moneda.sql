DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_moneda;

CREATE TABLE mp_estrella_db.dbo.dim_moneda (
	codigo_moneda   CHAR(3) NOT NULL,
	moneda          VARCHAR(50) NOT NULL,
	CONSTRAINT PK_moneda PRIMARY KEY (codigo_moneda)
);

INSERT INTO mp_estrella_db.dbo.dim_moneda (codigo_moneda, moneda) VALUES ('CLF', 'Unidad de Fomento');
INSERT INTO mp_estrella_db.dbo.dim_moneda (codigo_moneda, moneda) VALUES ('CLP', 'Peso Chileno');
INSERT INTO mp_estrella_db.dbo.dim_moneda (codigo_moneda, moneda) VALUES ('USD', 'Dolar');
INSERT INTO mp_estrella_db.dbo.dim_moneda (codigo_moneda, moneda) VALUES ('UTM', 'Unidad Tributaria Mensual');
INSERT INTO mp_estrella_db.dbo.dim_moneda (codigo_moneda, moneda) VALUES ('EUR', 'Euro');
