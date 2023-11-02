IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'EstadosLicitacion' 
    AND CONSTRAINT_NAME = 'FK_EstadosLicitacion_Licitacion'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.EstadosLicitacion DROP CONSTRAINT FK_EstadosLicitacion_Licitacion;
END

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Oferta' 
    AND CONSTRAINT_NAME = 'FK_Oferta_Licitacion'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Oferta DROP CONSTRAINT FK_Oferta_Licitacion;
END

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Licitacion' 
    AND CONSTRAINT_NAME = 'FK_Licitacion_TipoAdquisicion'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Licitacion DROP CONSTRAINT FK_Licitacion_TipoAdquisicion;
END

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Licitacion' 
    AND CONSTRAINT_NAME = 'FK_Licitacion_Moneda'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Licitacion DROP CONSTRAINT FK_Licitacion_Moneda;
END

IF EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
    WHERE TABLE_NAME = 'Licitacion' 
    AND CONSTRAINT_NAME = 'FK_Licitacion_Modalidad'
)
BEGIN
    ALTER TABLE mercadopublico.mpp.Licitacion DROP CONSTRAINT FK_Licitacion_Modalidad;
END

DROP TABLE IF EXISTS mercadopublico.mpp.Licitacion;
	
CREATE TABLE mercadopublico.mpp.Licitacion (
	codigoLicitacion int NOT NULL,
	codigoExterno varchar(255) NULL,
	nombre varchar(255) NULL,
	descripcion varchar(MAX) NULL,
	idTipoAdquisicion INT,
	codigoMoneda char(3),
	montoEstimado numeric(36, 18),
	idModalidad int,
	subContratacion int,
	extensionPlazo int,
	esRenovable int,
	codigoUnidad int,
	CONSTRAINT licitacion_PK PRIMARY KEY (codigoLicitacion)
);

INSERT INTO mercadopublico.mpp.Licitacion
SELECT DISTINCT l.Codigo, l.CodigoExterno, l.Nombre, l.Descripcion, ta.idTipoAdquisicion, l.codigoMoneda, l.montoEstimado, m.idModalidad, l.subContratacion, l.ExtensionPlazo, l.EsRenovable, l.CodigoUnidad
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
ADD CONSTRAINT FK_Licitacion_Moneda FOREIGN KEY (CodigoMoneda)
REFERENCES mercadopublico.mpp.Moneda(CodigoMoneda);

ALTER TABLE mercadopublico.mpp.Licitacion
ADD CONSTRAINT FK_Licitacion_Modalidad FOREIGN KEY (idModalidad)
REFERENCES mercadopublico.mpp.Modalidad(idModalidad);

ALTER TABLE mercadopublico.mpp.Licitacion
ADD CONSTRAINT FK_Licitacion_Unidad FOREIGN KEY (codigoUnidad)
REFERENCES mercadopublico.mpp.Unidad(codigoUnidad);