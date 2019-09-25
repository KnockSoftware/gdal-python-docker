#!/bin/sh
set -ex
repo=518982846871.dkr.ecr.us-west-2.amazonaws.com/gdal-python
tag=$(date +%Y%m%d)
docker build -t ${repo}:${tag} .
docker push ${repo}:${tag}
