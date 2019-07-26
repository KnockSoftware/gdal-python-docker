ARG PYTHON_DOCKER_TAG=3.7.4-slim-buster
FROM python:$PYTHON_DOCKER_TAG as base
MAINTAINER Evan Heidtmann <evan.heidtmann@gmail.com>
RUN apt-get update && \
	mkdir -p /usr/share/man/man1 /usr/share/man/man7 && \
        apt-get -y install postgresql-client wget libgdal20 build-essential libpq-dev
# https://www.debian.org/releases/stable/amd64/release-notes/ch-information.en.html#openssl-defaults
# TLDR: buster has tighter SSL requirements that AMZN hasn't met yet, allow a lower level:
RUN sed -i -E -e 's/^CipherString\s+=\s+DEFAULT@SECLEVEL=2$/CipherString = DEFAULT/' /usr/lib/ssl/openssl.cnf
RUN pip3 install pipenv
