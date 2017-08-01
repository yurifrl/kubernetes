#!/bin/bash

# Use deploy directory as working directory
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
cd "$parent_path"

dg() {
  docker run --rm -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    --volumes-from gcloud-config yurifl/gcloud $@
}

# dg gcloud compute disks create --size=200GB --zone=us-east1-d taiga-pg-disk
# dg gcloud compute disks create --size=200GB --zone=us-east1-d taiga-media-disk
# dg gcloud compute disks create --size=200GB --zone=us-east1-d taiga-static-disk
# dg gcloud compute disks list

dg kubectl create -f ./kube/database-svc.yaml
dg kubectl create -f ./kube/taiga-back-svc.yaml
dg kubectl create -f ./kube/taiga-front-svc.yaml

dg kubectl create -f ./kube/database-rc.yaml
dg kubectl create -f ./kube/taiga-back-rc.yaml
dg kubectl create -f ./kube/taiga-front-rc.yaml

dg kubectl get svc
dg kubectl get rc
dg kubectl get po

