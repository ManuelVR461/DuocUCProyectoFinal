IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'EstadosLicitacion' 
    AND CONSTRAINT_NAME = 'FK_EstadosLicitacion_Licitacion'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.EstadosLicitacion DROP CONSTRAINT FK_EstadosLicitacion_Licitacion;
END
GO
IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Oferta' 
    AND CONSTRAINT_NAME = 'FK_Oferta_Licitacion'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Oferta DROP CONSTRAINT FK_Oferta_Licitacion;
END
GO

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Licitacion' 
    AND CONSTRAINT_NAME = 'FK_Licitacion_TipoAdquisicion'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Licitacion DROP CONSTRAINT FK_Licitacion_TipoAdquisicion;
END
GO

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Licitacion' 
    AND CONSTRAINT_NAME = 'FK_Licitacion_Moneda'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Licitacion DROP CONSTRAINT FK_Licitacion_Moneda;
END
GO

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Licitacion' 
    AND CONSTRAINT_NAME = 'FK_Licitacion_Modalidad'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Licitacion DROP CONSTRAINT FK_Licitacion_Modalidad;
END
GO

DROP TABLE IF EXISTS mercadopublico.mpp.Licitacion;
GO
	
CREATE TABLE mercadopublico.mpp.Licitacion (
	codigoLicitacion int NOT NULL,
	codigoUnidad int,
	idTipoAdquisicion INT,
	idModalidad int,
	subContratacion int,
	extensionPlazo int,
	esRenovable int,
	CONSTRAINT licitacion_PK PRIMARY KEY (codigoLicitacion)
);
GO

INSERT INTO mercadopublico.mpp.Licitacion
SELECT DISTINCT l.Codigo, l.CodigoUnidad, ta.idTipoAdquisicion, m.idModalidad, l.subContratacion, l.ExtensionPlazo, l.EsRenovable
  FROM mercadopublico.dbo.licitaciones l
  LEFT JOIN mercadopublico.mpp.TipoAdquisicion ta
         ON ta.nombre = l.TipodeAdquisicion
  LEFT JOIN mercadopublico.mpp.Modalidad m
         ON m.nombre = l.Modalidad;

-- Agregar llave foránea en la tabla Licitacion
ALTER TABLE mercadopublico.mpp.Licitacion
ADD CONSTRAINT FK_Licitacion_TipoAdquisicion FOREIGN KEY (idTipoAdquisicion)
REFERENCES mercadopublico.mpp.TipoAdquisicion(idTipoAdquisicion);

ALTER TABLE mercadopublico.mpp.Licitacion
ADD CONSTRAINT FK_Licitacion_Modalidad FOREIGN KEY (idModalidad)
REFERENCES mercadopublico.mpp.Modalidad(idModalidad);

ALTER TABLE mercadopublico.mpp.Licitacion
ADD CONSTRAINT FK_Licitacion_Unidad FOREIGN KEY (codigoUnidad)
REFERENCES mercadopublico.mpp.Unidad(codigoUnidad);