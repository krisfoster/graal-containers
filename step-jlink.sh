#!/usr/bin/env bash

REPO=localhost
APP=jibber
TYPE=jlink
VER=0.1
CONTAINER=${REPO}/${APP}:${TYPE}.${VER}
JAR_FILE=jibber-0.0.1-SNAPSHOT-exec.jar

# Build a minimal JRE that will run our app
rm -rf ./target/min-jre
jlink --add-modules java.base,java.logging,java.desktop,jdk.httpserver,java.management,java.naming,java.security.jgss,java.instrument \
        --output ./target/min-jre

#echo "Building Java..."
mvn package -DskipTests
#echo "DONE"

echo "Dockerizing our app.."
docker login container-registry.oracle.com
docker build -f ./Dockerfiles/Dockerfile.jlink \
             --build-arg JAR_FILE=${JAR_FILE} \
             -t ${CONTAINER} .
echo "DONE"