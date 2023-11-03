CREATE EXTERNAL TABLE IF NOT EXISTS enbruto.licitaciones (
    Codigo INT,
    Link VARCHAR(255),
    CodigoExterno VARCHAR(255),
    Nombre VARCHAR(255),
    Descripcion STRING,
    TipoAdquisicion VARCHAR(255),
    CodigoEstado INT,
    Estado VARCHAR(255),
    CodigoOrganismo INT,
    NombreOrganismo VARCHAR(255),
    Sector VARCHAR(255),
    RutUnidad VARCHAR(20),
    CodigoUnidad INT,
    NombreUnidad VARCHAR(255),
    DireccionUnidad VARCHAR(255),
    ComunaUnidad VARCHAR(255),
    RegionUnidad VARCHAR(255),
    Informada INT,
    CodigoTipo INT,
    Tipo VARCHAR(255),
    TipoConvocatoria VARCHAR(255),
    CodigoMoneda INT,
    MonedaAdquisicion VARCHAR(255),
    Etapas INT,
    EstadoEtapas VARCHAR(255),
    TomaRazon VARCHAR(255),
    EstadoPublicidadOfertas INT,
    JustificacionPublicidad STRING,
    EstadoCS VARCHAR(255),
    Contrato INT,
    Obras INT,
    CantidadReclamos INT,
    FechaCreacion VARCHAR(20),
    FechaCierre VARCHAR(20),
    FechaInicio VARCHAR(20),
    FechaFinal VARCHAR(20),
    FechaPubRespuestas VARCHAR(20),
    FechaActoAperturaTecnica VARCHAR(20),
    FechaActoAperturaEconomica VARCHAR(20),
    FechaPublicacion VARCHAR(20),
    FechaAdjudicacion VARCHAR(20),
    FechaEstimadaAdjudicacion VARCHAR(20),
    FechaSoporteFisico VARCHAR(20),
    FechaTiempoEvaluacion VARCHAR(20),
    UnidadTiempoEvaluacion VARCHAR(255),
    FechaEstimadaFirma VARCHAR(20),
    FechasUsuario VARCHAR(20),
    FechaVisitaTerreno VARCHAR(20),
    DireccionVisita VARCHAR(255),
    FechaEntregaAntecedentes VARCHAR(20),
    DireccionEntrega VARCHAR(255),
    Estimacion INT,
    FuenteFinanciamiento VARCHAR(255),
    VisibilidadMonto INT,
    MontoEstimado DECIMAL(18, 2),
    Tiempo INT,
    UnidadTiempo VARCHAR(255),
    Modalidad VARCHAR(255),
    TipoPago VARCHAR(255),
    ProhibicionContratacion VARCHAR(255),
    SubContratacion VARCHAR(255),
    UnidadTiempoDuracionContrato VARCHAR(255),
    TiempoDuracionContrato INT,
    TipoDuracionContrato VARCHAR(255),
    JustificacionMontoEstimado STRING,
    ObservacionContrato STRING,
    ExtensionPlazo VARCHAR(255),
    EsBaseTipo INT,
    UnidadTiempoContratoLicitacion VARCHAR(255),
    ValorTiempoRenovacion INT,
    PeriodoTiempoRenovacion VARCHAR(255),
    EsRenovable INT,
    TipoAprobacion VARCHAR(255),
    NumeroAprobacion INT,
    FechaAprobacion VARCHAR(20),
    NumeroOferentes INT,
    Correlativo INT,
    CodigoEstadoLicitacion INT,
    CodigoItem INT,
    CodigoProductoONU INT,
    Rubro1 VARCHAR(255),
    Rubro2 VARCHAR(255),
    Rubro3 VARCHAR(255),
    NombreProductoGenerico VARCHAR(255),
    NombreLineaAdquisicion VARCHAR(255),
    DescripcionLineaAdquisicion STRING,
    UnidadMedida VARCHAR(255),
    Cantidad INT,
    CodigoProveedor INT,
    CodigoSucursalProveedor INT,
    RutProveedor VARCHAR(20),
    NombreProveedor VARCHAR(255),
    RazonSocialProveedor VARCHAR(255),
    DescripcionProveedor STRING,
    MontoEstimadoAdjudicado DECIMAL(18, 2),
    NombreOferta VARCHAR(255),
    EstadoOferta VARCHAR(255),
    CantidadOfertada INT,
    MonedaOferta VARCHAR(255),
    MontoUnitarioOferta DECIMAL(18, 2),
    ValorTotalOfertado DECIMAL(18, 2),
    CantidadAdjudicada INT,
    MontoLineaAdjudica DECIMAL(18, 2),
    FechaEnvioOferta VARCHAR(20),
    OfertaSeleccionada VARCHAR(255)
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ";",
   "quoteChar"     = "\"",
   "escapeChar"    = "\\"
)
LOCATION '/user/mercadopublico/lic'
TBLPROPERTIES ("skip.header.line.count"="1");