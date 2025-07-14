# passChecker

![pass](https://github.com/user-attachments/assets/9eded02d-83e3-4cc0-9ee1-1821e57a65b7)


Herramienta en Bash para verificar si una contraseña ha sido comprometida en bases de datos filtradas, utilizando la API de [Have I Been Pwned](https://haveibeenpwned.com/API/v3).

![License](https://img.shields.io/badge/license-MIT-blue.svg)  
![Made with Bash](https://img.shields.io/badge/made%20with-Bash-blue?logo=gnubash)

## Descripción

`passChecker` es un script ligero y eficiente escrito en Bash que permite comprobar si una contraseña ha aparecido en filtraciones conocidas. Lo hace utilizando el sistema de **k-Anonimato** de la API `pwnedpasswords`, garantizando privacidad durante la consulta.

Ideal para pentesters, sysadmins y usuarios preocupados por la seguridad de sus credenciales.


## Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/tu-usuario/passChecker.git
   
2. Abre el directorio
    ```bash
   cd passChecker
  
3. Concede permisos de ejecución al script:
   ```bash
   chmod +x passChecker.sh

## Uso
```bash
./passChecker.sh -p "tuContraseña"
```
## Parámetros disponibles
Opción	Descripción
- -p:	    Contraseña a verificar
- -e:	    Opción en desarrollo
- -h:	    Mostrar panel de ayuda

## Dependencias

- curl
- sha1sum
- awk
- GNU/Linux o macOS con bash

## Panel de ayuda

El script incluye un menú de ayuda accesible con -h:

``` bash
./passChecker.sh -h
```

## Autor
Proyecto creado por c4skd





