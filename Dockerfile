FROM openjdk:8u151-jdk
ARG BULLFROG_VERSION=0.0.2

ADD ./entrypoint.sh /entrypoint.sh
ADD ./logback.xml /bullfrog-central/logback.xml


RUN curl -L "https://bintray.com/thefreebit-org/projects/download_file?file_path=thefreebit%2Fbullfrog-central%2F${BULLFROG_VERSION}%2Fbullfrog-central-0.0.2.zip" -o installer.zip

RUN unzip installer.zip

RUN apt-get update && apt-get install -y vim telnet

RUN cp /bullfrog-central/bullfrog-central.properties /bullfrog-central/bullfrog-central.properties.original

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
