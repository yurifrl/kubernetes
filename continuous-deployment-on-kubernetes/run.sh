#!/bin/bash


# PASSWORD=`openssl rand -base64 15`; echo "Your password is $PASSWORD"; sed -i.bak s#CHANGE_ME#$PASSWORD# jenkins/k8s/options
# password: 3DFgMK2AoamZv2HDI6mF

# gcloud compute images create jenkins-home-image --source-uri https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home-v2.tar.gz
# gcloud compute disks create jenkins-home --image jenkins-home-image
# gcloud compute disks delete jenkins-home

# kubectl create -f ./object-counts.yaml --namespace=jenkins --validate=false
# kubectl create -f ./compute-resources.yaml --namespace=jenkins --validate=false

# kubectl get nodes
# kubectl label nodes gke-jenkins-cd-default-pool-f799192b-4p5k kind=jenkins

# gcloud container clusters create jenkins-cd \
#   --num-nodes 3 \
#   --scopes "https://www.googleapis.com/auth/projecthosting,storage-rw"

gcloud container clusters get-credentials jenkins-cd
kubectl create ns jenkins

kubectl create secret generic jenkins --from-file=jenkins/k8s/options --namespace=jenkins
kubectl apply -f jenkins/k8s/
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=jenkins/O=jenkins"
kubectl create secret generic tls --from-file=/tmp/tls.crt --from-file=/tmp/tls.key --namespace jenkins
kubectl apply -f jenkins/k8s/lb

kubectl get ingress --namespace jenkins
kubectl get pods --namespace jenkins
kubectl get svc --namespace jenkins
kubectl describe ingress jenkins --namespace jenkins
