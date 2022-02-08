#!/usr/bin/env bash

JAR_SIZE=`ls -lh target/jibber-0.0.1-SNAPSHOT-exec.jar | awk '{print $5}' | sed 's/M//'`
JDK_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:jdk.0.1 | numfmt --to=si | sed 's/.$//'`
NATIVE_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:native.0.1 | numfmt --to=si | sed 's/.$//'`
NATIVEG1_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:nativeg1.0.1 | numfmt --to=si | sed 's/.$//'`


# Chart fo the image sizes
echo "JAR ${JAR_SIZE}
    JDK-Container ${JDK_IMG_SIZE}
    NI-Container ${NATIVE_IMG_SIZE}
    NI-G1-Container ${NATIVEG1_IMG_SIZE}" \
    | termgraph --title "Container Size" --width 60 --color {green,} --suffix " MB"

