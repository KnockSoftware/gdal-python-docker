ARG PYTHON_DOCKER_TAG=3.7.10-slim-buster
FROM python:$PYTHON_DOCKER_TAG as base
RUN apt-get update && \
	mkdir -p /usr/share/man/man1 /usr/share/man/man7 && \
        apt-get -y install --no-install-recommends postgresql-client=11+200+deb10u4 wget=1.20.1-1.1 libgdal20=2.4.0+dfsg-1+b1 build-essential=12.6 libpq-dev=11.10-0+deb10u1 mime-support=3.62 libssl1.1=1.1.1d-0+deb10u5 libzstd1=1.3.8+dfsg-3+deb10u1 openssl=1.1.1d-0+deb10u5 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
# https://www.debian.org/releases/stable/amd64/release-notes/ch-information.en.html#openssl-defaults
# TLDR: buster has tighter SSL requirements that AMZN hasn't met yet, allow a lower level:
RUN sed -i -E -e 's/^CipherString\s+=\s+DEFAULT@SECLEVEL=2$/CipherString = DEFAULT/' /usr/lib/ssl/openssl.cnf
