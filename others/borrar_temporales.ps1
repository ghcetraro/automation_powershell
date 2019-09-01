#borrar todos los archivos temporales del equipo por la noche para que no llenen el disco

#directorio
$dir="E:\temp"

#se crea la variable verificadora
$path = test-Path $dir

#se verifica si el directorio existe
if ($path)
	{
	remove-item $dir\* -force -recurse
	echo "se borro el contenido que no esta siendo utilizado en este momento"
	}
else
	{
	echo "no existe el directorio"
	}
