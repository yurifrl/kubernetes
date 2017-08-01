#!/bin/sh

docker run --rm -it -w /current \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/.ssh:/.ssh \
  -v $(pwd):/current \
  --volumes-from gcloud-config yurifl/gofabric8 $@

