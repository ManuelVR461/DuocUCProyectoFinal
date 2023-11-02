CREATE TABLE mercadopublico.mpp.SucursalProveedor (
	codigoSucursalProveedor int NOT NULL,
	rut varchar(255),
	nombre varchar(255),
	codigoProveedor int NOT NULL,
	CONSTRAINT proveedor_PK PRIMARY KEY (codigoSucursalProveedor)
);

WITH SucursalProveedorConNumeroFila AS (
	SELECT DISTINCT
	       CodigoSucursalProveedor,
		   RutProveedor,
		   NombreProveedor,
		   codigoProveedor,
           ROW_NUMBER() OVER (PARTITION BY CodigoSucursalProveedor ORDER BY RutProveedor, NombreProveedor) AS NumeroDeFila
	  FROM mercadopublico.dbo.licitaciones
)
INSERT INTO mercadopublico.mpp.SucursalProveedor
SELECT CodigoSucursalProveedor, RutProveedor, NombreProveedor, codigoProveedor
  FROM SucursalProveedorConNumeroFila
 WHERE NumeroDeFila = 1

-- TODO: resolver problema de cambios de nombres, cambio de rut y distintas sucursales con el mismo rut