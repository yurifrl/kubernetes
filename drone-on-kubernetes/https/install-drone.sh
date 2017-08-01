#!/bin/bash
# kubectl create ns jenkins
# --namespace=jenkins

echo " dg kubectl set image deployment/drone-server nginx-proxy=yurifl/nginx-for-drone:latest"

kubectl delete -f drone-configmap.yaml

kubectl apply -f secrets.yaml
kubectl apply -f drone-configmap.yaml

kubectl apply -f drone-agent-deploy.yaml
kubectl apply -f drone-server-deploy.yaml
kubectl apply -f drone-server-svc.yaml

kubectl get secrets
kubectl get cm
kubectl get po
kubectl get deploy
kubectl get svc
