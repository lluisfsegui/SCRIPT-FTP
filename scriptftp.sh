#!/bin/bash
USER_HOME="/root"          # Directori home de l'usuari
BACKUP_DIR="/tmp/backups"            # Directori temporal per guardar la còpia
FTP_SERVER="192.168.144.197"         # Adreça del servidor FTP
FTP_USER="root"                # Nom d'usuari del servidor FTP
FTP_PASSWORD="12345678"       # Contrasenya del servidor FTP
BACKUP_NAME="$FTP_USER-backup_$(date +%Y%m%d).tar.gz"  # Nom del fitxer de còpia amb la data actual
FTP_TARGET_DIR="backups"            # Directori al servidor FTP on es pujarà la còpia

# Crear el directori de còpies si no existeix
mkdir -p "$BACKUP_DIR"
echo "Directori creat correctament"

# Comprimir el directori home
echo "Compressió del directori $USER_HOME..."
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$USER_HOME"
check_error "No s'ha pogut comprimir el directori: $USER_HOME"

echo "Compressió completada: $BACKUP_DIR/$BACKUP_NAME"

# Pujar el fitxer al servidor FTP
echo "Connectant amb el servidor FTP i pujant la còpia de seguretat..."
ftp -inv "$FTP_SERVER" <<EOF
    user $FTP_USER $FTP_PASSWORD
    mkdir $FTP_TARGET_DIR
    cd $FTP_TARGET_DIR
    put $BACKUP_DIR/$BACKUP_NAME $BACKUP_NAME
    bye
EOF
check_error "No s'ha pogut pujar el fitxer al servidor FTP."

echo "Còpia de seguretat pujada correctament al servidor FTP."
echo "Procés completat."







