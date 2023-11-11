IF OBJECT_ID('mercadopublico.mpp.Modalidad', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Modalidad;
GO

CREATE TABLE mercadopublico.mpp.Modalidad (
	idModalidad INT IDENTITY(1,1) NOT NULL,
	nombre varchar(255),
    CONSTRAINT modalidad_PK PRIMARY KEY (idModalidad)
);
GO

INSERT INTO mercadopublico.mpp.Modalidad (nombre)
SELECT DISTINCT Modalidad
  FROM mercadopublico.dbo.licitaciones l
 WHERE Modalidad IS NOT NULL;
