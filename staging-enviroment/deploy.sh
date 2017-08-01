#!/bin/bash

VERSION=latest

echo "docker run --rm -ti -p 80:80 -p 443:443 yurifl/development:v$VERSION"
echo "dg kubectl set image deployment/development development=yurifl/development:$VERSION"
