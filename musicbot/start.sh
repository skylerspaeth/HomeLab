#!/bin/bash

quit() { echo "$1"; exit 1; }

if [[ -z "$1" ]]; then quit "Missing version argument '$(basename "$0") x.x.x'"; fi
if [[ -z "$JMB_TOKEN" ]]; then quit "Missing JMB_TOKEN variable."; fi
if [[ -z "$JMB_OWNER" ]]; then quit "Missing JMB_OWNER variable."; fi
if [[ -z "$JMB_PREFIX" ]]; then quit "Missing JMB_PREFIX variable."; fi
if [[ -z "$JMB_GAME" ]]; then quit "Missing JMB_GAME variable."; fi

# Generate config file at runtime from k8s-provided env vars
cat << EOF > config.txt
token = $JMB_TOKEN
owner = $JMB_OWNER
prefix = "$JMB_PREFIX"
game = "$JMB_GAME"
EOF

echo "Starting music bot..."
java -Dnogui=true -jar JMusicBot-$1.jar
