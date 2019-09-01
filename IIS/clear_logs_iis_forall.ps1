#habilitar ejecucion de srcitps, abrir una consola de powersheel y ejecutar "Set-ExecutionPolicy Unrestricted"
#C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe C:\PowerShell\backup_ca.ps1

#limpiando
cls

#ruta de los logs
$root = "E:\IIS"

#verfica que la carpeta exista 
$FolderAExists = Test-Path $root 

If ($FolderAExists -eq $True)
	{
	#filtra los nombres de las carpetas
	$dir = Get-ChildItem $root -Name

	foreach ( $site in $dir)
		{
		$folder = "$root\$site\log"
		#echo "limpiando carpeta $folder"
		#echo $folder
    
		#fecha desde la cual se borra
		$limit = (Get-Date).AddDays(-5)
    
		#verfica que la carpeta exista 
		$FolderBExists = Test-Path $folder 
    
		If ($FolderBExists -eq $True)
			{
			echo "se borra la carpeta $folder"
			Get-ChildItem $folder -Recurse | ? {  -not $_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item
			}#end ifB
		else
			{
			echo "el directorio $folder no existe"
			}
		}#end forearch
	}#end ifA
else
	{
	echo "el directorio $root no existe"
	}#end else

#salir
exit