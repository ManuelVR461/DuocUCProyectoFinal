IF OBJECT_ID('mercadopublico.mpp.EstadosLicitacion', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.EstadosLicitacion;

CREATE TABLE mercadopublico.mpp.EstadosLicitacion (
	codigoLicitacion int NOT NULL,
	codigoEstado int NOT NULL,
	fecha int NOT NULL
);

INSERT INTO mercadopublico.mpp.EstadosLicitacion
SELECT Codigo, CodigoEstado, MIN(FechaPublicacion)
  FROM mercadopublico.dbo.licitaciones l
 WHERE Estado = 'Publicada' -- TODO: No está este estado
 GROUP BY Codigo, CodigoEstado

INSERT INTO mercadopublico.mpp.EstadosLicitacion
SELECT Codigo, CodigoEstado, MIN(FechaCierre)
  FROM mercadopublico.dbo.licitaciones l
 WHERE Estado = 'Cerrada'
 GROUP BY Codigo, CodigoEstado

INSERT INTO mercadopublico.mpp.EstadosLicitacion
SELECT Codigo, CodigoEstado, MIN(FechaAdjudicacion)
  FROM mercadopublico.dbo.licitaciones l
 WHERE Estado = 'Adjudicada'
 GROUP BY Codigo, CodigoEstado

INSERT INTO mercadopublico.mpp.EstadosLicitacion
SELECT Codigo, CodigoEstado, MIN(FechaAdjudicacion)
  FROM mercadopublico.dbo.licitaciones l
 WHERE Estado like 'Desierta%'
 GROUP BY Codigo, CodigoEstado

-- Agregar llave foránea en la tabla EstadosLicitacion
ALTER TABLE mercadopublico.mpp.EstadosLicitacion
ADD CONSTRAINT FK_EstadosLicitacion_Licitacion FOREIGN KEY (CodigoLicitacion)
REFERENCES mercadopublico.mpp.Licitacion(CodigoLicitacion);

ALTER TABLE mercadopublico.mpp.EstadosLicitacion
ADD CONSTRAINT FK_EstadosLicitacion_Estado FOREIGN KEY (CodigoEstado)
REFERENCES mercadopublico.mpp.Estado(CodigoEstado);