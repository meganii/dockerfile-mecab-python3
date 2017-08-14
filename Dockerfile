FROM python:3.6.2-alpine

LABEL maintainer "meganii <yuhei24@gmail.com>"

ADD mecab-0.996.tar.gz /tmp

RUN apk add --no-cache build-base && \
    cd /tmp/mecab-0.996 && \
        ./configure && \
        make && \
        make check && \
        make install && \
    cd / && \
    rm -rf /tmp/mecab-0.996 && \
    pip install mecab-python3==0.996
