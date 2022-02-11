#!/usr/bin/env bash

REPO=localhost
APP=jibber
TYPE=pgoinst
VER=0.1
CONTAINER=${REPO}/${APP}:${TYPE}.${VER}
APP_FILE=jibber-pgoinst
echo "Container : ${CONTAINER}"

echo "Building native executable..."
mvn package -DskipTests -Ppgoinst
echo "DONE"

echo "Dockerizing our app.."
docker login container-registry.oracle.com
docker build -f ./Dockerfiles/Dockerfile.distroless \
             --build-arg APP_FILE=${APP_FILE} \
             -t ${CONTAINER} .
echo "DONE"
