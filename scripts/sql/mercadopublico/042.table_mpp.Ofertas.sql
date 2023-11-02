IF OBJECT_ID('mercadopublico.mpp.Oferta', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Oferta;

CREATE TABLE mercadopublico.mpp.Oferta (
    codigoLicitacion int NOT NULL,
    codigoProducto int NOT NULL,
    codigoSucursalProveedor int NOT NULL,
    fechaEnvioOferta int,
    cantidadOfertada bigint,
    codigoMoneda CHAR(3),
    montoUnitarioOferta bigint,
    valorTotalOfertado bigint,
    cantidadAdjudicada bigint,
    montoLineaAdjudica bigint,
    fechaAdjudicacion int,
    ofertaSeleccionada int
);

INSERT INTO mercadopublico.mpp.Oferta
SELECT l.Codigo, l.CodigoProductoONU, l.codigoSucursalProveedor, l.FechaEnvioOferta, l.CantidadOfertada, COALESCE(m.codigoMoneda, 'UTM'), l.MontoUnitarioOferta, l.ValorTotalOfertado, l.CantidadAdjudicada, l.MontoLineaAdjudica, l.FechaAdjudicacion, l.Ofertaseleccionada
  FROM mercadopublico.dbo.licitaciones l
  LEFT JOIN mercadopublico.mpp.Moneda m
         ON m.nombre = l.MonedadelaOferta;

-- Agregar llave foránea en la tabla Oferta
ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Licitacion FOREIGN KEY (CodigoLicitacion)
REFERENCES mercadopublico.mpp.Licitacion(CodigoLicitacion);

ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Proveedor FOREIGN KEY (CodigoSucursalProveedor)
REFERENCES mercadopublico.mpp.SucursalProveedor(CodigoSucursalProveedor);

ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Producto FOREIGN KEY (CodigoProducto)
REFERENCES mercadopublico.mpp.Producto(CodigoProducto);

ALTER TABLE mercadopublico.mpp.Oferta
ADD CONSTRAINT FK_Oferta_Moneda FOREIGN KEY (codigoMoneda)
REFERENCES mercadopublico.mpp.Moneda(codigoMoneda);