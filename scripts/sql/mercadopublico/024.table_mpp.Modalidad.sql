CREATE TABLE mercadopublico.mpp.Modalidad (
	idModalidad INT IDENTITY(1,1) NOT NULL,
	nombre varchar(255),
    CONSTRAINT modalidad_PK PRIMARY KEY (idModalidad)
);

INSERT INTO mercadopublico.mpp.Modalidad (nombre)
SELECT DISTINCT Modalidad
  FROM mercadopublico.dbo.licitaciones l
 WHERE Modalidad IS NOT NULL;
