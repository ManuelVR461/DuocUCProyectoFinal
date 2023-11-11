IF OBJECT_ID('mercadopublico.mpp.Organismo', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Organismo;
GO

CREATE TABLE mercadopublico.mpp.Organismo (
	codigoOrganismo int NOT NULL,
	nombreOrganismo varchar(255),
	idSector int NOT NULL,
	CONSTRAINT organismo_PK PRIMARY KEY (codigoOrganismo)
);
GO

WITH Temporal AS (
	SELECT DISTINCT
	       l.CodigoOrganismo,
		   l.NombreOrganismo,
		   s.idSector,
		   ROW_NUMBER() OVER (PARTITION BY CodigoOrganismo ORDER BY FechaPublicacion DESC) AS NumeroDeFila
	  FROM mercadopublico.dbo.licitaciones l
	 INNER JOIN mpp.Sector s
			 ON s.nombre = l.sector
)
INSERT INTO mercadopublico.mpp.Organismo
SELECT CodigoOrganismo, NombreOrganismo, idSector
  FROM Temporal

-- Organismo
ALTER TABLE mercadopublico.mpp.Organismo
ADD CONSTRAINT FK_Sector_Acumulados FOREIGN KEY (idSector)
REFERENCES mercadopublico.mpp.Sector(idSector);