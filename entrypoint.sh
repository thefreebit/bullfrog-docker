#!/bin/bash


# SYNOPSIS
#  quoteSubst <text>
quoteSubst() {
  IFS= read -d '' -r < <(sed -e ':a' -e '$!{N;ba' -e '}' -e 's/[&/\]/\\&/g; s/\n/\\&/g' <<<"$1")
  printf %s "${REPLY%$'\n'}"
}

# SYNOPSIS
# populateProperty Property name, Value
populatePropertyIfNeeded() {

    if [[ "$2" ]]
    then
        local PROP=$(quoteSubst "$1")
        local VAL=$(quoteSubst "$2")
        sed -ri "s/^${PROP}=/${PROP}=$VAL/g" bullfrog-central.properties
    fi
}

populateLogIfNeeded() {
    if [[ "$2" ]]
    then
        local PROP=$(quoteSubst "$1")
        local VAL=$(quoteSubst "$2")
        sed -ri "s/${PROP}/$VAL/g" logback.xml
    else
        local PROP=$(quoteSubst "$1")
        local VAL="info"
	sed -ri "s/${PROP}/$VAL/g" logback.xml
    fi
}

## The CASSANDRA_URL is required, fail if it is not set
if [[ -z "$CASSANDRA_URL" ]]
then
    echo "Variable CASSANDRA_URL must be set."
    exit -1
fi

## Populate the bullfrog-central.properties
cd bullfrog-central
cp bullfrog-central.properties.original bullfrog-central.properties

populatePropertyIfNeeded "cassandra.contactPoints" $CASSANDRA_URL
populatePropertyIfNeeded "cassandra.username" $CASSANDRA_USERNAME
populatePropertyIfNeeded "cassandra.password" $CASSANDRA_PASSWORD
populatePropertyIfNeeded "cassandra.keyspace" $CASSANDRA_KEYSPACE
populatePropertyIfNeeded "cassandra.consistencyLevel" $CASSANDRA_CONSISTENCY
populatePropertyIfNeeded "grpc.bindAddress" $GRPC_BIND
populatePropertyIfNeeded "grpc.httpPort" $GRPC_HTTP_PORT
populatePropertyIfNeeded "grpc.httpsPort" $GRPC_HTTPS_PORT
populatePropertyIfNeeded "ui.bindAddress" $UI_BIND
populatePropertyIfNeeded "ui.port" $UI_PORT
populatePropertyIfNeeded "ui.https" $UI_HTTPS
populatePropertyIfNeeded "ui.contextPath" $UI_CONTEXT

populateLogIfNeeded "LOG_LEVEL" $LOG_LEVEL

if [ -z ${JAVA_OPTS} ]
then
	java -jar -Dlogback.configurationFile=/bullfrog-central/logback.xml bullfrog-central.jar
else
	java -jar ${JAVA_OPTS} -Dlogback.configurationFile=/bullfrog-central/logback.xml bullfrog-central.jar
fi
