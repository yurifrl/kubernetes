#!/bin/bash

# Use deploy directory as working directory
parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
cd "$parent_path"

VERSION=$(cat ../VERSION)

dg() {
  docker run --rm -ti -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    --volumes-from gcloud-config yurifl/gcloud $@
}

create_disks() {
  dg gcloud compute disks create --size=200GB --zone=us-east1-d kafka-disk
}

delete_disks() {
  dg gcloud compute disks delete kafka-disk
}

create_kafka() {
  dg kubectl create -f ./kafka-rc.yaml
  dg kubectl create -f ./kafka-svc.yaml
}

delete_kafka() {
  dg kubectl delete -f ./kafka-rc.yaml
  dg kubectl delete -f ./kafka-svc.yaml
}

create_zookeeper() {
  dg kubectl create -f ./zookeeper-rc.yaml
  dg kubectl create -f ./zookeeper-svc.yaml
}

delete_zookeeper() {
  dg kubectl delete -f ./zookeeper-rc.yaml
  dg kubectl delete -f ./zookeeper-svc.yaml
}

list() {
  echo "get svc"
  dg kubectl get svc
  echo "get rc"
  dg kubectl get rc
  echo "get pods"
  dg kubectl get po
}

list_disks() {
  dg gcloud compute disks list
}

# update() {
#   echo "dg kubectl rolling-update hackathon-core-web --image=\"yurifl/hackathon-core-web:$VERSION\""
# }

# push(){
#   docker-compose -f ../production.yml build
#   docker tag hackathon-core-web "yurifl/hackathon-core-web:$VERSION"
#   docker tag hackathon-core-web "yurifl/hackathon-core-web:latest"
#   dg gcloud docker push "yurifl/hackathon-core-web:$VERSION"
#   dg gcloud docker push "yurifl/hackathon-core-web:latest"
# }

# deploy() {
#   vim ../VERSION
#   docker-compose -f ../production.yml build
#   docker tag hackathon-core-web "yurifl/hackathon-core-web:$VERSION"
#   docker tag hackathon-core-web "yurifl/hackathon-core-web:latest"
#   dg gcloud docker push "yurifl/hackathon-core-web:$VERSION"
#   dg gcloud docker push "yurifl/hackathon-core-web:latest"
#   echo "dg kubectl rolling-update hackathon-core-web --image=\"yurifl/hackathon-core-web:$VERSION\""
# }

continue() {
  read -p "Press [Enter] key to continue..." key
}

while :
do
  clear
  echo "---------------------------------"
  echo "       M A I N - M E N U"
  echo "---------------------------------"
  echo '1. create disks'
  echo '2. delete disks'
  echo '3. create kafka svc, rc, po'
  echo '4. delete kafka svc, rc, po'
  echo '5. create zookeeper svc, rc, po'
  echo '6. delete zookeeper svc, rc, po'
  echo '7. list svc, rc'
  echo '8. list disks'
  echo '0. exit'
  echo "---------------------------------"
  read -r -p "Enter your choice: " option
  case ${option} in
    1) create_disks
      continue;;
    2) delete_disks
      continue;;
    3) create_kafka
      continue;;
    4) delete_kafka
      continue;;
    5) create_zookeeper
      continue;;
    6) delete_zookeeper
      continue;;
    7) list
      continue;;
    8) list_disks
      continue;;
    0) break;;
  esac
done

