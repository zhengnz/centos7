#base image
FROM centos:7

#author
MAINTAINER Norman 332535694@qq.com

WORKDIR /
ADD https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz Python-2.7.11.tgz
COPY get-pip.py get-pip.py
RUN yum install -y zlib-devel && \
    yum -y install wget unzip tar zlib-devel bzip2 bzip2-devel libjpeg-devel libpng-devel && \
    yum -y install xz openssl openssl-devel gcc gcc-c++ cmake git && \
    tar -zxvf Python-2.7.11.tgz
WORKDIR /Python-2.7.11
RUN ./configure CFLAGS=-fPIC && make all && make install && make clean && make distclean
WORKDIR /
RUN python get-pip.py && \
    pip install supervisor && \
    echo_supervisord_conf > /etc/supervisord.conf && \
    echo "[include]" >> /etc/supervisord.conf
RUN rm -rf Python-2.7.11 && rm -f Python-2.7.11.tgz