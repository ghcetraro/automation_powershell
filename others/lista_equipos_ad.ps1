#script que verifica las 4 ou de soporte tecnico nt y lista los equipos y el estado actual (up o down)

#limpia la pantalla
cls

#se fija donde esta parado
$dir=pwd

#borra el contenido de los archivos
echo "" > $dir\lista_equipos.txt
echo "" > $dir\lista_equipos_ou.txt

#lista de equipos por ou
dsquery * -limit 1000 "ou=Soporte Tecnico, ou=Servidores, ou=AYSA DESA, dc=aysa,dc=ad" >> $dir\lista_equipos_ou.txt
dsquery * -limit 1000 "ou=Soporte Tecnico, ou=Servidores, ou=AYSA PROD, dc=aysa,dc=ad" >> $dir\lista_equipos_ou.txt
dsquery * -limit 1000 "ou=Servidores Produccion, dc=aysa,dc=ad" >> $dir\lista_equipos_ou.txt
dsquery * -limit 1000 "ou=Servidores DESA, dc=aysa,dc=ad"  >> $dir\lista_equipos_ou.txt


#lista equipos filtrado
dsquery * -limit 1000 "ou=Soporte Tecnico, ou=Servidores, ou=AYSA DESA, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] } >> $dir\lista_equipos.txt
dsquery * -limit 1000 "ou=Soporte Tecnico, ou=Servidores, ou=AYSA PROD, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] } >> $dir\lista_equipos.txt
dsquery * -limit 1000 "ou=Servidores Produccion, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] } >> $dir\lista_equipos.txt
dsquery * -limit 1000 "ou=Servidores DESA, dc=aysa,dc=ad" | Select-String -Pattern "CN=" | %{($_ -split ",")[0] } | %{($_ -split "=")[1] } >> $dir\lista_equipos.txt

#Leer el contenido del fichero y almacenarlo en una variable
$listado=Get-Content $dir\lista_equipos.txt

#contador equipos
$contador_equipos=0

#linea en blanco valor null
$blancos=0

#variable de estado sesiones
$sesiones_activas=0

#lee linea por linea el archivo
foreach ( $equipo in $listado)
        {
        #omite ejecucion si encuentra # o / -- se usan como comentarios
        if ($equipo -like '*#*' -Or $equipo -like '*/*') {$blancos=0 } #termina if $equipo comentarios
        else
            {
            #verfica que el equipo no este en blanco
            if ($equipo)
                {
                echo "$contador_equipos $equipo"

                #aumenta la cuenta de los equipos ya chequeados
                $contador_equipos++

                #se verifica que el equipo este up
                if(!(Test-Connection -Cn $equipo -BufferSize 16 -Count 1 -ea 0 -quiet))
                    {
                    echo "equipo down"
                    echo "equipo $equipo no responde" >> $dir\equipos_no_responden.txt
                    }
                else
                    {
                    echo "equipo up"
                    } #end if
                }
            }
        }




