IF OBJECT_ID('mercadopublico.mpp.TipoAdquisicion', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.TipoAdquisicion;
GO

CREATE TABLE mercadopublico.mpp.TipoAdquisicion
(
    idTipoAdquisicion INT IDENTITY(1,1) NOT NULL,
    nombre varchar(255),
    CONSTRAINT tipoAdquisicion_PK PRIMARY KEY (idTipoAdquisicion)
);
GO

INSERT INTO mercadopublico.mpp.TipoAdquisicion (nombre)
SELECT DISTINCT TipodeAdquisicion
  FROM mercadopublico.dbo.licitaciones;
