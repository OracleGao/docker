FROM openjdk:8-jre
MAINTAINER gaojingzhe@yunzujia.com

RUN mkdir -p /opt/jar

WORKDIR /opt/jar


COPY runnable.jar runnable.jar

EXPOSE 8080

CMD ["java", "-jar", "runnable.jar"]
