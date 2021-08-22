#!/bin/bash

# Source functions below
echo "#### Sourcing KF1_Functions.sh ####"
source kf1_functions.sh

# Generates .ini
echo "#### Running require_config() ####"
require_config
# Optimize KF
echo "#### Running optimize_kf() ####"
optimize_kf
# Loads custom config from vars
echo "#### Running load_config() ####"
load_config
# Start Server
echo "#### Running launch() ####"
launch
