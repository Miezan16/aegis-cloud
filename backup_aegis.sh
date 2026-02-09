#!/bin/bash
DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/home/ubuntu/backups"

# Backup konfigurasi Kubernetes
kubectl get all --all-namespaces -o yaml > $BACKUP_DIR/k8s_backup_$DATE.yaml

# Upload ke Cloud via Rclone
rclone copy $BACKUP_DIR/k8s_backup_$DATE.yaml mycloud:AegisBackups

# Hapus file lokal yang sudah tua (lebih dari 7 hari)
find $BACKUP_DIR -mtime +7 -delete