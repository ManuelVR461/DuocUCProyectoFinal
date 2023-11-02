-- mercadopublico.dbo.licitaciones definition

-- Drop table

IF OBJECT_ID('mercadopublico.dbo.licitaciones', 'U') IS NOT NULL
	DROP TABLE mercadopublico.dbo.licitaciones;

CREATE TABLE mercadopublico.dbo.licitaciones (
 	Codigo int NOT NULL,
	-- Link varchar(255),
 	CodigoExterno varchar(255),
 	Nombre varchar(255),
 	Descripcion varchar(MAX),
 	TipodeAdquisicion varchar(255),
 	CodigoEstado int NULL,
 	Estado varchar(255),
 	CodigoOrganismo int NULL,
 	NombreOrganismo varchar(255),
 	sector varchar(255),
 	RutUnidad varchar(255),
 	CodigoUnidad int NULL,
 	NombreUnidad varchar(255),
	-- DireccionUnidad varchar(255),
 	ComunaUnidad varchar(255),
 	RegionUnidad varchar(255),
-- 	Tipo varchar(255),
 	CodigoMoneda varchar(255),
-- 	Etapas int NULL,
-- 	Contrato int NULL,
 	CantidadReclamos int NULL,
-- 	FechaCreacion int NULL,
 	FechaPublicacion int NULL,
 	FechaCierre int NULL,
-- 	FechaInicio int NULL,
-- 	FechaFinal int NULL,
-- 	FechaPubRespuestas int NULL,
 	FechaAdjudicacion int NULL,
-- 	FechaTiempoEvaluacion int NULL,
-- 	TiempoEvaluacion int NULL,
--  UnidadTiempoEvaluacion varchar(255),
-- 	FechaEstimadaFirma int NULL,
-- 	FechasUsuario int NULL,
-- 	Estimacion int NULL,
-- 	VisibilidadMonto int NULL,
 	MontoEstimado numeric(36, 10) NULL,
-- 	TiempoLicitacion int NULL,
 	Modalidad varchar(255),
 	TipoPago varchar(255),
 	SubContratacion int NULL,
-- 	UnidadTiempoDuracionContrato int NULL,
-- 	TiempoDuracionContrato int NULL,
 	ExtensionPlazo int NULL,
-- 	UnidadTiempoContratoLicitacion int NULL,
 	EsRenovable int NULL,
-- 	TipoAprobacion int NULL,
-- 	FechaAprobacion int NULL,
-- 	NumeroOferentes int NULL,
-- 	Correlativo int NULL,
-- 	CodigoEstadoLicitacion int NULL,
-- 	CodigoItem int NULL,
 	CodigoProductoONU int NULL,
 	Rubro1 varchar(255),
 	Rubro2 varchar(255),
 	Rubro3 varchar(255),
 	Nombreproductogenerico varchar(255),
 	UnidadMedida varchar(255),
 	Cantidad int NULL,
 	CodigoProveedor int NULL,
 	CodigoSucursalProveedor int NULL,
 	RutProveedor varchar(255),
 	NombreProveedor varchar(255),
-- 	RazonSocialProveedor varchar(255),
-- 	MontoEstimadoAdjudicado numeric(36, 10) NULL,
-- 	NombredelaOferta varchar(255),
 	EstadoOferta varchar(255),
 	CantidadOfertada int NULL,
 	MonedadelaOferta varchar(255),
 	MontoUnitarioOferta numeric(36, 10) NULL,
 	ValorTotalOfertado numeric(36, 10) NULL,
 	CantidadAdjudicada numeric(36, 10) NULL,
 	MontoLineaAdjudica numeric(36, 10) NULL,
 	FechaEnvioOferta int NULL,
 	Ofertaseleccionada int NULL,
);

CREATE INDEX licitaciones_Codigo_IDX ON mercadopublico.dbo.licitaciones (Codigo);

CREATE INDEX licitaciones_CodigoOrganismo_IDX ON mercadopublico.dbo.licitaciones (CodigoOrganismo);

CREATE INDEX licitaciones_CodigoUnidad_IDX ON mercadopublico.dbo.licitaciones (CodigoUnidad);

CREATE INDEX licitaciones_CodigoMoneda_IDX ON mercadopublico.dbo.licitaciones (CodigoMoneda);

CREATE INDEX licitaciones_CodigoProductoONU_IDX ON mercadopublico.dbo.licitaciones (CodigoProductoONU);

CREATE INDEX licitaciones_TipodeAdquisicion_IDX ON mercadopublico.dbo.licitaciones (TipodeAdquisicion);

CREATE INDEX licitaciones_CodigoEstado_IDX ON mercadopublico.dbo.licitaciones (CodigoEstado);

CREATE INDEX licitaciones_Sector_IDX ON mercadopublico.dbo.licitaciones (sector);

CREATE INDEX licitaciones_NombreOrganismo_IDX ON mercadopublico.dbo.licitaciones (NombreOrganismo);

CREATE INDEX licitaciones_RegionUnidad_IDX ON mercadopublico.dbo.licitaciones (RegionUnidad);

CREATE INDEX licitaciones_ComunaUnidad_IDX ON mercadopublico.dbo.licitaciones (ComunaUnidad);

CREATE INDEX licitaciones_Rubro1_IDX ON mercadopublico.dbo.licitaciones (Rubro1);

CREATE INDEX licitaciones_Rubro2_IDX ON mercadopublico.dbo.licitaciones (Rubro2);

CREATE INDEX licitaciones_Rubro3_IDX ON mercadopublico.dbo.licitaciones (Rubro3);

CREATE INDEX licitaciones_Modalidad_IDX ON mercadopublico.dbo.licitaciones (Modalidad);

CREATE INDEX licitaciones_CodigoProveedor_IDX ON mercadopublico.dbo.licitaciones (CodigoProveedor);
