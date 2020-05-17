#!/bin/sh
docker build -t velsan/killing-floor --build-arg steamU="$1" \
--build-arg steamP="$2" \
--build-arg code="$3" .