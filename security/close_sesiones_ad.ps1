#limpia la pantalla
cls

#se fija donde esta parado
$dir=pwd

#usuario de la consulta
$contador_equipos=0
$reintentos=0

#variables
$choise02=0
$choise03=0
$choise04=0
$choise05=0

$loop_count=1
$ous=1

echo '- Cerrar sesiones en las ous -'
echo '-- 1-Cerrar en la ou AYSA DESA'
echo '-- 2-Cerrar en la ou AYSA PROD'
echo '-- 3-Cerrar en la ou Servidores DESA'
echo '-- 4-Cerrar en la ou Servidores Produccion'
echo '-- 9-Salir'

$option= Read-Host 'Elija una opción'

$usuario= Read-Host 'Coloque el usuario'

if ($option -eq 1)
	{
	#lista equipos filtrado
	$listado=dsquery * -limit 1000 "ou=Soporte Tecnico, ou=Servidores, ou=AYSA DESA, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] } 
	}

if ($option -eq 2)
	{
	#lista equipos filtrado
	$listado=dsquery * -limit 1000 "ou=Soporte Tecnico, ou=Servidores, ou=AYSA PROD, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] }
	}

if ($option -eq 3)
	{
	#lista equipos filtrado
	$listado=dsquery * -limit 1000 "ou=Servidores DESA, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] }
	}

if ($option -eq 4)
	{
	#lista equipos filtrado
	$listado=dsquery * -limit 1000 "ou=Servidores Produccion, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] }
	}


#lee linea por linea el archivo
foreach ( $equipo in $listado)
	{
	#verfica que el equipo no este en blanco
	if ($equipo)
		{
		echo "$contador_equipos $equipo"
		
		#aumenta la cuenta de los equipos ya chequeados
		$contador_equipos++
		$reintentos=0
		
		while($reintentos -ne 3)
			{ 
			#se verifica que el usuario este logeado en el equipo
			$userdata= query session /server:$equipo | Select-String -Pattern $usuario
	
			#si existe el usuario se sigue filtrando
			if ($userdata)
				{
				#segundo filtrado ver si la sesion esta activa o desconectada
				$useraction= echo $userdata | Select-String -Pattern Activo
		
				#se verifica si la sesion es activa o desconectada
				if ($useraction) { $userid = echo $userdata | %{($_ -split "\s+")[3] } } #termina $useraction
							
				#se verifica el id del usuario de sesion
				else { $userid = echo $userdata | %{($_ -split "\s+")[2] } } #termina $useraction
                                     
				#si el usuario que se verifica esta se ejecuta el cierre de sesion
				if ($userid) 
					{
					echo ' '
					echo "se encontro el usuario $usuario <<<<<"
					echo "Intento Numero $reintentos" 
					echo "se procede a cerrar la sesion del usuario $usuario con el id $userid"
					echo ' '													
					#cuenta las sesiones activas que habia
					$sesiones_activas++
			    	            
					#matar sesion del usuario en el equipo
					reset session $userid /server:$equipo
					$reintentos++
					
					#espera unos segundos antes de reintentar
					Start-Sleep -s 6
									
					} #termina if $userid
				else 
					{ 
					echo "no se encontro el usuario $usuario"
					$reintentos=3
					}
				} 
				
			#se usa para ver si se cerro la sesion sino se vuelve a intentar, si no se logra al 3 intento se tira erro y sigue con otra
			if ($reintentos -gt 3) 
				{ 
				'hay un problema con la sesion que no se puede cerrar' 
				} 
											
			else	
				{
				echo "no se encontro el usuario $usuario"
				$reintentos=3
				} #termina else $userdata        
			} #end while 
		} #end if
	} #end foreach
		
    echo "fin de script"