#!/bin/sh
tags="3.7.4-buster"

set -ex

for python_image_tag in "$tags"; do
  TAG=$python_image_tag-$(date +%Y%m%d)
  docker build --build-arg "PYTHON_DOCKER_TAG=$python_image_tag" -t ridereport/gdal-python:$TAG .
  docker push ridereport/gdal-python:$TAG
done

# tag most recent version as latest
docker tag ridereport/gdal-python:$TAG ridereport/gdal-python:latest
docker push ridereport/gdal-python:latest
