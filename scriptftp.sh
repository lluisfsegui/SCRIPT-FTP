#!/bin/bash

# Instal·lar el programari necessari directament
apt update && apt install lftp -y

# Donar permisos al propi fitxer de l'script
chmod +x "$0"
chmod 700 "$0"

# Dades de configuració
USUARI_LOCAL="el_teu_usuari"
SERVIDOR_FTP="ftp.elservidor.com"
USUARI_FTP="usuari_ftp"
PASS_FTP="contrasenya_ftp"

# Crear el fitxer comprimit del directori home
tar -czf /tmp/copia.tar.gz /home/$USUARI_LOCAL

# Pujar al servidor FTP
lftp -u $USUARI_FTP,$PASS_FTP $SERVIDOR_FTP <<EOF
put /tmp/copia.tar.gz
bye
EOF

# Esborrar el fitxer temporal creat
rm /tmp/copia.tar.gz