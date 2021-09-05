#!/bin/bash

function require_config() {
  echo "#### Generating INI files ####"
  # Generate INI files for the first time or 'sed' will fail
  if [[ ! -f "KillingFloor.ini" ]]; then
    ./ucc-bin server KF-BioticsLab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=6 -nohomedir &
    sleep 20
    ps aux
    killall ucc-bin-real
    ps aux
  fi
}

# Mandatory Changes to KillingFloor.ini / Optimisations
function optimize_kf(){
  echo "#### Optimizing Settings ####"
  sed -i "s/ServerBehindNAT=False/ServerBehindNAT=True/g" KillingFloor.ini
  sed -i "s/SendStats=False/SendStats=True/g" KillingFloor.ini
  sed -i "s/AllowDownloads=False/AllowDownloads=True/g" KillingFloor.ini
  sed -i "s/UseCompression=False/UseCompression=True/g" KillingFloor.ini
  sed -i "s/bEnabled=False/bEnabled=True/g" KillingFloor.ini
}

function load_config() {
  ## Load defaults if nothing has been set
  echo "#### Applying Default Options ####"
  ################## MAP SETTINGS ##################
  # Default Launch Map
  [[ -z "$KF_MAP" ]] && export KF_MAP=KF-BioticsLab

  # 1 Beginner, 2 Normal, 4 Hard, 5 Suicidal, 7 HoE
  [[ -z "$KF_DIFFICULTY" ]] && export KF_DIFFICULTY=4

  # Setting this creates a private server
  [[ -z "$KF_GAME_PASS" ]] && export KF_GAME_PASS=""

  # 0 --> 4 waves, 1 --> 7 waves, 2 --> 10 waves
  [[ -z "$KF_GAME_LENGTH" ]] && export KF_GAME_LENGTH=2

  ################## SERVER SETTINGS ##################
  # Name that appears in the server browser
  [[ -z "$KF_SERVER_NAME" ]] && export KF_SERVER_NAME=Killing Floor Server - DOCKERIZED

  # Name that appears in the server browser
  [[ -z "$KF_ADMIN_NAME" ]] && export KF_ADMIN_NAME=Admin

  # Used for web console and in-game logins
  [[ -z "$KF_ADMIN_PASS" ]] && export KF_ADMIN_PASS=123

  # Admin Email
  [[ -z "$KF_ADMIN_EMAIL" ]] && export KF_ADMIN_EMAIL=""
  
  # Spectators Count
  [[ -z "$KF_SPECTATORS" ]] && export KF_SPECTATORS=6

  # Specimens event type/skins
  # Select between the following:
  # ET_None -- Default
  # ET_SummerSideshow -- for the summer ZEDs
  # ET_HillbillyHorror -- for the Halloween ZEDs
  # ET_TwistedChristmas -- for the Christmas ZEDs
  [[ -z "$KF_SPECIMEN_EVENT_TYPE" ]] && export KF_SPECIMEN_EVENT_TYPE=ET_None

  # Server Message Of The Day
  [[ -z "$KF_MOTD" ]] && export KF_MOTD=Welcome To My Server

  # Server redirectURL to download hosted mods from
  [[ -z "$KF_REDIRECT" ]] && export KF_REDIRECT=http://www.skillzservers.com/kf-redirect/

  ## Edit KillingFloor.ini
  ############# BASIC REPLACEMENTS #############
  ## sed
  sed -i "s/ServerName=.*/ServerName=$KF_SERVER_NAME/g" KillingFloor.ini
  sed -i "s/AdminName=.*/AdminName=$KF_ADMIN_NAME/g" KillingFloor.ini
  sed -i "s/AdminPassword=.*/AdminPassword=$KF_ADMIN_PASS/g" KillingFloor.ini
  sed -i "s/AdminEmail=.*/AdminEmail=$KF_ADMIN_EMAIL/g" KillingFloor.ini
  sed -i "s/MessageOfTheDay=.*/MessageOfTheDay=$KF_MOTD/g" KillingFloor.ini
  sed -i "s,RedirectToURL=.*,RedirectToURL=$KF_REDIRECT,g" KillingFloor.ini
  sed -i "s/MaxSpectators=.*/MaxSpectators=$KF_SPECTATORS/g" KillingFloor.ini
  sed -i "s/SpecialEventType=.*/SpecialEventType=$KF_SPECIMEN_EVENT_TYPE/g" KillingFloor.ini
  ## grep
  grep -q "KFGameLength=" KillingFloor.ini && sed -i "s/KFGameLength=.*/KFGameLength=$KF_GAME_LENGTH/g" KillingFloor.ini || echo -e "[KFMod.KFGameType]\nKFGameLength=$KF_GAME_LENGTH" >> KillingFloor.ini
  grep -q "GameDifficulty=" KillingFloor.ini && sed -i "s/GameDifficulty=.*/GameDifficulty=$KF_DIFFICULTY/g" KillingFloor.ini || sed -i "/VotingHandlerType=xVoting.xVotingHandler/a GameDifficulty=$KF_DIFFICULTY" KillingFloor.ini
  ### grep optimizations
  grep -q "bVACSecured=True" KillingFloor.ini || sed -i "/VotingHandlerType=xVoting.xVotingHandler/a bVACSecured=True" KillingFloor.ini
  grep -q "bAdminCanPause=True" KillingFloor.ini || sed -i "/VotingHandlerType=xVoting.xVotingHandler/a bAdminCanPause=True" KillingFloor.ini
  grep -q "bAllowBehindView=True" KillingFloor.ini || sed -i "/VotingHandlerType=xVoting.xVotingHandler/a bAllowBehindView=True" KillingFloor.ini
  grep -q "bWeaponShouldViewShake=False" KillingFloor.ini || sed -i "/VotingHandlerType=xVoting.xVotingHandler/a bWeaponShouldViewShake=False" KillingFloor.ini
  ## conditional
  [[ -z "$KF_GAME_PASS" ]] || sed -i "s/GamePassword=.*/GamePassword=$KF_GAME_PASS/g" KillingFloor.ini
}

function launch() {
  echo "#### Launching Server ####"
  local cmd

  cmd="./ucc-bin server "
  cmd+="$KF_MAP.rom?game=KFmod.KFGameType?"
  [[ -z "$KF_MUTATORS" ]] || cmd+="mutator=$KF_MUTATORS?"
  cmd+="VACSecured=true?MaxPlayers=6 -nohomedir"
  echo "## Server launched with command: $cmd ##" > $0-cmd.log
  exec $cmd
}
