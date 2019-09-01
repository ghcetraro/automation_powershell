#Sistema de Backup Cetraro

$date = Get-Date -Format d.MMMM.yyyy
$dir = "E:\WEB"
$dirbackup = "E:\BACKUP"

$backup = "$dirbackup\$date"
$path = test-Path $backup


#revisa si el directorio de backup del dia de hoy existe
if ($path -eq $true) {

echo "el directorio $backup existe "

$pathmoodle = "$backup\moodle"
#echo "$pathmoodle"
$moodle = test-Path $pathmoodle
#echo "$pathend"


    #revisa si el backup del moodle del dia de hoy existe
    if ( $moodle -eq $true ) { echo "ya se realizo el backup del directorio $pathmoodle" }
    else { echo "no existe el backup del directorio $pathmoodle"
   
    echo "se realiza el backup del directorio $pathmoodle"
    cp -r $dir\moodle $backup
   
    }
   
    $pathmoodledata = "$backup\moodledata"
    #echo "$pathmoodledata"
    $moodledata = test-Path $pathmoodledata
    #echo "$moodledata"   
   
    #revisa si el backup del moodledata del dia de hoy existe
    if ( $moodledata -eq $true ) { echo "ya se realiza el backup del directorio $pathmoodledata" }
    else { echo "no existe el backup del directorio $pathmoodledata"
   
    echo "se realiza el backup del directorio $pathmoodledata"
    cp -r $dir\moodledata $backup
   
     }

}

else

{

    $dirbackuppp = test-Path $dirbackup
   
    #se verifica si el directorio E:\BAKCUP existe
    if ( $dirbackuppp -eq $true ) {

    echo "el directorio $dirbackup existe"
    echo "el directorio $backup no existe "

    echo "se crea la carpeta $backup para realizar el backup"
    mkdir $backup

    echo "se reliaza el backup del directorio moodle y moodledata"
    cp -r $dir\moodle $backup
    cp -r $dir\moodledata $backup

    }


    else {

    echo "el directorio $dirbackup no existe"

    echo "se crea el directorio $dirbackup"
    mkdir $dirbackup

    echo "se crea la carpeta $backup para realizar el backup"
    mkdir $backup

    echo "se reliaza el backup del directorio moodle y moodledata"
    cp -r $dir\moodle $backup
    cp -r $dir\moodledata $backup

    }


}