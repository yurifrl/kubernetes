#!/bin/bash

kubectl () {
  docker run --rm -it -w /current \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/.ssh:/.ssh \
    -v $(pwd):/current \
    -v gcloud-data:/.config \
    -v gcloud-data:/.kube \
    -v gcloud-data:/.kubecfg \
    -p 10443:443 \
    -p 10080:80 \
    --name kubectl \
    yurifl/gcloud kubectl $@
}

NAME=$1
FILE_DEPLOY=$(cat ./config/deploy.json)
FILE_SECRETS=$(cat ./config/secrets.json)
FILE_SVC=$(cat ./config/svc.json)

echo $FILE_DEPLOY | sed -e "s/#NAME/$NAME/g" | cat > ./tmp/deploy.json
echo $FILE_SECRETS | sed -e "s/#NAME/$NAME/g" | cat > ./tmp/secrets.json
echo $FILE_SVC | sed -e "s/#NAME/$NAME/g" | cat > ./tmp/svc.json

kubectl apply -f ./tmp
