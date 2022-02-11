#!/usr/bin/env bash

# Extract time to start from the logs - convert to ms
JDK_START=`docker logs --tail 10 $(docker ps -q -f name=jibber-jdk) | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
NATIVE_START=`docker logs --tail 10 $(docker ps -q -f name=jibber-nibase) | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`
NATIVEG1_START=`docker logs --tail 10 $(docker ps -q -f name=jibber-nig1) | grep -Eo 'Started .+ in [0-9]+.[0-9]+ sec' | sed 's/[[:space:]]sec$//' | sed 's/Started[[:space:]][a-zA-Z]\+[[:space:]]in[[:space:]]//'`

# Convert to ms
JDK_START=$(echo "${JDK_START}" | awk '{printf "%d", $1*1000}')
NATIVE_START=$(echo "${NATIVE_START}" | awk '{printf "%d", $1*1000}')
NATIVEG1_START=$(echo "${NATIVEG1_START}" | awk '{printf "%d", $1*1000}')

# Display as a chart
echo "NI-Container ${NATIVE_START}
    NI-G1-Container ${NATIVEG1_START}
    JDK-Container ${JDK_START}" \
    | termgraph --title "App Start Time" --width 60  --color {green,} --suffix " ms"
