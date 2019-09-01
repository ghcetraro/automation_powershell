#habilitar ejecucion de srcitps, abrir una consola de powersheel y ejecutar "Set-ExecutionPolicy Unrestricted"
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe C:\PowerShell\backup_ca.ps1

#limpia la pantalla
echo "limpia pantalla"
cls

#busca la fecha del dia
echo "obtiene la fache"
$date = Get-Date -Format d.MMMM.yyyy

#acumula el directorio de backup
echo "acumula el directorio logs"
$dirlog = "C:\PowerShell\log"

#acumula el directorio de backup
echo "acumula el directorio"
$dirbackup = "C:\IIS_Backup"

#acumula el directorio de backup
echo "acumula la nueva carpeta"
$folderbackup = "$dirbackup\$date"

#se crea la variable verificadora a 
echo "crea la variable verificadora a"
$patha = test-Path $dirbackup

#se crea la variable verificadora b
echo "crea la variable verificadora b" 
$pathb = test-Path $folderbackup

#se crea la variable verificadora c
echo "crea la variable verificadora b" 
$pathc = test-Path $dirlog

#revisa si el directorio de backup existe
echo "se chequea la existencia del directorio a"
if ($patha -eq $true) 
	{ 
	echo "el directorio $dirbackup existe " 
	}
else 
	{
	echo "el directorio $dirbackup no existe, se creara el mismo"
	#crear el nuevo directorio
    mkdir $dirbackup
	}

#se borra el contenido viejo de $dirbackup
echo "se borra el contenido del directorio a"
remove-item $dirbackup\* -force -recurse
	
#revisa si el directorio de backup existe
echo "se chequea la existencia del directorio b"
if ($pathb -eq $true) 
	{ 
	echo "el directorio $folderbackup existe " 
	}
else 
	{
	echo "el directorio $folderbackup no existe, se creara el mismo"
	#crear el nuevo directorio
    mkdir $folderbackup
	}

#se realiza el backup cd CA 
echo "se realiza el backup de CA"
certutil -p password -backup $folderbackup

#revisa si el directorio de backup existe
echo "se chequea la existencia del directorio a"
if ($pathc -eq $true) 
	{ 
	echo "el directorio $dirbackup existe " 
	}
else 
	{
	echo "el directorio $dirbackup no existe, se creara el mismo"
	#crear el nuevo directorio
    mkdir $dirlog
	}

#crea un log
echo "backup realizado $date" >> $dirlog\backup_ca.log


