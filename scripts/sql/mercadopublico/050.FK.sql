
-- Agregar llave foránea en la tabla Comuna
ALTER TABLE mercadopublico.mpp.Comuna
ADD CONSTRAINT FK_Comuna_Region FOREIGN KEY (idRegion)
REFERENCES mercadopublico.mpp.Region(idRegion);

-- Agregar llave foránea en la tabla ConversionMoneda
ALTER TABLE mercadopublico.mpp.ConversionMoneda
ADD CONSTRAINT FK_ConversionMoneda_Moneda FOREIGN KEY (CodigoMoneda)
REFERENCES mercadopublico.mpp.Moneda(CodigoMoneda);

-- Agregar llave foránea en la tabla Unidad
ALTER TABLE mercadopublico.mpp.Unidad
ADD CONSTRAINT FK_Unidad_Organismo FOREIGN KEY (CodigoOrganismo)
REFERENCES mercadopublico.mpp.Organismo(CodigoOrganismo);

ALTER TABLE mercadopublico.mpp.Unidad
ADD CONSTRAINT FK_Unidad_Region FOREIGN KEY (idRegion)
REFERENCES mercadopublico.mpp.Region(idRegion);

ALTER TABLE mercadopublico.mpp.Unidad
ADD CONSTRAINT FK_Unidad_Comuna FOREIGN KEY (idComuna)
REFERENCES mercadopublico.mpp.Comuna(idComuna);

-- Agregar llave foránea en la tabla Rubro
ALTER TABLE mercadopublico.mpp.Rubro
ADD CONSTRAINT FK_Rubro_RubroSuperior FOREIGN KEY (idRubroSuperior)
REFERENCES mercadopublico.mpp.Rubro(idRubro);

-- Producto
ALTER TABLE mercadopublico.mpp.Producto
ADD CONSTRAINT FK_Rubro_Producto FOREIGN KEY (idRubro)
REFERENCES mercadopublico.mpp.Rubro(idRubro);




