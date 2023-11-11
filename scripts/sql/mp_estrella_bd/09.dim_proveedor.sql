DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_proveedor;

CREATE TABLE mp_estrella_db.dbo.dim_proveedor (
	id_proveedor int NOT NULL,
	nombre varchar(255)
	CONSTRAINT proveedor_PK PRIMARY KEY (id_proveedor)
);

WITH SucursalProveedorConNumeroFila AS (
	SELECT DISTINCT
	       codigoProveedor,
		   NombreProveedor,
           ROW_NUMBER() OVER (PARTITION BY codigoProveedor ORDER BY NombreProveedor) AS NumeroDeFila
	  FROM mercadopublico.dbo.licitaciones
)
INSERT INTO mp_estrella_db.dbo.dim_proveedor
SELECT codigoProveedor, NombreProveedor
  FROM SucursalProveedorConNumeroFila
 WHERE NumeroDeFila = 1
