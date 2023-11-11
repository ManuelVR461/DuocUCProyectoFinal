IF OBJECT_ID('mercadopublico.mpp.Estado', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Estado;
GO

CREATE TABLE mercadopublico.mpp.Estado (
	codigoEstado int NOT NULL,
	nombre varchar(255),
    CONSTRAINT estado_PK PRIMARY KEY (codigoEstado)
);
GO

INSERT INTO mercadopublico.mpp.Estado
SELECT DISTINCT CodigoEstado, Estado
  FROM mercadopublico.dbo.licitaciones
 WHERE CodigoEstado IS NOT NULL;
