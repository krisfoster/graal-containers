#!/usr/bin/env bash

NATIVE_PGO_SIZE=`ls -lh target/jibber-pgo | awk '{print $5}' | sed 's/M//'`
NATIVE_G1_SIZE=`ls -lh target/jibber-g1 | awk '{print $5}' | sed 's/M//'`
NATIVE_SIZE=`ls -lh target/jibber | awk '{print $5}' | sed 's/M//'`
JAR_SIZE=`ls -lh target/jibber-0.0.1-SNAPSHOT-exec.jar | awk '{print $5}' | sed 's/M//'`
JDK_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:jdk.0.1 | numfmt --to=si | sed 's/.$//'`
NATIVE_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:native.0.1 | numfmt --to=si | sed 's/.$//'`
NATIVEG1_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:nativeg1.0.1 | numfmt --to=si | sed 's/.$//'`
NATIVEDISTROLESS_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:distroless.0.1 | numfmt --to=si | sed 's/.$//'`
JLINK_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:jlink.0.1 | numfmt --to=si | sed 's/.$//'`
NATIVEPGO_IMG_SIZE=`docker inspect -f "{{ .Size }}" localhost/jibber:pgo.0.1 | numfmt --to=si | sed 's/.$//'`


# Chart of the image sizes
echo "JAR ${JAR_SIZE}
    Native-Exe ${NATIVE_SIZE}
    Native-G1-Exe ${NATIVE_G1_SIZE}
    Native-G1-PGO-Exe ${NATIVE_PGO_SIZE}
    NI-Distroless-Cont. ${NATIVEDISTROLESS_IMG_SIZE}
    NI-Container ${NATIVE_IMG_SIZE}
    NI-G1-Container ${NATIVEG1_IMG_SIZE}
    JDK-Container ${JDK_IMG_SIZE}
    JLink-Continer ${JLINK_IMG_SIZE}
    NI-PGO-COntainer ${NATIVEPGO_IMG_SIZE}" \
    | termgraph --title "Container Size" --width 60 --color {green,} --suffix " MB"

