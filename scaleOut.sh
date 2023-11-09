#!/bin/bash
# Script para crear un Nanode y agregarlo a un NodeBalancer usando LinodeCLI

echo "===== Agregar Nanodes ====="

echo "1. Crear Nanode"
# Definir una etiqueta aleatoria para el Nanode
LABEL="nginx-$(cat /proc/sys/kernel/random/uuid | head -c 25)"
# Crear Nanode
lin linodes create --root_pass $(openssl rand --base64 32) --tags khw,autoscale --private_ip true --label $LABEL


echo "2. Agregar al NodeBalancer"
NBID={Id del NodeBalancer}
CFGID={Id de la configuracion}
INTERNAL_IP=$(lin linodes ls --format label,ipv4 --text --delimiter ' ' | grep ${LABEL} | cut -f 3 -d ' ')

# Agregar el Nanode a la configuración del NodeBalancer
lin nodebalancers node-create --address $INTERNAL_IP:1234 --label $LABEL $NBID $CFGID


