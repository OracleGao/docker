FROM openjdk:11-jre
MAINTAINER oraclegao@126.com

RUN mkdir -p /opt/jar

WORKDIR /opt/jar

COPY runnable.jar runnable.jar
COPY entrypoint.sh entrypoint.sh

EXPOSE 8080

CMD ["/opt/jar/entrypoint.sh"]
