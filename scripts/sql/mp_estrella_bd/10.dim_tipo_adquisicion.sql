DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_tipo_adquisicion;

CREATE TABLE mp_estrella_db.dbo.dim_tipo_adquisicion
(
    id_tipo_adquisicion INT NOT NULL,
    nombre varchar(255),
    CONSTRAINT tipoAdquisicion_PK PRIMARY KEY (id_tipo_adquisicion)
);
GO

INSERT INTO mp_estrella_db.dbo.dim_tipo_adquisicion
SELECT *
  FROM mercadopublico.mpp.TipoAdquisicion;
