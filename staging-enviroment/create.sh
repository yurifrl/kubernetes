#!/bin/bash

echo "dg kubectl create secret generic tls-development-certs --from-file=./tls"
echo "dg kubectl get secrets tls-development-certs -o yaml >> secrets.yml"
echo "dg kubectl apply -f ./config/"

