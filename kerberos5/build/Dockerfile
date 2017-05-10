FROM ubuntu:14.04.2
MAINTAINER oraclegao@126.com

USER root

RUN apt-get update && apt-get install -y \
wget \
gcc \
make \
flex \
bison \
vim

WORKDIR /tmp
RUN wget http://web.mit.edu/kerberos/dist/krb5/1.14/krb5-1.14.4.tar.gz
RUN tar xzvf krb5-1.14.4.tar.gz

WORKDIR /tmp/krb5-1.14.4/src
RUN ./configure && make && make install

COPY krb5.conf /etc/krb5.conf

RUN mkdir -p /usr/local/var/krb5kdc
COPY kdc.conf /usr/local/var/krb5kdc/kdc.conf

RUN mkdir -p /var/lib/krb5kdc/
RUN mkdir -p /etc/krb5kdc

WORKDIR /opt

RUN rm -rf /tmp/*

COPY entrypoint.sh /opt/entrypoint.sh
COPY init.sh /opt/init.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD []

EXPOSE 88
EXPOSE 543
EXPOSE 544
EXPOSE 749
EXPOSE 750
EXPOSE 751

ARG buildtime
ARG builder
LABEL buildtime=${buildtime} \
      builder=${builder}

