-- Primero, asegúrate de que no haya conexiones activas a la base de datos
USE master;
GO

-- Desconecta a los usuarios de la base de datos
ALTER DATABASE mercadopublico
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

-- Elimina la base de datos
DROP DATABASE mercadopublico;
GO

-- Crea la base de datos mercadopublico
CREATE DATABASE mercadopublico;
GO

-- Cambia al contexto de la nueva base de datos
USE mercadopublico;
GO

-- Itera desde el año 2007 hasta 2024
DECLARE @Anio INT = 2007;
DECLARE @SQL NVARCHAR(MAX);

WHILE @Anio <= 2025
BEGIN
    -- Crea el nombre del FileGroup y el archivo de datos
    SET @SQL = N'ALTER DATABASE mercadopublico ADD FILEGROUP LicitacionesFilegroup' + CAST(@Anio AS NVARCHAR(4)) + N';

    ALTER DATABASE mercadopublico
    ADD FILE 
    (NAME = N''LicitacionesFile' + CAST(@Anio AS NVARCHAR(4)) + N''',
    FILENAME = N''C:\work\mercadopublico\BD\LicitacionesFile' + CAST(@Anio AS NVARCHAR(4)) + N'.mdf'',
    SIZE = 100MB, -- Tamaño inicial del archivo en MB
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB -- Incremento automático del archivo en MB
	) TO FILEGROUP LicitacionesFilegroup' + CAST(@Anio AS NVARCHAR(4));

    -- Ejecuta el comando SQL dinámico
    EXEC sp_executesql @SQL;

    -- Incrementa el año
    SET @Anio = @Anio + 1;
END

/****** Object:  PartitionFunction [PF_FechaPublicacion]    Script Date: 04-11-2023 16:00:17 ******/
CREATE PARTITION FUNCTION [PF_FechaPublicacion](int)
AS RANGE RIGHT FOR VALUES (
  20070101, 20080101, 20090101, 20100101,
  20110101, 20120101, 20130101, 20140101,
  20150101, 20160101, 20170101, 20180101,
  20190101, 20200101, 20210101, 20220101,
  20230101, 20240101)
GO

-- Crea el PARTITION SCHEME PS_FechaPublicacion utilizando los FileGroups correspondientes
CREATE PARTITION SCHEME PS_FechaPublicacion
AS PARTITION PF_FechaPublicacion
TO (
    LicitacionesFilegroup2007, LicitacionesFilegroup2008, LicitacionesFilegroup2009, LicitacionesFilegroup2010,
    LicitacionesFilegroup2011, LicitacionesFilegroup2012, LicitacionesFilegroup2013, LicitacionesFilegroup2014,
    LicitacionesFilegroup2015, LicitacionesFilegroup2016, LicitacionesFilegroup2017, LicitacionesFilegroup2018,
    LicitacionesFilegroup2019, LicitacionesFilegroup2020, LicitacionesFilegroup2021, LicitacionesFilegroup2022,
    LicitacionesFilegroup2023, LicitacionesFilegroup2024, LicitacionesFilegroup2025
);
GO


IF OBJECT_ID('mercadopublico.dbo.licitaciones', 'U') IS NOT NULL
	DROP TABLE mercadopublico.dbo.licitaciones;
go

