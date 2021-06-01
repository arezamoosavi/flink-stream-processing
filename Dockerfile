FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y iputils-ping telnet openssh-client net-tools \
    man unzip vim bc openssh-server thrift-compiler netcat sudo \
    && apt-get install -y build-essential python-software-properties software-properties-common \
    && apt-get autoremove -y \
    && apt-get clean \
    && add-apt-repository ppa:webupd8team/java \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections

RUN apt-get update && apt-get install -y oracle-java8-installer maven

ADD . /opt/project
RUN cd /opt/project && mvn assembly:assembly

WORKDIR /opt/project

ENTRYPOINT ["java", "-jar", "target/flink-stream-processing-1.0-SNAPSHOT.jar"]
