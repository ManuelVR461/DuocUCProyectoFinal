# Dependencias:
# pip install pandas
# pip install sqlalchemy
# ODBC Driver 18 for SQL Server https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16

import os
import pandas as pd
import unicodedata
from datetime import datetime
import zipfile
import time
import sqlalchemy
from sqlalchemy.engine import URL

GENERAR_CSV:bool=True
COMPRIMIR:bool=GENERAR_CSV and False
GRABAR_EN_BD:bool=False

# Función para convertir montos a entero
def convertir_montos(monto):
    return int(float(str(monto).replace(",", ".")))


# Función para convertir fechas a formato numérico
def convertir_fecha(fecha):
    fecha = "1990-01-01" if pd.isna(fecha) or fecha == "" else fecha
    return int(datetime.strptime(fecha[:10], "%Y-%m-%d").strftime("%Y%m%d"))

# Función para calcular tiempo en horas
def calcular_tiempo_en_horas(row, tipo_tiempo):
    periodos = {
        "RFB_TIME_PERIOD_DAYS": 24,
        "RFB_TIME_PERIOD_HOURS": 1,
        "RFB_TIME_PERIOD_MONTHS": 720,
        "RFB_TIME_PERIOD_WEEKS": 24 * 7,
    }
    return row["Tiempo"] * periodos.get(tipo_tiempo, 0)


# Función para eliminar tildes de un texto
def normalize_text(texto):
    return unicodedata.normalize('NFKD', texto).encode('ASCII', 'ignore').decode() if isinstance(texto, str) else texto

def comprimir(archivo):
    archivo_zip = archivo.replace(".csv", ".zip")
    with zipfile.ZipFile(
        archivo_zip, "w", zipfile.ZIP_DEFLATED
    ) as zipf:
        zipf.write(archivo)

def exportar_a_bd(df: pd.DataFrame, tabla: str):
    # Configuración de la conexión a la base de datos Azure SQL Server
    # Driver={ODBC Driver 18 for SQL Server};Server=tcp:duoclab.database.windows.net,1433;Database=mercadopublico;Uid=adm;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;
    server = 'tcp:localhost'
    database = 'mercadopublico'
    username = 'lab'
    password = 'lab'
    driver = '{ODBC Driver 18 for SQL Server}'
    conn_string = f"DRIVER={driver};SERVER={server};PORT=1433;DATABASE={database};UID={username};PWD={password};Encrypt=yes;TrustServerCertificate=yes;Connection Timeout=30;"

    conn_url = URL.create("mssql+pyodbc", query={"odbc_connect": conn_string})
    conn = sqlalchemy.create_engine(conn_url)
    df.to_sql(tabla, conn, schema='dbo', if_exists='append', index=False)
    conn.dispose()

