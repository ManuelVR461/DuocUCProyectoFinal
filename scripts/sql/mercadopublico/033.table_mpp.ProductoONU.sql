CREATE TABLE mercadopublico.mpp.Producto (
	codigoProducto int NOT NULL,
	nombre varchar(255),
	idRubro int NOT NULL,
    CONSTRAINT producto_PK PRIMARY KEY (CodigoProducto)
);

INSERT INTO mercadopublico.mpp.Producto
SELECT DISTINCT l.CodigoProductoONU, l.NombreProductoGenerico, r3.idRubro
  FROM mercadopublico.dbo.licitaciones l
  LEFT JOIN mercadopublico.mpp.Rubro r1
         ON r1.nombre = l.rubro1
        AND r1.idRubroSuperior IS NULL
  LEFT JOIN mercadopublico.mpp.Rubro r2
         ON r2.nombre = l.rubro2
        AND r2.idRubroSuperior = r1.idRubro
  LEFT JOIN mercadopublico.mpp.Rubro r3
         ON r3.nombre = l.rubro3
        AND r3.idRubroSuperior = r2.idRubro
 WHERE l.CodigoProductoONU IS NOT NULL
 ORDER BY 1;
