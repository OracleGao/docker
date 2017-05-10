#!/usr/bin/env bash

docker run -d -p 11188:88 -v /etc/localtime:/etc/localtime -v /etc/timezone:/etc/timezone  --name kerberos kerberos5:1.14.4
