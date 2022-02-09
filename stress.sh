#!/usr/bin/env bash

# Create my files for storing the stats in
rm -f JDK_95.txt JDK_ALL_95.txt NI_95.txt NI_ALL_95.txt NI_G1_95.txt NI_G1_ALL_95.txt JLINK_95.txt JLINK_ALL_95.txt
touch JDK_95.txt JDK_ALL_95.txt NI_95.txt NI_ALL_95.txt NI_G1_95.txt NI_G1_ALL_95.txt JLINK_95.txt JLINK_ALL_95.txt

# Let's stress test and get some stats
echo -ne "Stress Testing..."
# Requests/sec: 

hey -z 15s -c 4 http://localhost:8081/jibber | tee JDK_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > JDK_95.txt &
hey -z 15s -c 4 http://localhost:8082/jibber | tee NI_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > NI_95.txt &
hey -z 15s -c 4 http://localhost:8083/jibber | tee NI_G1_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > NI_G1_95.txt &

hey -z 15s -c 4 http://localhost:8085/jibber | tee JLINK_ALL_95.txt | grep --color=auto -Eo '95% in [0-9]+.[0-9]+ secs' > JLINK_95.txt &

# Progress bar
for i in `seq 16`;
    do echo -ne "#";
    sleep 1s;
done
echo -ne " DONE"

JDK_LAT=`cat JDK_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
NI_LAT=`cat NI_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
NI_G1_LAT=`cat NI_G1_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
JLINK_LAT=`cat JLINK_95.txt | sed 's/95% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`

JDK_REQS=`cat JDK_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
NI_REQS=`cat NI_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
NI_G1_REQS=`cat NI_G1_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`
JLINK_REQS=`cat JLINK_ALL_95.txt | grep -Eo '[[:space:]]+Requests/sec:[[:space:]][0-9]+.[0-9]+' | awk '{print $2}'`

echo "JDK-Container ${JDK_LAT}
    NI-Container  ${NI_LAT}
    NI-G1-Container ${NI_G1_LAT}
    JLink-COntainer ${JLINK_LAT}" \
    | termgraph --title "Latency of 95% of Requests" --width 60 --color {green,} --suffix " ms"

echo "JDK-Container ${JDK_REQS}
    NI-Container  ${NI_REQS}
    NI-G1-Container ${NI_G1_REQS}
    JLink-COntainer ${JLINK_REQS}" \
    | termgraph --title "Requests  / sec" --width 60 --color {green,} --suffix " ms"