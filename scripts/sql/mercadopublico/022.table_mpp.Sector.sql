IF OBJECT_ID('mercadopublico.mpp.Sector', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Sector;
GO

CREATE TABLE mercadopublico.mpp.Sector
(
    idSector INT IDENTITY(1,1) NOT NULL,
    nombre varchar(255),
    CONSTRAINT sector_PK PRIMARY KEY (idSector)
);
GO

INSERT INTO mercadopublico.mpp.Sector (nombre)
SELECT DISTINCT sector
  FROM mercadopublico.dbo.licitaciones
 WHERE sector IS NOT NULL;
 