#!/bin/sh
#tags="3.4.9-stretch 3.5.6-stretch 3.6.7-stretch 3.7.3-stretch 2.7.16-stretch"
tags="3.7.3-stretch"
#tags="2.7.16-stretch"
#gdals="2.3.1 2.3.2"
gdals="2.3.2"

set -ex

for python_image_tag in $tags; do
  for gdal_version in $gdals; do
    TAG=$python_image_tag--gdal-$gdal_version
    docker build --build-arg "GDAL_VERSION=$gdal_version" --build-arg "PYTHON_DOCKER_TAG=$python_image_tag" -t ridereport/gdal-python:$TAG .
    docker push ridereport/gdal-python:$TAG
  done
done

# tag most recent version as latest
docker tag ridereport/gdal-python:$TAG ridereport/gdal-python:latest
docker push ridereport/gdal-python:latest
