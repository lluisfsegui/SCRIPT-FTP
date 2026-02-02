#!/bin/bash

USUARIO="usuario1"
HOME_DIR="/home/$USUARIO"

FECHA=$(date +"%Y-%m-%d_%H-%M")
BACKUP_FILE="/tmp/${USUARIO}_backup_${FECHA}.tar.gz"

FTP_SERVER="10.18.30.162"
FTP_USER="usuario_backup"
FTP_PASS="12345678"
FTP_DIR="ftp_backups"

tar -czf "$BACKUP_FILE" "$HOME_DIR"

ftp -inv $FTP_SERVER <<EOF
user $FTP_USER $FTP_PASS
cd $FTP_DIR
put $BACKUP_FILE $(basename $BACKUP_FILE)
bye
EOF

rm "$BACKUP_FILE"

echo "Backup completado correctamente."







