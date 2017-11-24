FROM openjdk:8u151-jdk
ARG BULLFROG_VERSION=0.0.0

ADD ./entrypoint.sh /entrypoint.sh


RUN curl -L "https://bintray.com/thefreebit-org/projects/download_file?file_path=thefreebit%2Fbullfrog-central%2F${BULLFROG_VERSION}%2Fbullfrog-central-${BULLFROG_VERSION}.zip" -o installer.zip

RUN unzip installer.zip

RUN cp /bullfrog-central/bullfrog-central.properties /bullfrog-central/bullfrog-central.properties.original

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
