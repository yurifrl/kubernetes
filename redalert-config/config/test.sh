#!/bin/bash

docker run --rm \
  -p 8888:8888 \
  -p 8889:8889 \
  -v $(pwd)/config.json:/config.json \
  jonog/redalert
