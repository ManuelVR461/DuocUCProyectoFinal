use mercadopublico
go
-- creo un nuevo schema para las tablas normalizadas
IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'mpp')
BEGIN
    EXEC('CREATE SCHEMA mpp;');
END
