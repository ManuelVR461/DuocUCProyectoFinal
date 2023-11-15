DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_unidad;

CREATE TABLE mp_estrella_db.dbo.dim_unidad (
    id_unidad        int not null,
	rut              varchar(15) not null,
	nombre           varchar(255) not null,
	organismo        varchar(255) not null,
	CONSTRAINT PK_unidad PRIMARY KEY (id_unidad)
);

WITH UnidadesConNumerosDeFila AS (
    SELECT DISTINCT
           l.CodigoUnidad,
           l.RutUnidad,
           l.NombreUnidad,
           l.NombreOrganismo,
           ROW_NUMBER() OVER (PARTITION BY l.CodigoUnidad ORDER BY l.CodigoUnidad, l.RutUnidad, l.NombreUnidad) AS NumeroDeFila
      FROM mercadopublico.dbo.licitaciones l)
INSERT INTO mp_estrella_db.dbo.dim_unidad
SELECT CodigoUnidad,
       RutUnidad,
       NombreUnidad,
       NombreOrganismo
FROM UnidadesConNumerosDeFila
WHERE NumeroDeFila = 1;

