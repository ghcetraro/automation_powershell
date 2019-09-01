#sen mail for smtp

$remitente="tete@tete.com.ar"
$destinatario="pepe@pepe.com.ar"
$asunto="correo de error"

$servidor="mxaasa.aysa.ad"

#directorio de archivo a levantar
$mensaje= cat E:\log\log.txt

Send-MailMessage –From $remitente –To $destinatario –Subject $asunto –Body $mensaje -SmtpServer $servidor

exit 0