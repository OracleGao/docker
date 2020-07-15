###############################

  #Author: OracleGao
  #Date: 2019-11-07
  #Desc: 编译构建java项目jar
  #Git: https://github.com/OracleGao/docker.git

###############################
#!/usr/bin/env bash
cd $(dirname $0)

JAVA_BUILD_IMAGE=${JAVA_BUILD_IMAGE:-openjdk:11-jre}
JAVA_COMPILE_IMAGE=${JAVA_COMPILE_IMAGE:-maven:3.6-jdk-11}

if [ ! -f ./parse_pom_xml.sh ]; then
echo ""
fi

project_name=$(./parse_pom_xml.sh art)
project_version=$(./parse_pom_xml.sh version)

JAVA_PROJECT_NAME=${JAVA_SERVICE_NAME:-${project_name}}
JAVA_PROJECT_VERSION=${JAVA_PROJECT_VERSION:-${project_version}}

JAVA_JAR_NAME=${JAVA_JAR_NAME:-${JAVA_PROJECT_NAME}-${JAVA_PROJECT_VERSION}}.jar

docker run --rm -v ~/.m2/repository:/root/.m2/repository -v $(pwd):/usr/src -w /usr/src ${JAVA_COMPILE_IMAGE} mvn install -Dskip.test=true -Dmaven.test.skip=true

timestamp=$(date "+%Y%m%d%H%M%S")
dockerfile=Dockerfile.${timestamp}

cat >> ./${dockerfile} << EOF
FROM ${JAVA_BUILD_IMAGE}
MAINTAINER oraclegao@126.com

RUN mkdir -p /opt/jar

WORKDIR /opt/jar

COPY ./target/${JAVA_JAR_NAME} runnable.jar
COPY entrypoint.sh entrypoint.sh

EXPOSE 8080

CMD ["/opt/jar/entrypoint.sh"]
EOF

docker_image=${JAVA_PROJECT_NAME}:${JAVA_PROJECT_VERSION}

docker build -f ${dockerfile} -t ${docker_image} .
rm -rf ${dockerfile}

docker run --rm -v ~/.m2/repository:/root/.m2/repository -v $(pwd):/usr/src -w /usr/src ${JAVA_COMPILE_IMAGE} mvn clean

if [ "$1" == "-d" ]; then
  docker run -it --rm -e JAVA_OPTS="-Xms256m -Xmx256m -Xss1024K -XX:MetaspaceSize=64m -XX:MaxMetaspaceSize=64m" ${docker_image}
fi
t: https://github.com/OracleGao/docker.git
