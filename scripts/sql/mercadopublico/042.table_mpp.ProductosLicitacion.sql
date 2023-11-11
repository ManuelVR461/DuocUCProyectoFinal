IF OBJECT_ID('mercadopublico.mpp.ProductosLicitacion', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.ProductosLicitacion;
GO

CREATE TABLE mercadopublico.mpp.ProductosLicitacion (
    codigoLicitacion            int NOT NULL,
    codigoProducto              int NOT NULL,
    unidadMedida                varchar(255) NOT NULL,
	cantidad                    numeric(36, 6) NOT NULL,
    codigoMoneda                int NOT NULL,
    montoEstimado               numeric(36, 6)
	CONSTRAINT productosLicitacion_PK PRIMARY KEY (codigoLicitacion, codigoProducto, unidadMedida, cantidad)
);
GO

INSERT INTO mercadopublico.mpp.ProductosLicitacion (codigoLicitacion, codigoProducto, unidadMedida, cantidad, codigoMoneda, montoEstimado)
SELECT DISTINCT l.Codigo,
       l.CodigoProductoONU,
       l.UnidadMedida,
       l.Cantidad,
       CASE l.CodigoMoneda WHEN 'CLF' THEN 1 WHEN 'CLP' THEN 2 WHEN 'USD' THEN 3 WHEN 'UTM' THEN 4 WHEN 'EUR' THEN 5 WHEN 'CHF' THEN 6 END as codigoMoneda,
       l.MontoEstimado
  FROM mercadopublico.dbo.licitaciones l;
GO

-- Agregar llave foránea en la tabla ProductosLicitacion
ALTER TABLE mercadopublico.mpp.ProductosLicitacion
ADD CONSTRAINT FK_ProductosLicitacion_Licitacion FOREIGN KEY (CodigoLicitacion)
REFERENCES mercadopublico.mpp.Licitacion(CodigoLicitacion);

ALTER TABLE mercadopublico.mpp.ProductosLicitacion
ADD CONSTRAINT FK_ProductosLicitacion_Producto FOREIGN KEY (CodigoProducto)
REFERENCES mercadopublico.mpp.Producto(CodigoProducto);

ALTER TABLE mercadopublico.mpp.ProductosLicitacion
ADD CONSTRAINT FK_ProductosLicitacion_Moneda FOREIGN KEY (CodigoMoneda)
REFERENCES mercadopublico.mpp.Moneda(CodigoMoneda);