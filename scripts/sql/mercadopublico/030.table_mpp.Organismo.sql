CREATE TABLE mercadopublico.mpp.Organismo (
	codigoOrganismo int NOT NULL,
	nombreOrganismo varchar(255),
	idSector int NOT NULL,
	CONSTRAINT organismo_PK PRIMARY KEY (codigoOrganismo)
);

INSERT INTO mercadopublico.mpp.Organismo
SELECT DISTINCT l.CodigoOrganismo, l.NombreOrganismo, s.idSector
  FROM mercadopublico.dbo.licitaciones l
 INNER JOIN mpp.Sector s
         ON s.nombre = l.sector
 WHERE l.CodigoOrganismo != 7106
    OR l.NombreOrganismo = 'SERVICIO DE SALUD LOS RIOS'; -- Dos nombres con el mismo id

-- Organismo
ALTER TABLE mercadopublico.mpp.Organismo
ADD CONSTRAINT FK_Sector_Acumulados FOREIGN KEY (idSector)
REFERENCES mercadopublico.mpp.Sector(idSector);