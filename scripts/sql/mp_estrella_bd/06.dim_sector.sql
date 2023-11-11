DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_sector;

CREATE TABLE mp_estrella_db.dbo.dim_sector (
	id_sector      int IDENTITY(1, 1) not null ,
	sector         varchar(255),
	CONSTRAINT PK_sector PRIMARY KEY (id_sector)
);

INSERT INTO mp_estrella_db.dbo.dim_sector (sector)
SELECT DISTINCT l.sector
  FROM mercadopublico.dbo.licitaciones l;
