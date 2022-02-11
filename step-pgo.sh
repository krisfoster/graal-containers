#!/usr/bin/env bash

REPO=localhost
APP=jibber
TYPE=pgo
VER=0.1
CONTAINER=${REPO}/${APP}:${TYPE}.${VER}
APP_FILE=jibber-pgo
echo "Container : ${CONTAINER}"

echo "Building native executable..."
mvn package -DskipTests -Ppgo
echo "DONE"

echo "Dockerizing our app.."
docker login container-registry.oracle.com
docker build -f ./Dockerfiles/Dockerfile.distroless \
             --build-arg APP_FILE=${APP_FILE} \
             -t ${CONTAINER} .
echo "DONE"
