include ./ridereport-common/Makefile-Common.mk
IMAGE=gdal-python
APP=gdal-python

BULLSEYE_REPO=python
BULLSEYE_TAG=3.9.5-slim-bullseye

.PHONY: set-bullseye-build-args bullseye-release

set-bullseye-build-args:
	$(eval DOCKER_BUILD_ARGS := --build-arg PYTHON_DOCKER_TAG=${BULLSEYE_TAG} --build-arg REPO=${BULLSEYE_REPO})

build-bullseye-python:
	docker build -t ${BULLSEYE_REPO}:${BULLSEYE_TAG} -f ./Dockerfile-bullseye-slim .

docker-build: build-bullseye-python set-bullseye-build-args
