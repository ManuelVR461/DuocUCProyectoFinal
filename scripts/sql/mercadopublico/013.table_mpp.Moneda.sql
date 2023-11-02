CREATE TABLE mercadopublico.mpp.Moneda (
    codigoMoneda char(3),
    nombre  varchar(255),
    CONSTRAINT moneda_PK PRIMARY KEY (codigoMoneda)
);

INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, Nombre) VALUES ('CLF',	'Unidad de Fomento');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, Nombre) VALUES ('CLP',	'Peso Chileno');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, Nombre) VALUES ('USD',	'Dolar');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, Nombre) VALUES ('UTM',	'Unidad Tributaria Mensual');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, Nombre) VALUES ('EUR',	'Euro');
