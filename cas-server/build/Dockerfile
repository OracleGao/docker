FROM openjdk:8u111-jre
MAINTAINER gaojingzhe1983@126.com

USER root

COPY etc/cas /etc/cas

RUN mkdir -p /cas
WORKDIR /cas

COPY cas.war .
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8443

ARG buildtime
ARG builder
LABEL buildtime=${buildtime} \
      builder=${builder}

