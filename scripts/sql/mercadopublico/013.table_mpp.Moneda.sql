IF OBJECT_ID('mercadopublico.mpp.Moneda', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Moneda;
GO

CREATE TABLE mercadopublico.mpp.Moneda (
    codigoMoneda     int not null,
    codigoISOMoneda  char(3) not null,
    moneda           varchar(255),
    CONSTRAINT moneda_PK PRIMARY KEY (codigoMoneda)
);
GO

INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, codigoISOMoneda, moneda) VALUES (1, 'CLF',	'Unidad de Fomento');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, codigoISOMoneda, moneda) VALUES (2, 'CLP',	'Peso Chileno');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, codigoISOMoneda, moneda) VALUES (3, 'USD',	'Dolar');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, codigoISOMoneda, moneda) VALUES (4, 'UTM',	'Unidad Tributaria Mensual');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, codigoISOMoneda, moneda) VALUES (5, 'EUR',	'Euro');
INSERT INTO mercadopublico.mpp.Moneda (codigoMoneda, codigoISOMoneda, moneda) VALUES (6, 'CHF',	'Franco suizo');
