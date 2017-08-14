FROM python:3.6.2-alpine

LABEL maintainer "meganii <yuhei24@gmail.com>"

ADD mecab-0.996.tar.gz /tmp
ADD mecab-ipadic-2.7.0-20070801.tar.gz /tmp

RUN apk add --no-cache build-base && \
    # Install mecab
    cd /tmp/mecab-0.996 && \
        ./configure && \
        make && \
        make check && \
        make install && \
    cd / && \
    rm -rf /tmp/mecab-0.996 && \
    # Install ipadic
    cd /tmp/mecab-ipadic-2.7.0-20070801 && \
       ./configure && \
       make && \
       make check && \
       make install && \
    cd / && \
    rm -rf /tmp/mecab-ipadic-2.7.0-20070801 && \
    pip install mecab-python3
