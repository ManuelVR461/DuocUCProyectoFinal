# Instalar Hadoop

## Preparación

Se utilizó el servicio de Azure para realizar esta actividad, todos los recursos utilizados se encuentran en el grupo de recursos [duoclab](https://portal.azure.com/#@sondachile.onmicrosoft.com/resource/subscriptions/91a79f1b-323c-45ae-b54e-b6fd4c45c0c2/resourceGroups/duoclab/overview)

Se utilizó:

- Una máquina virtual con SO Ubuntu 20 nombrada [hadoopUbuntu](https://portal.azure.com/#@sondachile.onmicrosoft.com/resource/subscriptions/91a79f1b-323c-45ae-b54e-b6fd4c45c0c2/resourceGroups/duoclab/providers/Microsoft.Compute/virtualMachines/hadoopUbuntu/overview)
- Un disco de datos de 1TB, nombrado [hadoopUbuntu_DataDisk_0](https://portal.azure.com/#@sondachile.onmicrosoft.com/resource/subscriptions/91a79f1b-323c-45ae-b54e-b6fd4c45c0c2/resourceGroups/duoclab/providers/Microsoft.Compute/disks/hadoopUbuntu_DataDisk_0/overview)
- La ip pública 172.174.253.211 nombrada [hadoopCentOS-ip](https://portal.azure.com/#@sondachile.onmicrosoft.com/resource/subscriptions/91a79f1b-323c-45ae-b54e-b6fd4c45c0c2/resourceGroups/duoclab/providers/Microsoft.Network/publicIPAddresses/hadoopCentOS-ip/overview)
- Un par de claves para acceso mediante certificado, nombradas [hadoopCentOS-Key](https://portal.azure.com/#@sondachile.onmicrosoft.com/resource/subscriptions/91a79f1b-323c-45ae-b54e-b6fd4c45c0c2/resourceGroups/duoclab/providers/Microsoft.Compute/sshPublicKeys/hadoopCentOS-Key/overview)

El usuario por defecto es "azureuser" y el puerto para acceder por ssh es el 22.

### Acceso por ssh

TODO: incluir aquí las instrucciones para acceder con WinSCP, putty u otra herramienta.

## Proceso

### Actualizar SO
Comenzamos actualizando el Sistema Operativo

```shell
sudo apt update
sudo apt upgrade
```

La actualización podría requerir un reinicio, tras el reinicio nuevamente actualizamos los componentes que podrían estár desactualizados tras el upgrade.

```shell
sudo apt update
```

### Formatear y montar el disco

Revise el articulo [Use the portal to attach a data disk to a Linux VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu) para ver detalles respecto de este proveso, a continuación solo se muestran los comandos ejecutados:

Formatear

```shell
sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo partprobe /dev/sdc
sudo mkfs.xfs /dev/sdc1
```

Montar

```shell
sudo mkdir /datadrive
sudo mount /dev/sdc1 /datadrive
```

En el archivo /etc/fstab se añadió la siguiente línea, para asegurar que el disco se monta al iniciar la máquina virtual

```text
UUID=58b5354a-0fe6-45a8-a794-f6d537bbcc6f   /datadrive   xfs   defaults,discard   1   2
```

### Instalar dependencias

```shell
sudo apt-get install ssh
sudo apt-get install pdsh
sudo apt install openjdk-8-jdk -y
sudo apt install openssh-server openssh-client -y
```

### Crear un usuario
Se utilizará un nuevo usuario llamado "hadoop"

```shell
sudo adduser hadoop
```

> **_NOTA:_** La clave asignada es igual al nombre de usuario "hadoop"

Creamos un directorio para almacenar todo lo relativo a hadoop

```shell
sudo mkdir /datadrive/hadoop
sudo chown hadoop:hadoop /datadrive/hadoop
```
### Instalar Hadoop

Se utilizaron estos articulos como base

- [Cómo instalar Hadoop en Windows Subsystem for Linux](https://medium.com/lcc-unison/c%C3%B3mo-instalar-hadoop-en-windows-subsystem-for-linux-d1fde59fb69c#:~:text=C%C3%B3mo%20instalar%20Hadoop%20en%20Windows%20Subsystem%20for%20Linux,Configuraci%C3%B3n%20de%20Hadoop%20en%20un%20solo%20nodo%20)
- [¿QUÉ es HADOOP? ✍ ¿CÓMO INSTALAR HADOOP en UBUNTU 18.04? ⭐](https://www.youtube.com/watch?v=BHF3rtylfPQ)

Comenzamos cambiando al usuario hadoop
```shell
su - hadoop
```

Creamos un par de claves para asegurarnos que el usuario pueda realizar conexiones ssh sin necesidad de introducir una contraseña

```shell
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
ssh localhost
```

Descargamos y descomprimimos

```shell
cd /datadrive/hadoop
wget https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.6.tar.gz
tar xzf hadoop-3.3.6.tar.gz
rm hadoop-3.3.6.tar.gz
```

Editamos el archivo ~/.bashrc para añadir las variables de entorno

```shell
nano ~/.bashrc
```

```text
export HADOOP_HOME=/datadrive/hadoop/hadoop-3.3.6
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_COMMON_LIB_NATIVE_DIR"
export PDSH_RCMD_TYPE=ssh
```
nos aseguramos de actualizar las variables en nuestra actual sesión

```shell
source ~/.bashrc
```
### Configurar

En el archivo $HADOOP_HOME/etc/hadoop/hadoop-env.sh descomentamos la línea `EXPORT JAVA_HOME=` y añadimos el path a al directorio del JDK

```shell
nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh
```

```text
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```

Modificamos la configuración del sitio

```shell
nano $HADOOP_HOME/etc/hadoop/core-site.xml
```

```xml
<configuration>
  <property>
    <name>hadoop.tmp.dir</name>
    <value>/datadrive/hadoop/tmpdata</value>
  </property>
  <property>
    <name>fs.default.name</name>
    <value>hdfs://127.0.0.1:9000</value>
  </property>
</configuration>
```

Creamos el directorio indicado en la configuracion

```shell
mkdir /datadrive/hadoop/tmpdata
```

Cambiamos la configuración del HDFS

```shell
nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml
```

```xml
<configuration>
  <property>
    <name>dfs.data.dir</name>
    <value>/datadrive/hadoop/dfsdata/namenode</value>
  </property>
  <property>
    <name>dfs.data.dir</name>
    <value>/datadrive/hadoop/dfsdata/datanode</value>
  </property>
  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>
</configuration>
```

Creamos los directorios indicado en la configuracion

```shell
mkdir -p /datadrive/hadoop/dfsdata/namenode
mkdir -p /datadrive/hadoop/dfsdata/datanode
```

Cambiamos la configuración de mapreduce

```shell
nano $HADOOP_HOME/etc/hadoop/mapred-site.xml
```

```xml
<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>
```

Cambiamos la configuración de yarn

```shell
nano $HADOOP_HOME/etc/hadoop/yarn-site.xml
```

```xml
<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
  <property>
    <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
    <value>org.apache.hadoop.mapred.ShuffleHandler</value>
  </property>
  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>127.0.0.1</value>
  </property>
  <property>
    <name>yarn.acl.enable</name>
    <value>0</value>
  </property>
  <property>
    <name>yarn.nodemanager.env-whitelist</name>
    <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
  </property>
</configuration>
```

Finalmente formateamos el namenode

```shell
hdfs namenode -format
```

### Iniciar hadoop

```shell
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
nohup $HIVE_HOME/bin/hiveserver2 &
```

Verificamos que subieron correctamente todos los servicios

```shell
jps
```

Ingresamos al sitio para verificar que todo funciona

[http://172.174.253.211:9870/](http://172.174.253.211:9870/)
