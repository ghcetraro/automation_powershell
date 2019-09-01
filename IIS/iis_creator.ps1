#habilitar ejecucion de srcitps, abrir una consola de powersheel y ejecutar "Set-ExecutionPolicy Unrestricted"
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe C:\PowerShell\backup_ca.ps1

#limpiando
cls

$disc="C:"

#ruta del 
$root = "$disc\IIS"

$site= Read-Host 'Escriba el nombre del site a crear'

#verfica que la carpeta exista 
$RootExists = Test-Path $root 

If ($RootExists -eq $True)
	{
	echo "existe la carpeta $root"
	
	#ruta
	$folder = "$root\$site"
	
	#verifica si existe el site
	$FolderExists = Test-Path $folder
	
	If ($FoldertExists -eq $True)
		{
		echo "existe el site, no se hace nada"
		}
	else
		{
		echo "no existe el site"
		
		echo "creo la carpeta $root\$site"
		mkdir $root\$site
		echo "creo la carpeta $root\$site\public"
		mkdir $root\$site\public
		echo "creo la carpeta $root\$site\log"
		mkdir $root\$site\log
		echo "creo la carpeta $root\$site\config"
		mkdir $root\$site\config
		
		echo "creo el site $site en iis"
		C:\Windows\System32\inetsrv\appcmd.exe add site /name:$site /id:2 /physicalPath:$root\$site\public /bindings:http/*:80:$site
		
		echo "creo el app-pool"
		C:\Windows\System32\inetsrv\appcmd.exe add apppool /name:$site /managedRuntimeVersion:v4.0
		
		echo "asigno el app-pool"
		C:\Windows\System32\inetsrv\appcmd.exe set app "$site/" /applicationpool:$site
		
		echo "configura log folder"
		c:\windows\system32\inetsrv\appcmd.exe set config -section:$site -siteDefaults.logfile.directory:$root\$site\log
		
		}
	}
else
	{
	echo "no existe la carpeta $root"
	
	echo "creo la carpeta $root"
	#mkdir $root
	
	}
		