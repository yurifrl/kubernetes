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

# dg gcloud compute disks delete taiga-disk
# dg gcloud compute disks list

dg kubectl delete -f ./kube/database-svc.yaml
dg kubectl delete -f ./kube/taiga-back-svc.yaml
dg kubectl delete -f ./kube/taiga-front-svc.yaml

dg kubectl delete -f ./kube/database-rc.yaml
dg kubectl delete -f ./kube/taiga-back-rc.yaml
dg kubectl delete -f ./kube/taiga-front-rc.yaml

dg kubectl get svc
dg kubectl get rc
dg kubectl get po

