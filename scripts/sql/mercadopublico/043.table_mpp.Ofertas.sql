IF OBJECT_ID('mercadopublico.mpp.Oferta', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Oferta;

CREATE TABLE mercadopublico.mpp.Oferta (
    codigoLicitacion            int NOT NULL,
    codigoProducto              int NOT NULL,
    unidadMedida                varchar(255) NOT NULL,
	  cantidad                    numeric(36, 6) NOT NULL,
    codigoSucursalProveedor     int NOT NULL,
    fechaEnvioOferta            int,
    cantidadOfertada            numeric(36, 6),
    codigoMoneda                int,
    montoUnitarioOferta         numeric(36, 6),
    valorTotalOfertado          numeric(36, 6),
    cantidadAdjudicada          numeric(36, 6),
    montoLineaAdjudica          numeric(36, 6),
    fechaAdjudicacion           int,
    ofertaSeleccionada          int
);

INSERT INTO mercadopublico.mpp.Oferta
SELECT
       l.Codigo,
       l.CodigoProductoONU,
       l.unidadMedida,
       l.cantidad,
       l.codigoSucursalProveedor,
       l.FechaEnvioOferta,
       l.CantidadOfertada,
       CASE COALESCE(m.codigoMoneda, 'UTM') WHEN 'CLF' THEN 1 WHEN 'CLP' THEN 2 WHEN 'USD' THEN 3 WHEN 'UTM' THEN 4 WHEN 'EUR' THEN 5 WHEN 'CHF' THEN 6 END as codigoMoneda,
       l.MontoUnitarioOferta,
       l.ValorTotalOfertado,
       l.CantidadAdjudicada,
       l.MontoLineaAdjudica,
       l.FechaAdjudicacion,
       l.Ofertaseleccionada
  FROM mercadopublico.dbo.licitaciones l
  LEFT JOIN mercadopublico.mpp.Moneda m
         ON m.nombre = l.MonedadelaOferta;

-- Agregar llave foránea en la tabla Oferta
ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Licitacion FOREIGN KEY (CodigoLicitacion, codigoProducto, unidadMedida, cantidad)
REFERENCES mercadopublico.mpp.ProductosLicitacion(CodigoLicitacion, codigoProducto, unidadMedida, cantidad);

ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Proveedor FOREIGN KEY (CodigoSucursalProveedor)
REFERENCES mercadopublico.mpp.SucursalProveedor(CodigoSucursalProveedor);

ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Producto FOREIGN KEY (CodigoProducto)
REFERENCES mercadopublico.mpp.Producto(CodigoProducto);

ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Moneda FOREIGN KEY (codigoMoneda)
REFERENCES mercadopublico.mpp.Moneda(codigoMoneda);