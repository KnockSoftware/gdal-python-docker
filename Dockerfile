ARG PYTHON_DOCKER_TAG=3.9.2-slim-buster
FROM python:$PYTHON_DOCKER_TAG as base
RUN apt-get update && \
	apt-get -y upgrade && \
	mkdir -p /usr/share/man/man1 /usr/share/man/man7 && \
        apt-get -y install --no-install-recommends postgresql-client wget libgdal20 build-essential libpq-dev mime-support libssl1.1 libzstd1 openssl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
# https://www.debian.org/releases/stable/amd64/release-notes/ch-information.en.html#openssl-defaults
# TLDR: buster has tighter SSL requirements that AMZN hasn't met yet, allow a lower level:
RUN sed -i -E -e 's/^CipherString\s+=\s+DEFAULT@SECLEVEL=2$/CipherString = DEFAULT/' /usr/lib/ssl/openssl.cnf
