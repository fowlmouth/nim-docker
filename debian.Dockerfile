FROM docker.io/library/debian:bookworm

RUN apt-get update \
  && apt-get install -y curl xz-utils gcc openssl ca-certificates git \
  && apt-get -y autoremove \
  && apt-get -y clean

ARG NIM_VERSION=2.0.0

RUN curl -v https://nim-lang.org/download/nim-$NIM_VERSION.tar.xz -o nim.tar.xz \
  && mkdir -p nim \
  && tar xJf nim.tar.xz --strip-components=1 -C nim \
  && rm nim.tar.xz \
  && cd nim \
  && sh build.sh \
  && ./bin/nim c koch \
  && ./koch nimble \
  && rm -rf c_code tests \
  && ln -svf `pwd`/bin/* /usr/bin/
