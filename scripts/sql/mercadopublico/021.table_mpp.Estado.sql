CREATE TABLE mercadopublico.mpp.Estado (
	codigoEstado int NOT NULL,
	nombre varchar(255),
    CONSTRAINT estado_PK PRIMARY KEY (codigoEstado)
);

INSERT INTO mercadopublico.mpp.Estado
SELECT DISTINCT CodigoEstado, Estado
  FROM mercadopublico.dbo.licitaciones
 WHERE CodigoEstado IS NOT NULL;
