IF OBJECT_ID('mercadopublico.mpp.SucursalProveedor', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.SucursalProveedor;
GO

CREATE TABLE mercadopublico.mpp.SucursalProveedor (
	codigoSucursalProveedor int NOT NULL,
	rut varchar(255),
	nombre varchar(255),
	codigoProveedor int NOT NULL,
	CONSTRAINT proveedor_PK PRIMARY KEY (codigoSucursalProveedor)
);
GO

WITH SucursalProveedorConNumeroFila AS (
	SELECT
	       CodigoSucursalProveedor,
		   RutProveedor,
		   NombreProveedor,
		   codigoProveedor,
           ROW_NUMBER() OVER (PARTITION BY CodigoSucursalProveedor ORDER BY CodigoProveedor DESC, RutProveedor DESC, NombreProveedor DESC) AS NumeroDeFila
	  FROM mercadopublico.dbo.licitaciones
	 WHERE CodigoSucursalProveedor > 0
)
INSERT INTO mercadopublico.mpp.SucursalProveedor
SELECT CodigoSucursalProveedor, RutProveedor, NombreProveedor, codigoProveedor
  FROM SucursalProveedorConNumeroFila
 WHERE NumeroDeFila = 1

-- TODO: resolver problema de cambios de nombres, cambio de rut y distintas sucursales con el mismo rut

WITH Temporal AS (
	SELECT NumeroDeFila + (SELECT max(codigoSucursalProveedor)
							 FROM mercadopublico.mpp.SucursalProveedor) as codigoSucursalProveedor,
		   RutProveedor,
		   NombreProveedor,
		   codigoProveedor,
		   ROW_NUMBER() OVER (PARTITION BY RutProveedor ORDER BY CodigoProveedor DESC, NombreProveedor DESC) AS NumeroDeFila
	FROM (      
		SELECT
			   RutProveedor,
			   NombreProveedor,
			   codigoProveedor,
			   ROW_NUMBER() OVER (PARTITION BY CodigoSucursalProveedor ORDER BY CodigoProveedor DESC, RutProveedor DESC, NombreProveedor DESC) AS NumeroDeFila
		  FROM mercadopublico.dbo.licitaciones
		 WHERE CodigoSucursalProveedor = 0
		   AND RutProveedor NOT IN (SELECT rut FROM mercadopublico.mpp.SucursalProveedor)
		   ) t
)
INSERT INTO mercadopublico.mpp.SucursalProveedor
SELECT codigoSucursalProveedor, RutProveedor, NombreProveedor, codigoProveedor
  FROM Temporal
 WHERE NumeroDeFila = 1