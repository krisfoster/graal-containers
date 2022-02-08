#!/usr/bin/env bash

# Create my files for storing the stats in
touch JDK_99.txt

# Let's stress test and get some stats
echo -ne "Stress Testing..."

hey -z 15s -c 4 http://localhost:8081/jibber | grep --color=auto -Eo '99% in [0-9]+.[0-9]+ secs' > JDK_99.txt &
hey -z 15s -c 4 http://localhost:8082/jibber | grep --color=auto -Eo '99% in [0-9]+.[0-9]+ secs' > NI_99.txt &

# Progress bar
for i in `seq 16`;
    do echo -ne "#";
    sleep 1s;
done
echo -ne " DONE"
echo

JDK_LAT=`cat JDK_99.txt | sed 's/99% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`
NI_LAT=`cat NI_99.txt | sed 's/99% in //' | sed 's/ secs//' | awk '{printf "%d", $1*1000}'`

echo "JDK-Container ${JDK_LAT}
    NI-Container  ${NI_LAT}" \
    | termgraph --title "Latency of 99% of Requests" --width 60 --color {green,} --suffix " ms"
echo