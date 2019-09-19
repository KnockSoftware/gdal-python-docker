#!/bin/sh
tags="3.7.4-buster"
repo=518982846871.dkr.ecr.us-west-2.amazonaws.com/gdal-python

set -ex

for python_image_tag in "$tags"; do
  tag=$python_image_tag-$(date +%Y%m%d)
  docker build -t ${repo}:${tag} .
  docker push ${repo}:${tag}
done

# tag most recent version as latest
docker tag ${repo}:$tag ${repo}:latest
docker push ${repo}:latest
