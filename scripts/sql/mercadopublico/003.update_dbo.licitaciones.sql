-- Registros sin sector
SELECT TOP 10 l.NombreOrganismo, l.sector, s.nombre
  FROM licitaciones l
 INNER JOIN mpp.Organismo o
         ON o.codigoOrganismo = l.CodigoOrganismo
 INNER JOIN mpp.Sector s
		 ON s.idSector = o.idSector
 WHERE l.sector IS NULL
    OR l.sector = '';
GO

UPDATE mercadopublico.dbo.licitaciones
   SET CodigoSucursalProveedor = sp.codigoSucursalProveedor
  FROM mercadopublico.dbo.licitaciones l
 INNER JOIN mercadopublico.mpp.SucursalProveedor sp
         ON sp.rut = l.RutProveedor
 WHERE l.codigoSucursalProveedor = 0
 GO

 UPDATE mercadopublico.dbo.licitaciones
    SET CantidadAdjudicada = CantidadOfertada,
	    MontoLineaAdjudica = CantidadOfertada * MontoUnitarioOferta
  WHERE CantidadAdjudicada > CantidadOfertada
GO