def obtener_dataframe(archivos_csv):
    # Lista de columnas que se quieren utilizar
    COLUMNAS_CONSERVAR = [
        "Codigo",
        #"Link",
        "CodigoExterno",
        "Nombre",
        "Descripcion",
        "Tipo de Adquisicion",
        "CodigoEstado",
        "Estado",
        "CodigoOrganismo",
        "NombreOrganismo",
        "sector",
        "RutUnidad",
        "CodigoUnidad",
        "NombreUnidad",
        #"DireccionUnidad",
        "ComunaUnidad",
        "RegionUnidad",
        #"Informada",
        #"CodigoTipo",
        #"Tipo",
        #"TipoConvocatoria",
        "CodigoMoneda",
        #"Moneda Adquisicion",
        #"Etapas",
        #"EstadoEtapas",
        #"TomaRazon",
        #"EstadoPublicidadOfertas",
        #"JustificacionPublicidad",
        #"EstadoCS",
        #"Contrato",
        #"Obras",
        "CantidadReclamos",
        #"FechaCreacion",
        "FechaCierre",
        #"FechaInicio",
        #"FechaFinal",
        #"FechaPubRespuestas",
        #"FechaActoAperturaTecnica",
        #"FechaActoAperturaEconomica",
        "FechaPublicacion",
        "FechaAdjudicacion",
        #"FechaEstimadaAdjudicacion",
        #"FechaSoporteFisico",
        #"FechaTiempoEvaluacion",
        #"UnidadTiempoEvaluacion",
        #"FechaEstimadaFirma",
        #"FechasUsuario",
        #"FechaVisitaTerreno",
        #"DireccionVisita",
        #"FechaEntregaAntecedentes",
        #"DireccionEntrega",
        #"Estimacion",
        #"FuenteFinanciamiento",
        #"VisibilidadMonto",
        "MontoEstimado",
        #"Tiempo",
        #"UnidadTiempo",
        "Modalidad",
        "TipoPago",
        #"ProhibicionContratacion",
        "SubContratacion",
        #"UnidadTiempoDuracionContrato",
        #"TiempoDuracionContrato",
        #"TipoDuracionContrato",
        #"JustificacionMontoEstimado",
        #"ObservacionContrato",
        "ExtensionPlazo",
        #"EsBaseTipo",
        #"UnidadTiempoContratoLicitacion",
        #"ValorTiempoRenovacion",
        #"PeriodoTiempoRenovacion",
        "EsRenovable",
        #"TipoAprobacion",
        #"NumeroAprobacion",
        #"FechaAprobacion",
        #"NumeroOferentes",
        #"Correlativo",
        #"CodigoEstadoLicitacion",
        #"Codigoitem",
        "CodigoProductoONU",
        "Rubro1",
        "Rubro2",
        "Rubro3",
        "Nombre producto generico",
        #"Nombre linea Adquisicion",
        #"Descripcion linea Adquisicion",
        "UnidadMedida",
        "Cantidad",
        "CodigoProveedor",
        "CodigoSucursalProveedor",
        "RutProveedor",
        "NombreProveedor",
        #"RazonSocialProveedor",
        #"DescripcionProveedor",
        #"Monto Estimado Adjudicado",
        #"Nombre de la Oferta",
        "Estado Oferta",
        "Cantidad Ofertada",
        "Moneda de la Oferta",
        "MontoUnitarioOferta",
        "Valor Total Ofertado",
        "CantidadAdjudicada",
        "MontoLineaAdjudica",
        "FechaEnvioOferta",
        "Oferta seleccionada",
        #"UnidadMedida.1",
        #"Estado final Oferta",
        #"RutUsuario",
        #"CodigoUsuario",
        #"NombreUsuario",
        #"CargoUsuario",
        #"NombreResponsablePago",
        #"EmailResponsablePago",
        #"NombreResponsableContrato",
        #"EmailResponsableContrato",
        #"FonoResponsableContrato"
    ]

    # Leer y combinar DataFrames individuales
    dataframes = []
    for archivo in archivos_csv:
        print(f"leyendo archivo {archivo}")
        df_individual = pd.read_csv(archivo, encoding="ISO-8859-1", delimiter=";", low_memory=False)

        # En algunos archivos los encabezados tienen tildes y en otros no los tienen
        df_individual.rename(columns=normalize_text, inplace=True)

        # En algunos archivos faltan estas columnas
        if "sector" not in df_individual.columns:
            df_individual["sector"] = None
        if "Estado final Oferta" not in df_individual.columns:
            df_individual["Estado final Oferta"] = None

        if "Nombre producto genrico" in df_individual.columns:
            df_individual.rename(columns={"Nombre producto genrico": "Nombre producto generico"}, inplace=True)

        columnas_conservar = [col for col in COLUMNAS_CONSERVAR if col in df_individual.columns]
        dataframes.append(df_individual[columnas_conservar])
    df = pd.concat(dataframes, ignore_index=True)
    del dataframes

    COLUMNAS_NUMERICAS = [
        "Codigo",
        "CodigoEstado",
        "CodigoOrganismo",
        "CodigoUnidad",
        "CantidadReclamos",
        "SubContratacion",
        "ExtensionPlazo",
        "EsRenovable",
        "CodigoProductoONU",
        "CodigoProveedor",
    ]
    df[COLUMNAS_NUMERICAS] = df[COLUMNAS_NUMERICAS].apply(pd.to_numeric)

    return df

