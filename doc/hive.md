# Instalar Hive

Revise la documentación oficial en [GettingStarted](https://cwiki.apache.org/confluence/display/Hive/GettingStarted)

[How to Install Apache Hive on Ubuntu](https://phoenixnap.com/kb/install-hive-on-ubuntu#:~:text=How%20to%20Install%20Apache%20Hive%20on%20Ubuntu%201,store%20the%20intermediate%20results%20of%20Hive...%20See%20More.)

> **NOTA:** Antes de comenzar asegurese que hadoop está iniciado

Descargar y descomprimir Hive
```shell
su - hadoop
cd /datadrive/hadoop
wget https://dlcdn.apache.org/hive/stable-2/apache-hive-3.3.1-bin.tar.gz
tar -xzf apache-hive-3.3.1-bin.tar.gz
rm apache-hive-3.3.1-bin.tar.gz
```

Añadir variables de entorno

```shell
nano ~/.bashrc
```

```text
export HIVE_HOME=/datadrive/hadoop/apache-hive-3.3.1-bin
export PATH=$PATH:$HIVE_HOME/bin
```

```shell
source ~/.bashrc
```

Crear directorios dentro del hdfs

```shell
hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /tmp

hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /user/hive/warehouse
```

Establecer configuración

```shell
cd $HIVE_HOME/conf
cp hive-default.xml.template hive-site.xml
```

Inicializar el schema utilizando Derby

```shell
$HIVE_HOME/bin/schematool -dbType derby -initSchema
```


