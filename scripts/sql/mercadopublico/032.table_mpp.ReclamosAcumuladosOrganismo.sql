IF OBJECT_ID('mercadopublico.mpp.ReclamosAcumuladosOrganismo', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.ReclamosAcumuladosOrganismo;
GO

CREATE TABLE mercadopublico.mpp.ReclamosAcumuladosOrganismo (
	codigoOrganismo int NOT NULL,
	fecha int NOT NULL,
	cantidadReclamos int NOT NULL
);
GO

INSERT INTO mercadopublico.mpp.ReclamosAcumuladosOrganismo
SELECT DISTINCT CodigoOrganismo, FechaPublicacion, CantidadReclamos
  FROM mercadopublico.dbo.licitaciones l
ORDER BY FechaPublicacion, CodigoOrganismo;

ALTER TABLE mercadopublico.mpp.ReclamosAcumuladosOrganismo
ADD CONSTRAINT FK_Organismo_ReclamosAcumulados FOREIGN KEY (codigoOrganismo)
REFERENCES mercadopublico.mpp.Organismo(codigoOrganismo);