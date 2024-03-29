FROM alpine

RUN apk update
RUN apk upgrade
RUN apk --update add wget curl bash unzip python php5-common php5 php5-mysql php5-cli php5-cgi openssh-client openssl ca-certificates

# http://get.docker.com/builds/Linux/x86_64/docker-1.12.3.tgz
ENV COMPACT_DOCKER ./vendor/docker-1.12.3.tgz
# http://github.com/docker/machine/releases/download/v0.8.2/docker-machine-Linux-x86_64
ENV COMPACT_DOCKER_MACHINE ./vendor/docker-machine-Linux-x86_64
# https://github.com/fabric8io/gofabric8/releases/download/v0.4.64/gofabric8-linux-amd64
ENV COMPACT_GOFABRIC8 ./vendor/gofabric8-linux-amd64
# https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip
ENV COMPACT_GOOGLE_CLOUD ./vendor/google-cloud-sdk.zip

# ============================================================================
ENV HOME /
WORKDIR $HOME
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
# Install the Google Cloud SDK.
ADD $COMPACT_GOOGLE_CLOUD /tmp/google-cloud-sdk.zip
RUN unzip /tmp/google-cloud-sdk.zip -d / && rm /tmp/google-cloud-sdk.zip
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --additional-components app-engine-python app kubectl alpha beta gcd-emulator pubsub-emulator cloud-datastore-emulator app-engine-go bigtable

# Disable updater check for the whole installation.
# Users won't be bugged with notifications to update to the latest version of
# gcloud.
RUN google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

# Disable updater completely.
# Running `gcloud components update` doesn't really do anything in a union FS.
# Changes are lost on a subsequent run.
RUN sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' /google-cloud-sdk/lib/googlecloudsdk/core/config.json

# RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
# RUN cp google-cloud-sdk/bin/{dev_appserver.py,gcloud,gsutil,bq,endpointscfg.py,git-credential-gcloud.sh,kubectl} /usr/local/bin/

# ============================================================================
# Download docker
ADD $COMPACT_DOCKER /tmp/docker
RUN cp /tmp/docker/docker/docker /usr/local/bin
RUN rm -rf /tmp/docker

# Download docker machine
ADD $COMPACT_DOCKER_MACHINE /bin/docker-machine
RUN chmod +x /bin/docker-machine

# ============================================================================
ADD $COMPACT_GOFABRIC8 /usr/local/bin/gofabric8
RUN chmod +x /usr/local/bin/gofabric8
RUN y | gofabric8

# Clean up
RUN apk del wget curl unzip bash

# ENTRYPOINT ["gofabric8"]
# CMD ["gofabric8"]
VOLUME ["/.config", "/.kube", "/.kubecfg", "/.ssh"]
CMD ["/bin/sh"]
