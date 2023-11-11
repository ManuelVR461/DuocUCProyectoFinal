IF OBJECT_ID('mercadopublico.mpp.Unidad', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Unidad;
GO
CREATE TABLE mercadopublico.mpp.Unidad (
	CodigoUnidad int NOT NULL,
	RutUnidad varchar(255) NULL,
	NombreUnidad varchar(255) NULL,
	CodigoOrganismo int,
    -- Incluyo comuna y región debido a que aparentemente hay inconcistencias, además hay comunas que cambiaron de región cuando se crearon las regiones nuevas
    idRegion int,
    idComuna int,
	CONSTRAINT unidad_PK PRIMARY KEY (CodigoUnidad)
);
GO

WITH UnidadesConNumerosDeFila AS (
	SELECT DISTINCT
		   CodigoUnidad,
		   RutUnidad,
		   NombreUnidad,
		   CodigoOrganismo,
		   CASE
				WHEN RegionUnidad like '%Tarapaca%' THEN 1
				WHEN RegionUnidad like '%Tarapacá%' THEN 1
				WHEN RegionUnidad like '%Antofagasta%' THEN 2
				WHEN RegionUnidad like '%Atacama%' THEN 3
				WHEN RegionUnidad like '%Coquimbo%' THEN 4
				WHEN RegionUnidad like '%Valparaíso%' THEN 5
				WHEN RegionUnidad like '%Valparaiso%' THEN 5
				WHEN RegionUnidad like '%Higgins%' THEN 6
				WHEN RegionUnidad like '%Maule%' THEN 7
				WHEN RegionUnidad like '%Bio%' THEN 8
				WHEN RegionUnidad like '%Araucan%' THEN 9
				WHEN RegionUnidad like '%Lagos%' THEN 10
				WHEN RegionUnidad like '%Aysén%' THEN 11
				WHEN RegionUnidad like '%Aysen%' THEN 11
				WHEN RegionUnidad like '%Magallanes%' THEN 12
				WHEN RegionUnidad like '%Metropolitana%' THEN 13
				WHEN RegionUnidad like '%Ríos%' THEN 14
				WHEN RegionUnidad like '%Rios%' THEN 14
				WHEN RegionUnidad like '%Arica%' THEN 15
				WHEN RegionUnidad like '%Ñuble%' THEN 16
				WHEN RegionUnidad like '%Nuble%' THEN 16
				WHEN RegionUnidad like '%Extranjero%' THEN 0
				ELSE -1
		   END as idRegion,
		   CASE ComunaUnidad
				WHEN 'Iquique' THEN 1101 WHEN 'Alto Hospicio' THEN 1107 WHEN 'Pozo Almonte' THEN 1401 WHEN 'Camiña' THEN 1402 WHEN 'Camina' THEN 1402 WHEN 'Colchane' THEN 1403 WHEN 'Huara' THEN 1404 WHEN 'Pica' THEN 1405
				WHEN 'Antofagasta' THEN 2101 WHEN 'Mejillones' THEN 2102 WHEN 'Sierra Gorda' THEN 2103 WHEN 'Taltal' THEN 2104 WHEN 'Calama' THEN 2201 WHEN 'Ollagüe' THEN 2202 WHEN 'Ollague' THEN 2202 WHEN 'San Pedro de Atacama' THEN 2203 WHEN 'Tocopilla' THEN 2301 WHEN 'María Elena' THEN 2302 WHEN 'Maria Elena' THEN 2302
				WHEN 'Copiapó' THEN 3101 WHEN 'Copiapo' THEN 3101 WHEN 'Caldera' THEN 3102 WHEN 'Tierra Amarilla' THEN 3103 WHEN 'Chañaral' THEN 3201 WHEN 'Chanaral' THEN 3201 WHEN 'Diego de Almagro' THEN 3202 WHEN 'Vallenar' THEN 3301 WHEN 'Alto del Carmen' THEN 3302 WHEN 'Freirina' THEN 3303 WHEN 'Huasco' THEN 3304
				WHEN 'La Serena' THEN 4101 WHEN 'Coquimbo' THEN 4102 WHEN 'Andacollo' THEN 4103 WHEN 'La Higuera' THEN 4104 WHEN 'Paihuano' THEN 4105 WHEN 'Vicuña' THEN 4106 WHEN 'Vicuna' THEN 4106 WHEN 'Illapel' THEN 4201 WHEN 'Canela' THEN 4202 WHEN 'Los Vilos' THEN 4203 WHEN 'Salamanca' THEN 4204 WHEN 'Ovalle' THEN 4301 WHEN 'Combarbalá' THEN 4302 WHEN 'Combarbala' THEN 4302 WHEN 'Monte Patria' THEN 4303 WHEN 'Punitaqui' THEN 4304 WHEN 'Río Hurtado' THEN 4305 WHEN 'Rio Hurtado' THEN 4305
				WHEN 'Valparaíso' THEN 5101 WHEN 'Valparaiso' THEN 5101 WHEN 'Casablanca' THEN 5102 WHEN 'Concón' THEN 5103 WHEN 'Concon' THEN 5103 WHEN 'Juan Fernández' THEN 5104 WHEN 'Juan Fernandez' THEN 5104 WHEN 'Puchuncaví' THEN 5105 WHEN 'Puchuncavi' THEN 5105 WHEN 'Quintero' THEN 5107 WHEN 'Viña del Mar' THEN 5109 WHEN 'Vina del Mar' THEN 5109 WHEN 'Isla de Pascua' THEN 5201 WHEN 'Los Andes' THEN 5301 WHEN 'Calle Larga' THEN 5302 WHEN 'Rinconada' THEN 5303 WHEN 'San Esteban' THEN 5304 WHEN 'La Ligua' THEN 5401 WHEN 'Cabildo' THEN 5402 WHEN 'Papudo' THEN 5403 WHEN 'Petorca' THEN 5404 WHEN 'Zapallar' THEN 5405 WHEN 'Quillota' THEN 5501 WHEN 'La Calera' THEN 5502 WHEN 'Hijuelas' THEN 5503 WHEN 'La Cruz' THEN 5504 WHEN 'Nogales' THEN 5506 WHEN 'San Antonio' THEN 5601 WHEN 'Algarrobo' THEN 5602 WHEN 'Cartagena' THEN 5603 WHEN 'El Quisco' THEN 5604 WHEN 'El Tabo' THEN 5605 WHEN 'Santo Domingo' THEN 5606 WHEN 'San Felipe' THEN 5701 WHEN 'Catemu' THEN 5702 WHEN 'Llay-Llay' THEN 5703 WHEN 'Panquehue' THEN 5704 WHEN 'Putaendo' THEN 5705 WHEN 'Santa María' THEN 5706 WHEN 'Santa Maria' THEN 5706 WHEN 'Quilpué' THEN 5801 WHEN 'Quilpue' THEN 5801 WHEN 'Limache' THEN 5802 WHEN 'Olmué' THEN 5803 WHEN 'Olmue' THEN 5803 WHEN 'Villa Alemana' THEN 5804
				WHEN 'Rancagua' THEN 6101 WHEN 'Codegua' THEN 6102 WHEN 'Coinco' THEN 6103 WHEN 'Coltauco' THEN 6104 WHEN 'Doñihue' THEN 6105 WHEN 'Donihue' THEN 6105 WHEN 'Graneros' THEN 6106 WHEN 'Las Cabras' THEN 6107 WHEN 'Machalí' THEN 6108 WHEN 'Machali' THEN 6108 WHEN 'Malloa' THEN 6109 WHEN 'Mostazal' THEN 6110 WHEN 'Olivar' THEN 6111 WHEN 'Peumo' THEN 6112 WHEN 'Pichidegua' THEN 6113 WHEN 'Quinta de Tilcoco' THEN 6114 WHEN 'Rengo' THEN 6115 WHEN 'Requínoa' THEN 6116 WHEN 'Requinoa' THEN 6116 WHEN 'San Vicente' THEN 6117 WHEN 'San Vicente de Tagua Tagua' THEN 6117 WHEN 'Pichilemu' THEN 6201 WHEN 'La Estrella' THEN 6202 WHEN 'Litueche' THEN 6203 WHEN 'Marchihue' THEN 6204 WHEN 'Marchigue' THEN 6204 WHEN 'Navidad' THEN 6205 WHEN 'Paredones' THEN 6206 WHEN 'San Fernando' THEN 6301 WHEN 'Chépica' THEN 6302 WHEN 'Chepica' THEN 6302 WHEN 'Chimbarongo' THEN 6303 WHEN 'Lolol' THEN 6304 WHEN 'Nancagua' THEN 6305 WHEN 'Palmilla' THEN 6306 WHEN 'Peralillo' THEN 6307 WHEN 'Placilla' THEN 6308 WHEN 'Pumanque' THEN 6309 WHEN 'Santa Cruz' THEN 6310
				WHEN 'Talca' THEN 7101 WHEN 'Constitución' THEN 7102 WHEN 'Constitucion' THEN 7102 WHEN 'Curepto' THEN 7103 WHEN 'Empedrado' THEN 7104 WHEN 'Maule' THEN 7105 WHEN 'Pelarco' THEN 7106 WHEN 'Pencahue' THEN 7107 WHEN 'Río Claro' THEN 7108 WHEN 'Rio Claro' THEN 7108 WHEN 'San Clemente' THEN 7109 WHEN 'San Rafael' THEN 7110 WHEN 'Cauquenes' THEN 7201 WHEN 'Chanco' THEN 7202 WHEN 'Pelluhue' THEN 7203 WHEN 'Curicó' THEN 7301 WHEN 'Curico' THEN 7301 WHEN 'Hualañé' THEN 7302 WHEN 'Hualane' THEN 7302 WHEN 'Licantén' THEN 7303 WHEN 'Licanten' THEN 7303 WHEN 'Molina' THEN 7304 WHEN 'Rauco' THEN 7305 WHEN 'Romeral' THEN 7306 WHEN 'Sagrada Familia' THEN 7307 WHEN 'Teno' THEN 7308 WHEN 'Vichuquén' THEN 7309 WHEN 'Vichuquen' THEN 7309 WHEN 'Linares' THEN 7401 WHEN 'Colbún' THEN 7402 WHEN 'Colbun' THEN 7402 WHEN 'Longaví' THEN 7403 WHEN 'Longavi' THEN 7403 WHEN 'Parral' THEN 7404 WHEN 'Retiro' THEN 7405 WHEN 'San Javier' THEN 7406 WHEN 'Villa Alegre' THEN 7407 WHEN 'Yerbas Buenas' THEN 7408
				WHEN 'Concepción' THEN 8101 WHEN 'Concepcion' THEN 8101 WHEN 'Coronel' THEN 8102 WHEN 'Chiguayante' THEN 8103 WHEN 'Florida' THEN 8104 WHEN 'Hualqui' THEN 8105 WHEN 'Lota' THEN 8106 WHEN 'Penco' THEN 8107 WHEN 'San Pedro de La Paz' THEN 8108 WHEN 'Santa Juana' THEN 8109 WHEN 'Talcahuano' THEN 8110 WHEN 'Tomé' THEN 8111 WHEN 'Tome' THEN 8111 WHEN 'Hualpén' THEN 8112 WHEN 'Hualpen' THEN 8112 WHEN 'Lebu' THEN 8201 WHEN 'Arauco' THEN 8202 WHEN 'Cañete' THEN 8203 WHEN 'Canete' THEN 8203 WHEN 'Contulmo' THEN 8204 WHEN 'Curanilahue' THEN 8205 WHEN 'Los Álamos' THEN 8206 WHEN 'Los Alamos' THEN 8206 WHEN 'Tirúa' THEN 8207 WHEN 'Tirua' THEN 8207 WHEN 'Los Ángeles' THEN 8301 WHEN 'Los Angeles' THEN 8301 WHEN 'Antuco' THEN 8302 WHEN 'Cabrero' THEN 8303 WHEN 'Laja' THEN 8304 WHEN 'Mulchén' THEN 8305 WHEN 'Mulchen' THEN 8305 WHEN 'Nacimiento' THEN 8306 WHEN 'Negrete' THEN 8307 WHEN 'Quilaco' THEN 8308 WHEN 'Quilleco' THEN 8309 WHEN 'San Rosendo' THEN 8310 WHEN 'Santa Bárbara' THEN 8311 WHEN 'Santa Barbara' THEN 8311 WHEN 'Tucapel' THEN 8312 WHEN 'Yumbel' THEN 8313 WHEN 'Alto Biobío' THEN 8314 WHEN 'Alto Biobio' THEN 8314 WHEN 'Alto Bio Bio' THEN 8314 WHEN 'Temuco'
				THEN 9101 WHEN 'Carahue' THEN 9102 WHEN 'Cunco' THEN 9103 WHEN 'Curarrehue' THEN 9104 WHEN 'Freire' THEN 9105 WHEN 'Galvarino' THEN 9106 WHEN 'Gorbea' THEN 9107 WHEN 'Lautaro' THEN 9108 WHEN 'Loncoche' THEN 9109 WHEN 'Melipeuco' THEN 9110 WHEN 'Nueva Imperial' THEN 9111 WHEN 'Padre Las Casas' THEN 9112 WHEN 'Perquenco' THEN 9113 WHEN 'Pitrufquén' THEN 9114 WHEN 'Pitrufquen' THEN 9114 WHEN 'Pucón' THEN 9115 WHEN 'Pucon' THEN 9115 WHEN 'Saavedra' THEN 9116 WHEN 'Puerto Saavedra' THEN 9116 WHEN 'Teodoro Schmidt' THEN 9117 WHEN 'Toltén' THEN 9118 WHEN 'Tolten' THEN 9118 WHEN 'Vilcún' THEN 9119 WHEN 'Vilcun' THEN 9119 WHEN 'Villarrica' THEN 9120 WHEN 'Cholchol' THEN 9121 WHEN 'Chol chol' THEN 9121 WHEN 'Angol' THEN 9201 WHEN 'Collipulli' THEN 9202 WHEN 'Curacautín' THEN 9203 WHEN 'Curacautin' THEN 9203 WHEN 'Ercilla' THEN 9204 WHEN 'Lonquimay' THEN 9205 WHEN 'Los Sauces' THEN 9206 WHEN 'Lumaco' THEN 9207 WHEN 'Purén' THEN 9208 WHEN 'Puren' THEN 9208 WHEN 'Renaico' THEN 9209 WHEN 'Traiguén' THEN 9210 WHEN 'Traiguen' THEN 9210 WHEN 'Victoria' THEN 9211
				WHEN 'Puerto Montt' THEN 10101 WHEN 'Calbuco' THEN 10102 WHEN 'Cochamó' THEN 10103 WHEN 'Cochamo' THEN 10103 WHEN 'Fresia' THEN 10104 WHEN 'Frutillar' THEN 10105 WHEN 'Los Muermos' THEN 10106 WHEN 'Llanquihue' THEN 10107 WHEN 'Maullín' THEN 10108 WHEN 'Maullin' THEN 10108 WHEN 'Puerto Varas' THEN 10109 WHEN 'Castro' THEN 10201 WHEN 'Ancud' THEN 10202 WHEN 'Chonchi' THEN 10203 WHEN 'Curaco de Vélez' THEN 10204 WHEN 'Curaco de Velez' THEN 10204 WHEN 'Dalcahue' THEN 10205 WHEN 'Puqueldón' THEN 10206 WHEN 'Puqueldon' THEN 10206 WHEN 'Queilén' THEN 10207 WHEN 'Queilen' THEN 10207 WHEN 'Quellón' THEN 10208 WHEN 'Quellon' THEN 10208 WHEN 'Quemchi' THEN 10209 WHEN 'Quinchao' THEN 10210 WHEN 'Osorno' THEN 10301 WHEN 'Puerto Octay' THEN 10302 WHEN 'Purranque' THEN 10303 WHEN 'Puyehue' THEN 10304 WHEN 'Río Negro' THEN 10305 WHEN 'Rio Negro' THEN 10305 WHEN 'San Juan de la Costa' THEN 10306 WHEN 'San Pablo' THEN 10307 WHEN 'Chaitén' THEN 10401 WHEN 'Chaiten' THEN 10401 WHEN 'Futaleufú' THEN 10402 WHEN 'Futaleufu' THEN 10402 WHEN 'Hualaihué' THEN 10403 WHEN 'Hualaihue' THEN 10403 WHEN 'Palena' THEN 10404
				WHEN 'Coyhaique' THEN 11101 WHEN 'Lago Verde' THEN 11102 WHEN 'Aysén' THEN 11201 WHEN 'Aysen' THEN 11201 WHEN 'Cisnes' THEN 11202 WHEN 'Guaitecas' THEN 11203 WHEN 'Las Guaitecas' THEN 11203 WHEN 'Cochrane' THEN 11301 WHEN 'O''Higgins' THEN 11302 WHEN 'O Higgins' THEN 11302 WHEN 'OHiggins' THEN 11302 WHEN 'Tortel' THEN 11303 WHEN 'Chile Chico' THEN 11401 WHEN 'Río Ibáñez' THEN 11402 WHEN 'Rio Ibanez' THEN 11402
				WHEN 'Punta Arenas' THEN 12101 WHEN 'Laguna Blanca' THEN 12102 WHEN 'Río Verde' THEN 12103 WHEN 'Rio Verde' THEN 12103 WHEN 'San Gregorio' THEN 12104 WHEN 'Cabo de Hornos' THEN 12201 WHEN 'Antártica' THEN 12202 WHEN 'Antartica' THEN 12202 WHEN 'Porvenir' THEN 12301 WHEN 'Primavera' THEN 12302 WHEN 'Timaukel' THEN 12303 WHEN 'Natales' THEN 12401 WHEN 'Puerto Natales' THEN 12401 WHEN 'Torres del Paine' THEN 12402 WHEN 'Torres del Payne' THEN 12402
				WHEN 'Santiago' THEN 13101 WHEN 'Santiago Sur' THEN 13101 WHEN 'Santiago Oeste' THEN 13101 WHEN 'Santiago Centro' THEN 13101 WHEN 'Cerrillos' THEN 13102 WHEN 'Cerro Navia' THEN 13103 WHEN 'Conchalí' THEN 13104 WHEN 'Conchali' THEN 13104 WHEN 'El Bosque' THEN 13105 WHEN 'Estación Central' THEN 13106 WHEN 'Estacion Central' THEN 13106 WHEN 'Huechuraba' THEN 13107 WHEN 'Independencia' THEN 13108 WHEN 'La Cisterna' THEN 13109 WHEN 'La Florida' THEN 13110 WHEN 'La Granja' THEN 13111 WHEN 'La Pintana' THEN 13112 WHEN 'La Reina' THEN 13113 WHEN 'Las Condes' THEN 13114 WHEN 'Lo Barnechea' THEN 13115 WHEN 'Lo Espejo' THEN 13116 WHEN 'Lo Prado' THEN 13117 WHEN 'Macul' THEN 13118 WHEN 'Maipú' THEN 13119 WHEN 'Maipu' THEN 13119 WHEN 'Ñuñoa' THEN 13120 WHEN 'Nunoa' THEN 13120 WHEN 'Pedro Aguirre Cerda' THEN 13121 WHEN 'Peñalolén' THEN 13122 WHEN 'Penalolen' THEN 13122 WHEN 'Providencia' THEN 13123 WHEN 'Pudahuel' THEN 13124 WHEN 'Quilicura' THEN 13125 WHEN 'Quinta Normal' THEN 13126 WHEN 'Recoleta' THEN 13127 WHEN 'Renca' THEN 13128 WHEN 'San Joaquín' THEN 13129 WHEN 'San Joaquin' THEN 13129 WHEN 'San Miguel' THEN 13130 WHEN 'San Ramón' THEN 13131 WHEN 'San Ramon' THEN 13131 WHEN 'Vitacura' THEN 13132 WHEN 'Puente Alto' THEN 13201 WHEN 'Pirque' THEN 13202 WHEN 'San José de Maipo' THEN 13203 WHEN 'San Jose de Maipo' THEN 13203 WHEN 'Colina' THEN 13301 WHEN 'Lampa' THEN 13302 WHEN 'Til Til' THEN 13303 WHEN 'San Bernardo' THEN 13401 WHEN 'Buin' THEN 13402 WHEN 'Calera de Tango' THEN 13403 WHEN 'Paine' THEN 13404 WHEN 'Melipilla' THEN 13501 WHEN 'Alhué' THEN 13502 WHEN 'Alhue' THEN 13502 WHEN 'Curacaví' THEN 13503 WHEN 'Curacavi' THEN 13503 WHEN 'María Pinto' THEN 13504 WHEN 'Maria Pinto' THEN 13504 WHEN 'San Pedro' THEN 13505 WHEN 'Talagante' THEN 13601 WHEN 'El Monte' THEN 13602 WHEN 'Isla de Maipo' THEN 13603 WHEN 'Padre Hurtado' THEN 13604 WHEN 'Peñaflor' THEN 13605 WHEN 'Penaflor' THEN 13605
				WHEN 'Valdivia' THEN 14101 WHEN 'Corral' THEN 14102 WHEN 'Lanco' THEN 14103 WHEN 'Los Lagos' THEN 14104 WHEN 'Máfil' THEN 14105 WHEN 'Mafil' THEN 14105 WHEN 'Mariquina' THEN 14106 WHEN 'Paillaco' THEN 14107 WHEN 'Panguipulli' THEN 14108 WHEN 'La Unión' THEN 14201 WHEN 'La Union' THEN 14201 WHEN 'Futrono' THEN 14202 WHEN 'Lago Ranco' THEN 14203 WHEN 'Río Bueno' THEN 14204 WHEN 'Rio Bueno' THEN 14204
				WHEN 'Arica' THEN 15101 WHEN 'Camarones' THEN 15102 WHEN 'Putre' THEN 15201 WHEN 'General Lagos' THEN 15202
				WHEN 'Chillán' THEN 16101 WHEN 'Chillan' THEN 16101 WHEN 'Bulnes' THEN 16102 WHEN 'Chillán Viejo' THEN 16103 WHEN 'Chillan Viejo' THEN 16103 WHEN 'El Carmen' THEN 16104 WHEN 'Pemuco' THEN 16105 WHEN 'Pinto' THEN 16106 WHEN 'Quillón' THEN 16107 WHEN 'Quillon' THEN 16107 WHEN 'San Ignacio' THEN 16108 WHEN 'Yungay' THEN 16109 WHEN 'Quirihue' THEN 16201 WHEN 'Cobquecura' THEN 16202 WHEN 'Coelemu' THEN 16203 WHEN 'Ninhue' THEN 16204 WHEN 'Portezuelo' THEN 16205 WHEN 'Ránquil' THEN 16206 WHEN 'Ranquil' THEN 16206 WHEN 'Treguaco' THEN 16207 WHEN 'Trehuaco' THEN 16207 WHEN 'San Carlos' THEN 16301 WHEN 'Coihueco' THEN 16302 WHEN 'Ñiquén' THEN 16303 WHEN 'Niquen' THEN 16303 WHEN 'San Fabián' THEN 16304 WHEN 'San Fabian' THEN 16304 WHEN 'San Nicolás' THEN 16305 WHEN 'San Nicolas' THEN 16305
				ELSE null
		   END as idComuna,
        ROW_NUMBER() OVER (PARTITION BY CodigoUnidad ORDER BY FechaPublicacion DESC) AS NumeroDeFila
	  FROM mercadopublico.dbo.licitaciones l
)
INSERT INTO mercadopublico.mpp.Unidad
SELECT CodigoUnidad,
       RutUnidad,
       NombreUnidad,
       CodigoOrganismo,
       idRegion,
       idComuna
FROM UnidadesConNumerosDeFila
WHERE NumeroDeFila = 1
ORDER BY CodigoUnidad, RutUnidad, NombreUnidad;