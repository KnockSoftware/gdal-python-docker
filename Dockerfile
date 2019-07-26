ARG PYTHON_DOCKER_TAG=3.7.3-stretch
FROM python:$PYTHON_DOCKER_TAG as base
MAINTAINER Evan Heidtmann <evan.heidtmann@gmail.com>
RUN apt-get update && \
        apt-get -y install \
        libgeos-3.5.1 \
        libgeos-c1v5 \
        libogdi3.2 \
        libproj12 \
        libfreexl1 \
        libspatialite7
RUN wget --quiet https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py

FROM base AS builder
ARG GDAL_VERSION=2.3.2
RUN apt-get update && \
    apt-get -y install \
        wget \
        libcurl4-openssl-dev \
        build-essential \
        libpq-dev \
        ogdi-bin \
        libogdi3.2-dev \
        libgeos-dev \
        libproj-dev \
        libpoppler-dev \
        libsqlite3-dev \
        libspatialite-dev \
        python3-dev \
        python3-numpy

RUN wget --quiet http://download.osgeo.org/gdal/$GDAL_VERSION/gdal-${GDAL_VERSION}.tar.gz -O /tmp/gdal-${GDAL_VERSION}.tar.gz && \
    tar -x -f /tmp/gdal-${GDAL_VERSION}.tar.gz -C /tmp

RUN cd /tmp/gdal-${GDAL_VERSION} && \
    ./configure \
        --disable-static \
        --prefix=/gdal/usr \
        --with-python \
        --with-geos \
        --with-sfcgal \
        --with-libtiff=internal \
        --with-geotiff=internal \
        --with-jpeg=internal \
        --with-jpeg12=internal \
        --with-png \
        --with-expat \
        --with-libkml \
        --with-openjpeg \
        --with-pg \
        --with-curl \
        --with-spatialite && \
    make -j $(nproc) && make install

FROM base
COPY --from=builder /gdal/usr/ /usr/
