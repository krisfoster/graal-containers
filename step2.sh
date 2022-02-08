#!/usr/bin/env bash

REPO=localhost
APP=jibber
TYPE=nativeg1
VER=0.1
CONTAINER=${REPO}/${APP}:${TYPE}.${VER}
APP_FILE=jibber-g1
echo "Container : ${CONTAINER}"

echo "Building native executable..."
mvn package -DskipTests -Pnativeg1
echo "DONE"

echo "Dockerizing our app.."
docker login container-registry.oracle.com
docker build -f ./Dockerfiles/Dockerfile.native \
             --build-arg APP_FILE=${APP_FILE} \
             -t ${CONTAINER} .
echo "DONE"
