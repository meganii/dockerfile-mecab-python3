FROM python:3.6.2-alpine3.6
MAINTAINER "meganii <yuhei24@gmail.com>"

RUN apk add --update --no-cache build-base

ENV build_deps 'curl git bash file sudo openssh'
ENV dependencies 'openssl'

ADD mecab-0.996.tar.gz /tmp
ADD mecab-ipadic-2.7.0-20070801.tar.gz /tmp

RUN apk add --no-cache ${build_deps} && \
    apk add --no-cache ${dependencies} && \
    # Install mecab
    cd /tmp/mecab-0.996 && \
        ./configure --with-charset=utf8 && \
        make && \
        make check && \
        make install && \
    cd / && \
    rm -rf /tmp/mecab-0.996 && \
    # Install ipadic
    cd /tmp/mecab-ipadic-2.7.0-20070801 && \
       ./configure --with-charset=utf8 && \
       make && \
       make check && \
       make install && \
    cd / && \
    rm -rf /tmp/mecab-ipadic-2.7.0-20070801 && \
    # Install Neologd
    cd /tmp && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y && \
    pip install mecab-python3

CMD ["mecab", "-d", "/usr/local/lib/mecab/dic/mecab-ipadic-neologd"]