CREATE TABLE [dbo].[licitaciones](
	[Codigo] [int] NOT NULL,
	-- Link varchar(255),
	[TipodeAdquisicion] [varchar](255) NULL,
	[CodigoEstado] [int] NULL,
	[Estado] [varchar](255) NULL,
	[CodigoOrganismo] [int] NULL,
	[NombreOrganismo] [varchar](255) NULL,
	[sector] [varchar](255) NULL,
	[RutUnidad] [varchar](255) NULL,
	[CodigoUnidad] [int] NULL,
	[NombreUnidad] [varchar](255) NULL,
-- DireccionUnidad varchar(255),
	[ComunaUnidad] [varchar](255) NULL,
	[RegionUnidad] [varchar](255) NULL,
-- 	Tipo varchar(255),
	[CodigoMoneda] [varchar](255) NULL,
-- 	Etapas int NULL,
-- 	Contrato int NULL,
	[CantidadReclamos] [int] NULL,
-- 	FechaCreacion int NULL,
	[FechaPublicacion] [int] NULL,
	[FechaCierre] [int] NULL,
-- 	FechaInicio int NULL,
-- 	FechaFinal int NULL,
-- 	FechaPubRespuestas int NULL,
	[FechaAdjudicacion] [int] NULL,
-- 	FechaTiempoEvaluacion int NULL,
-- 	TiempoEvaluacion int NULL,
--  UnidadTiempoEvaluacion varchar(255),
-- 	FechaEstimadaFirma int NULL,
-- 	FechasUsuario int NULL,
-- 	Estimacion int NULL,
-- 	VisibilidadMonto int NULL,
	[MontoEstimado] [numeric](36, 0) NULL,
-- 	TiempoLicitacion int NULL,
	[Modalidad] [varchar](255) NULL,
	[TipoPago] [varchar](255) NULL,
	[SubContratacion] [int] NULL,
	[UnidadTiempoDuracionContrato] [int] NULL,
	[TiempoDuracionContrato] [int] NULL,
	[ExtensionPlazo] [int] NULL,
-- 	UnidadTiempoContratoLicitacion int NULL,
	[EsRenovable] [int] NULL,
-- 	TipoAprobacion int NULL,
-- 	FechaAprobacion int NULL,
-- 	NumeroOferentes int NULL,
-- 	Correlativo int NULL,
-- 	CodigoEstadoLicitacion int NULL,
-- 	CodigoItem int NULL,
	[CodigoProductoONU] [int] NULL,
	[Rubro1] [varchar](255) NULL,
	[Rubro2] [varchar](255) NULL,
	[Rubro3] [varchar](255) NULL,
	[Nombreproductogenerico] [varchar](255) NULL,
	[UnidadMedida] [varchar](255) NULL,
	[Cantidad] [bigint] NULL,
	[CodigoProveedor] [int] NULL,
	[CodigoSucursalProveedor] [int] NULL,
	[RutProveedor] [varchar](255) NULL,
	[NombreProveedor] [varchar](255) NULL,
-- 	RazonSocialProveedor varchar(255),
-- 	MontoEstimadoAdjudicado numeric(36, 10) NULL,
-- 	NombredelaOferta varchar(255),
	[EstadoOferta] [varchar](255) NULL,
	[CantidadOfertada] [bigint] NULL,
	[MonedadelaOferta] [varchar](255) NULL,
	[MontoUnitarioOferta] [numeric](36, 6) NULL,
	[ValorTotalOfertado] [numeric](36, 6) NULL,
	[CantidadAdjudicada] [numeric](36, 6) NULL,
	[MontoLineaAdjudica] [numeric](36, 6) NULL,
	[FechaEnvioOferta] [int] NULL,
	[Ofertaseleccionada] [int] NULL
) ON [PS_FechaPublicacion]([FechaPublicacion])
GO

CREATE NONCLUSTERED INDEX tipoAdquisicion_licitacion_idx ON mercadopublico.dbo.licitaciones ( TipodeAdquisicion ASC)
GO

CREATE NONCLUSTERED INDEX estado_licitacion_idx ON mercadopublico.dbo.licitaciones ( CodigoEstado ASC, Estado ASC)
GO

CREATE NONCLUSTERED INDEX organismo_licitacion_idx ON mercadopublico.dbo.licitaciones ( CodigoOrganismo ASC, NombreOrganismo ASC)
GO

CREATE NONCLUSTERED INDEX sector_licitacion_idx ON mercadopublico.dbo.licitaciones ( sector ASC)
GO

CREATE NONCLUSTERED INDEX unidad_licitacion_idx ON mercadopublico.dbo.licitaciones ( NombreUnidad ASC, CodigoUnidad ASC)
GO

CREATE NONCLUSTERED INDEX comunaUnidad_licitacion_idx ON mercadopublico.dbo.licitaciones ( ComunaUnidad ASC)
GO

CREATE NONCLUSTERED INDEX regionUnidad_licitacion_idx ON mercadopublico.dbo.licitaciones ( RegionUnidad ASC)
GO

CREATE NONCLUSTERED INDEX moneda_licitacion_idx ON mercadopublico.dbo.licitaciones ( CodigoMoneda ASC)
GO

CREATE NONCLUSTERED INDEX modalidad_licitacion_idx ON mercadopublico.dbo.licitaciones ( Modalidad ASC)
GO

CREATE NONCLUSTERED INDEX tipoPago_licitacion_idx ON mercadopublico.dbo.licitaciones ( TipoPago ASC)
GO

CREATE NONCLUSTERED INDEX producto_licitacion_idx ON mercadopublico.dbo.licitaciones ( Nombreproductogenerico ASC, CodigoProductoONU ASC)
GO

CREATE NONCLUSTERED INDEX rubro_licitacion_idx ON mercadopublico.dbo.licitaciones ( Rubro1 ASC, Rubro2 ASC, Rubro3 ASC)
GO

CREATE NONCLUSTERED INDEX proveedor_licitacion_idx ON mercadopublico.dbo.licitaciones ( NombreProveedor ASC, CodigoProveedor ASC, CodigoSucursalProveedor ASC, RutProveedor ASC)
GO

CREATE NONCLUSTERED INDEX montos_licitacion_idx ON mercadopublico.dbo.licitaciones ( MontoLineaAdjudica ASC, MontoEstimado ASC)
GO
