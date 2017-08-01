#!/bin/bash

#
set -e

# cd to script folder
cd $( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )

#
ZONE=us-east1-d

#
dg() {
  docker run --rm -it -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    -v gcloud-data:/.config \
    -v gcloud-data:/.kube \
    -v gcloud-data:/.kubecfg \
    --name dg \
    yurifl/gcloud $@
}

#
echo "kubectl delete -f ./config/"
echo "kubectl apply -f ./config/"
