#!/usr/bin/env bash

REPO=localhost
APP=jibber
TYPE=jlink
VER=0.1
CONTAINER=${REPO}/${APP}:${TYPE}.${VER}
JAR_FILE=jibber-0.0.1-SNAPSHOT-exec.jar

#echo "Building Java..."
mvn package -DskipTests
#echo "DONE"

echo "Dockerizing our app.."
docker login container-registry.oracle.com
docker build -f ./Dockerfiles/Dockerfile.jlink \
             --build-arg JAR_FILE=${JAR_FILE} \
             -t ${CONTAINER} .
echo "DONE"