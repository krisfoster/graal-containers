#!/usr/bin/env bash

# Clear the screen
tput clear

# Chart of the image sizes
./sizes.sh

# Chart of startup times
./startups.sh

# Stress test
for i in `seq 3`;
    do ./stress.sh;
done

# Link to Prometheus
./prom.sh
