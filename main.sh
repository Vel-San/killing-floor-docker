#!/bin/bash

# Source functions below
source kf1_functions.sh

# Generates .ini
require_config
# Optimize KF
optimize_kf
# Loads custom config from vars
load_config
# Start Server
launch