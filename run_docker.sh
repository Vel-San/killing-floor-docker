#!/bin/sh
function run_docker(){
    local cmd
    ports="-p 0.0.0.0:7707:7707/udp\
 -p 0.0.0.0:7708:7708/udp\
 -p 0.0.0.0:7717:7717/udp\
 -p 0.0.0.0:28852:28852/udp\
 -p 0.0.0.0:8075:8075/tcp\
 -p 0.0.0.0:20560:20560/udp "
    cmd="docker run --rm -it --name kf1-docker "
    cmd+="$ports"
    cmd+="--env-file=env_file "
    cmd+="vel-san/killing-floor"
    echo "$cmd"
    exec $cmd
}

run_docker