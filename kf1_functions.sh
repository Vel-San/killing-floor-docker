
function require_config() {
    # Generate INI files
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
    sed -i "s/ServerBehindNAT=False/ServerBehindNAT=True/g" KillingFloor.ini
    sed -i "s/AllowDownloads=False/AllowDownloads=True/g" KillingFloor.ini
    sed -i "s/UseCompression=False/UseCompression=True/g" KillingFloor.ini
    sed -i "s/bEnabled=False/bEnabled=True/g" KillingFloor.ini
}

function load_config() {
    ## Load defaults if nothing has been set

    ################## MAP SETTINGS ##################
    # Default Launch Map
    [[ -z "$KF_MAP" ]] && export KF_MAP=KF-BioticsLab

    # 1, 2, 4, 5, 7
    [[ -z "$KF_DIFFICULTY" ]] && export KF_DIFFICULTY=4

    # Setting this creates a private server
    [[ -z "$KF_GAME_PASS" ]] && export KF_GAME_PASS=""

    # 0 - 4 waves, 1 - 7 waves, 2 - 10 waves
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

    # Server Message Of The Day
    [[ -z "$KF_MOTD" ]] && export KF_MOTD=Welcome To My Server

    # Server redirectURL to download hosted mods from
    [[ -z "$KF_REDIRECT" ]] && export KF_REDIRECT=http://www.skillzservers.com/kf-redirect/

    ## Edit KillingFloor.ini
    ############# BASIC REPLACEMENTS #############
    sed -i "s/ServerName=Killing Floor Server/ServerName=$KF_SERVER_NAME/g" KillingFloor.ini
    echo -e "[KFMod.KFGameType]\nKFGameLength=$KF_GAME_LENGTH" >> KillingFloor.ini
    [[ -z "$KF_GAME_PASS" ]] || sed -i "s/GamePassword=/GamePassword=$KF_GAME_PASS/g" KillingFloor.ini
    sed -i "/VotingHandlerType=xVoting.xVotingHandler/a GameDifficulty=$KF_DIFFICULTY" KillingFloor.ini
    sed -i "s/AdminName=/AdminName=$KF_ADMIN_NAME/g" KillingFloor.ini
    sed -i "s/AdminPassword=/AdminPassword=$KF_ADMIN_PASS/g" KillingFloor.ini
    sed -i "s/AdminEmail=/AdminEmail=$KF_ADMIN_EMAIL/g" KillingFloor.ini
    sed -i "s/MessageOfTheDay=/MessageOfTheDay=$KF_MOTD/g" KillingFloor.ini
    sed -i "/VotingHandlerType=xVoting.xVotingHandler/a bVACSecured=True" KillingFloor.ini
    sed -i "/VotingHandlerType=xVoting.xVotingHandler/a bAdminCanPause=True" KillingFloor.ini
    sed -i "s,RedirectToURL=,RedirectToURL=$KF_REDIRECT,g" KillingFloor.ini
    
    ############# MUTATORS RELATED REPLACEMENTS #############
    # If you have MaxPlayers or ServerColor enabled, uncomment the 2 below commands
    # And don't forget to edit the config of these 2 mutators in the /System directory
    # sed -i '/ServerActors=UWeb.WebServer/a ServerActors=ServerColor.ServerColorActor' KillingFloor.ini
    # sed -i '/ServerActors=UWeb.WebServer/a ServerActors=KFMaxPlayers.KFMaxPlayers' KillingFloor.ini
    # If you are using MapVote Handler Fix, uncomment the below command, make sure you already have the pre-configured
    # map votings in the /System
    sed -i "s/VotingHandlerType=xVoting.xVotingHandler/VotingHandlerType=KFMapVoteV2.KFVotingHandler/g" KillingFloor.ini
}

function launch() {
    local cmd

    cmd="./ucc-bin server "
    cmd+="$KF_MAP.rom?game=KFmod.KFGameType?"
    [[ -z "$KF_MUTATORS" ]] || cmd+="mutator=$KF_MUTATORS?"
    cmd+="VACSecured=true?MaxPlayers=6 -nohomedir"
    echo "Running command: $cmd" > $0-cmd.log
    exec $cmd
}