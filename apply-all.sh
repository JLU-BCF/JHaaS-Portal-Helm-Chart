#!/bin/bash

# abort if any error occours
set -e

# Set working directory properly
cd "$(dirname $0)"
WORKDIR="$(pwd)"

CREDS="../registry-credentials.yml"
if [ -f "$CREDS" ]; then
  kubectl apply -f "$CREDS"
else
  echo ; echo -e "\e[1;91m -- Please set registry credentials properly -- \e[0m" ; echo
  exit
fi

DIRS="namespaces accounts roles bindings environments secrets volumes deployments services ingresses"

for DIR in $DIRS; do
  kubectl apply -f "$DIR"
done
