# DuocUCProyectoFinal
Proyecto Final Modulo Machine Learning

## Iniciar los servicios
Acceda por ssh al servidor y ejecute estos comandos:

### Iniciar hadoop

```shell
su - hadoop
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
```

Verificamos que subieron correctamente todos los servicios

```shell
jps
```

TODO: Mostrar ejemplo de resultado esperado

## Scripts

- [descargar-lic.sh](scripts/descargar-lic.sh): Descarga los CSV de licitaciones
- [descargar-oc.sh](scripts/descargar-oc.sh): Descarga las ordenes de compra

## Más información sobre:
- [Instalar Hadoop](doc/hadoop.md)
- [Instalar Hive](doc/hive.md)

