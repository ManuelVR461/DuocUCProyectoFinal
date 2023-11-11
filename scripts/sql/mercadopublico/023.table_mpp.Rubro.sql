IF OBJECT_ID('mercadopublico.mpp.Rubro', 'U') IS NOT NULL
	DROP TABLE mercadopublico.mpp.Rubro;
GO

CREATE TABLE mercadopublico.mpp.Rubro (
	idRubro INT IDENTITY(1,1) NOT NULL,
	nombre varchar(255),
	idRubroSuperior INT NULL,
    CONSTRAINT rubro_PK PRIMARY KEY (idRubro)
);
GO

INSERT INTO mercadopublico.mpp.Rubro(nombre)
SELECT DISTINCT Rubro1
  FROM mercadopublico.dbo.licitaciones
 WHERE Rubro1 IS NOT NULL;


INSERT INTO mercadopublico.mpp.Rubro(nombre, idRubroSuperior)
SELECT DISTINCT l.Rubro2, r2.idRubro
  FROM mercadopublico.dbo.licitaciones l
 INNER JOIN mercadopublico.mpp.Rubro r2
         ON r2.nombre = l.Rubro1
        AND r2.idRubroSuperior IS NULL
 WHERE Rubro1 IS NOT NULL
   AND Rubro2 IS NOT NULL;

INSERT INTO mercadopublico.mpp.Rubro(nombre, idRubroSuperior)
SELECT DISTINCT l.Rubro3, r2.idRubro
  FROM mercadopublico.dbo.licitaciones l
 INNER JOIN mercadopublico.mpp.Rubro r2
         ON r2.nombre = l.Rubro2
        AND r2.idRubroSuperior IS NOT NULL
 WHERE Rubro1 IS NOT NULL
   AND Rubro2 IS NOT NULL;
