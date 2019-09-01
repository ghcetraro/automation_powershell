#Sistema de Backup Cetraro

#busca la fecha del dia
$date = Get-Date -Format yyyy.MMMM.d

#se acumula el directorio old
$dirold="E:\BACKUP_SHAREPOINT\OLD"
#acumula el directorio definitivo a cinta
$dircinta = "E:\BACKUP_SHAREPOINT\CINTA"

#acumula el nuevo directorio a crear
$backup = "$dircinta\$date"

#borrar contenido viejo de la carpeta E:\BACKUP_SHAREPOINT\OLD
echo "se borran los archivos viejos de la carpeta old $dirold"
remove-item $dirold\* -force -recurse

#se mueve el contenido de E:\BACKUP_SHAREPOINT\CINTA a E:\BACKUP_SHAREPOINT\OLD
echo "se copian las archivos al directorio viejo $dirold"    	
Move-Item $dircinta\* -destination $dirold

#borrar contenido viejo de la carpeta E:\BACKUP_SHAREPOINT\cinta
echo "se borran los archivos viejos de la carpeta cinta $dircinta"
remove-item $dircinta\* -force -recurse

echo "espera 20 segundos para que cirre correctamente la copia anterior"
Start-Sleep -s 20

#se crea la variable verificadora
$path = test-Path $backup

#revisa si el directorio de backup del dia de hoy existe
if ($path -eq $true) { echo "el directorio $backup existe " }
else { echo "el directorio $backup no existe, se creara el mismo" 
#crear el nuevo directorio 
    mkdir $backup } 

    #busca las url del site de sharepoint y las filtra
    Add-PSSnapin Microsoft.SharePoint.PowerShell
    Get-SPsite | foreach{

    #se guarda las urls una por una
    $sitio=$_.Url
    #se convierten la url string manejable para crear archivos
    $Encode = [System.Web.HttpUtility]::UrlEncode($sitio)

    #echo $Encode

    #se crea el nombre del archivo con su url
    $file = "$backup\$Encode.bak"
    echo $file

    #se crea la variable verificadora
    $filet = test-Path $file

    #se verifica que exista el archivo de url antes de volver a crearlo
     if ( $filet -eq $true ) { echo "el archivo $file ya existe" }

     #se baja y crea el nuevo archivo de back por url
     else  { echo "el archivo $file no existe, se realizara su backup"
            Backup-SPSite -Identity $sitio -Path $backup\$Encode.bak
            }

}





















