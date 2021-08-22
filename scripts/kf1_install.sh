#!/bin/bash

set -o xtrace

if [[ ! -f "/home/steam/servers/kf/System/Core.u" ]]; then
  echo "#### No server install found; preparing to run steamcmd... ####"

  if [[ -z $STEAM_USER ]]; then
    echo "## Env var STEAM_USER is required but not found ##"
    exit 1
  fi

  if [[ -z $STEAM_PASSWORD ]]; then
    echo "## Env var STEAM_PASSWORD is required but not found ##"
    exit 1
  fi

  if [[ -z $STEAM_CODE ]]; then
    echo "## Env var STEAM_CODE not found; this is only a problem if steam guard is enabled ##"
  fi

  /home/steam/steamcmd/steamcmd.sh \
    +login $STEAM_USER $STEAM_PASSWORD $STEAM_CODE \
    +force_install_dir /home/steam/servers/kf \
    +app_update 215360 validate \
    +quit

  if [[ $? -ne 0 ]]; then
    echo "# Install failed, aborting... #"
    exit 1
  fi

  echo "#### Copying run-time functions to /System ####"
  cp main.sh kf1_functions.sh /home/steam/servers/kf/System

  echo "#### Patching with latest Steam Libs to fix VAC/Server List ####"
  cp /steamcmd/linux32/libtier0_s.so /home/steam/servers/kf/System/libtier0_s.so
  cp /steamcmd/linux32/libvstdlib_s.so /home/steam/servers/kf/System/libvstdlib_s.so
  cp /steamcmd/linux32/steamclient.so /home/steam/servers/kf/System/steamclient.so
fi

cd /home/steam/servers/kf/System
./main.sh
