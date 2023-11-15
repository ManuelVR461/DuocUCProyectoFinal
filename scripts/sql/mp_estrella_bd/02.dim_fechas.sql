DROP TABLE IF EXISTS mp_estrella_db.dbo.dim_fecha;

CREATE TABLE mp_estrella_db.dbo.dim_fecha (
	id_fecha   int not null,
	fecha	   date not null,
	dia		   int not null,
	mes        int not null,
	año        int not null,
	dia_semana varchar(15),
	nombre_mes varchar(15),
	semestre   varchar(15),
	trimestre  varchar(15),
	CONSTRAINT PK_fecha PRIMARY KEY (id_fecha)
);

INSERT INTO mp_estrella_db.dbo.dim_fecha (id_fecha, fecha, dia, mes, año, dia_semana, nombre_mes, semestre, trimestre)
SELECT DISTINCT
    fechaAdjudicacion AS id_fecha,
    CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112) AS fecha,
    DAY(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) AS dia,
    MONTH(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) AS mes,
    YEAR(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) AS año,
    DATENAME(dw, CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) AS dia_semana,
    DATENAME(month, CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) AS nombre_mes,
    CASE WHEN MONTH(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) <= 6 THEN 'primero' ELSE 'segundo' END AS semestre,
    CASE 
        WHEN MONTH(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) BETWEEN 1 AND 3 THEN '1'
        WHEN MONTH(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) BETWEEN 4 AND 6 THEN '2'
        WHEN MONTH(CONVERT(date, CONVERT(varchar(8), fechaAdjudicacion), 112)) BETWEEN 7 AND 9 THEN '3'
        ELSE '4' 
    END AS trimestre
FROM mercadopublico.dbo.licitaciones
WHERE fechaAdjudicacion BETWEEN '2007-01-01' AND '2024-01-01'
GROUP BY fechaAdjudicacion;