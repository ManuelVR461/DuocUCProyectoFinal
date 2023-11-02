CREATE TABLE mercadopublico.mpp.TipoAdquisicion
(
    idTipoAdquisicion INT IDENTITY(1,1) NOT NULL,
    nombre varchar(255),
    CONSTRAINT tipoAdquisicion_PK PRIMARY KEY (idTipoAdquisicion)
);

INSERT INTO mercadopublico.mpp.TipoAdquisicion (nombre)
SELECT DISTINCT TipodeAdquisicion
  FROM mercadopublico.dbo.licitaciones;
