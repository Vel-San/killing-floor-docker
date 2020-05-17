#!/bin/sh
docker build -t vel7an/kf1-docker --build-arg steamU="$1" \
--build-arg steamP="$2" \
--build-arg code="$3" .