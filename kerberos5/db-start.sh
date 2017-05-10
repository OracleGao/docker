#!/usr/bin/env bash
docker run -d -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone -p 88:88 -p 88:88/udp -p 750:750/udp --name kerberos-db kerberos-db:1.14.4
