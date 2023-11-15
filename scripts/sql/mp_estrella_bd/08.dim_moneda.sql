DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_moneda;

CREATE TABLE mp_estrella_db.dbo.dim_moneda (
    id_moneda          int not null,
    codigo_iso_moneda  char(3) not null,
    moneda             varchar(255),
	CONSTRAINT PK_moneda PRIMARY KEY (id_moneda)
);

INSERT INTO mp_estrella_db.dbo.dim_moneda (id_moneda, codigo_iso_moneda, moneda) VALUES (1, 'CLF', 'Unidad de Fomento');
INSERT INTO mp_estrella_db.dbo.dim_moneda (id_moneda, codigo_iso_moneda, moneda) VALUES (2, 'CLP', 'Peso Chileno');
INSERT INTO mp_estrella_db.dbo.dim_moneda (id_moneda, codigo_iso_moneda, moneda) VALUES (3, 'USD', 'Dolar');
INSERT INTO mp_estrella_db.dbo.dim_moneda (id_moneda, codigo_iso_moneda, moneda) VALUES (4, 'UTM', 'Unidad Tributaria Mensual');
INSERT INTO mp_estrella_db.dbo.dim_moneda (id_moneda, codigo_iso_moneda, moneda) VALUES (5, 'EUR', 'Euro');
INSERT INTO mp_estrella_db.dbo.dim_moneda (id_moneda, codigo_iso_moneda, moneda) VALUES (6, 'CHF', 'Franco suizo');

