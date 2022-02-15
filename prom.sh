#/usr/bin/env bash
echo "Prometheus : http://localhost:9090/graph?g0.expr=%20container_memory_rss%7Bname%3D%22jibber-jdk%22%7D%20or%20%20container_memory_rss%7Bname%3D%22jibber-nibase%22%7D&g0.tab=0&g0.stacked=0&g0.show_exemplars=0&g0.range_input=5m"