def procesar_dataframe(df):
    # Convertir campos vacíos o sin registros en None en cada columna
    df = df.apply(lambda col: col.map(lambda x: None if pd.isna(x) or x == "" else x))

    # Convertir notación científica a enteros en columnas de montos
    COLUMNAS_MONTOS = [
        "Cantidad",
        "Cantidad Ofertada",
        "CantidadAdjudicada",
        "MontoUnitarioOferta",
        "Valor Total Ofertado",
        "MontoLineaAdjudica",
        #"Monto Estimado Adjudicado",
        "MontoEstimado",
    ]
    
    for columna in COLUMNAS_MONTOS:
        df[columna] = df[columna].fillna(0).apply(convertir_montos)

    df[COLUMNAS_MONTOS] = df[COLUMNAS_MONTOS].apply(pd.to_numeric)


    # Transformar fechas a formato numérico
    COLUMNAS_FECHA = [
        "FechaPublicacion",
        #"FechaAprobacion",
        #"FechaCreacion",
        "FechaCierre",
        #"FechaInicio",
        #"FechaFinal",
        #"FechaPubRespuestas",
        "FechaAdjudicacion",
        "FechaEnvioOferta",
        #"FechaEstimadaFirma",
    ]  # Lista completa de columnas de fechas
    for columna in COLUMNAS_FECHA:
        df[columna] = df[columna].apply(convertir_fecha)
    
    df[COLUMNAS_FECHA] = df[COLUMNAS_FECHA].apply(pd.to_numeric)

    # Reemplazar valores en columnas 'Estado Oferta' y 'Oferta seleccionada'
    df["Estado Oferta"] = (
        df["Estado Oferta"].replace({"Aceptada": 1, "Rechazada": 0}).astype(int)
    )

    df["Oferta seleccionada"] = (
        df["Oferta seleccionada"]
        .replace({"Seleccionada": 1, "Ganadora": 1, "No Seleccionada": 0, "No sleccionada": 0, "Perdedora": 0})
        .astype(int)
    )

    # Rellenar valores nulos en las columnas 'Tiempo' y 'FechaTiempoEvaluacion' con cero y convertir a entero
    # df["Tiempo"] = df["Tiempo"].fillna(0).astype(int)
    # df["FechaTiempoEvaluacion"] = df["FechaTiempoEvaluacion"].fillna(0).astype(int)

    # Calcular el tiempo en horas y renombrar columnas
    #df["TiempoLicitacion"] = df.apply(
    #    lambda row: calcular_tiempo_en_horas(row, row["UnidadTiempo"]), axis=1
    #)
    #df["TiempoEvaluacion"] = df.apply(
    #    lambda row: calcular_tiempo_en_horas(row, row["UnidadTiempoEvaluacion"]), axis=1
    #)
    #df.drop(["UnidadTiempo", "UnidadTiempoEvaluacion"], axis="columns", inplace=True)

    # Normalizar caracteres especiales
    df = df.apply(
        lambda col: col.map(
            lambda x: normalize_text(x)
        )
    )

    # Quitar espacios de nombres de columnas
    df.columns = df.columns.str.replace(' ', '')

    # Elimino registros duplicados
    df = df.drop_duplicates()

    # Eliminar filas con valores nulos por debajo del 5% en las columnas seleccionadas
    COLS_NULOS = df.columns[df.isnull().mean() < 0.05]
    df = df.dropna(subset=COLS_NULOS)

    return df


for año in range(2014, 2015):
    directorio = os.path.join("data", str(año))
    archivos_csv = [
        os.path.join(directorio, archivo) 
        for archivo in os.listdir(directorio) 
        if archivo.endswith(".csv")
    ]
    start_time = time.time()
    df = obtener_dataframe(archivos_csv)
    # Calcular y mostrar el tiempo transcurrido
    elapsed_time = time.time() - start_time
    print(f"*********** {elapsed_time:.2f} segundos cargando archivos {archivos_csv}")
    
    start_time = time.time()
    print(f"Dataframe antes de procesar {df.shape}")
    df = procesar_dataframe(df)
    print(f"Dataframe despues de procesar {df.shape}")
    elapsed_time = time.time() - start_time
    print(f"*********** {elapsed_time:.2f} segundos procesando dataframe")

    # Guardar el DataFrame limpio en un archivo CSV dentro de un archivo ZIP
    if GENERAR_CSV:
        start_time = time.time()
        ARCHIVO_CSV = os.path.join("data", "limpios", f"{año}.csv")
        df.to_csv(ARCHIVO_CSV, index=False, sep=",")
        elapsed_time = time.time() - start_time
        print(f"*********** {elapsed_time:.2f} segundos guardando archivo CSV {ARCHIVO_CSV}")

    # guardar en BD
    if GRABAR_EN_BD:
        start_time = time.time()
        exportar_a_bd(df, 'licitaciones')
        elapsed_time = time.time() - start_time
        print(f"*********** {elapsed_time:.2f} segundos grabando en BD")
    
    del df