IF OBJECT_ID('mercadopublico.mpp.Region', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Region;
	
CREATE TABLE mercadopublico.mpp.Region (
	idRegion int NOT NULL,
	nombre varchar(255),
	capital varchar(255),
	zona varchar(255),
	CONSTRAINT region_PK PRIMARY KEY (idRegion)
);

INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (1,  'Región de Tarapacá',                               'Iquique',           'Norte Grande');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (2,  'Región de Antofagasta',                            'Antofagasta',       'Norte Grande');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (3,  'Región de Atacama',                                'Copiapó',           'Norte Grande');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (4,  'Región de Coquimbo',                               'La Serena',         '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (5,  'Región de Valparaíso',                             'Valparaíso',        '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (6,  'Región del Libertador General Bernardo O’Higgins', 'Rancagua',          '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (7,  'Región del Maule',                                 'Talca',             '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (8,  'Región del Bio-bío',                               'Concepción',        '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (9,  'Región de La Araucanía',                           'Temuco',            '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (10, 'Región de Los Lagos',                              'Puerto Montt',      '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (11, 'Región Aysén del General Carlos Ibáñez del Campo', 'Coyhaique',         '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (12, 'Región de Magallanes y Antártica Chilena',         'Punta Arenas',      '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (13, 'Región Metropolitana de Santiago',                 'Santiago de Chile', '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (14, 'Región de Los Ríos',                               'Valdivia',          '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (15, 'Región de Arica y Parinacota',                     'Arica',             'Norte Grande');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (16, 'Región de Ñuble',                                  'Chillán',           '');
INSERT INTO mpp.Region (idRegion, nombre, capital) VALUES (0,  'Extranjero',                                       '',                  '');

