
# # Your custom vars for a server
# serverN=""
# adminN=""
# adminE=""
# adminP=""
# motd=""
# redirect=""

# sed -i 's/ServerName=Killing Floor Server/ServerName=$serverN/g' KillingFloor.ini && \
# sed -i 's/ServerName=Killing Floor Server/ServerName=$adminN/g' KillingFloor.ini && \
# sed -i 's/ServerName=Killing Floor Server/ServerName=$adminE/g' KillingFloor.ini && \
# sed -i 's/ServerName=Killing Floor Server/ServerName=$adminP/g' KillingFloor.ini && \
# sed -i 's/ServerName=Killing Floor Server/ServerName=$motd/g' KillingFloor.ini && \
# sed -i 's/ServerName=Killing Floor Server/ServerName=$redirect/g' KillingFloor.ini

function require_config() {
    # Generate INI files
    if [[ ! -f "KillingFloor.ini" ]]; then
        screen $SCREEN_NAME ./ucc-bin server KF-BioticsLab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=6 -nohomedir
        sleep 20
        kfpid=$(ps fax | grep $SCREEN_NAME | grep SCREEN | awk '{ print $1 }')
        kill $kfpid
    fi

}

# Mandatory Changes to KillingFloor.ini / Optimisations
function optimize_kf(){
    sed -i 's/ServerBehindNAT=False/ServerBehindNAT=True/g' KillingFloor.ini
    sed -i 's/AllowDownloads=False/AllowDownloads=True/g' KillingFloor.ini
    sed -i 's/UseCompression=False/UseCompression=True/g' KillingFloor.ini
    sed -i 's/bEnabled=False/bEnabled=True/g' KillingFloor.ini
}

function load_config() {
    ## Load defaults if nothing has been set

    # Default to survival
    [[ -z "$KF_GAME_MODE" ]] && export KF_GAME_MODE=Survival
    if [[ "$KF_GAME_MODE" == 'VersusSurvival' ]]; then
        KF_GAME_MODE='VersusSurvival?maxplayers=12';
    fi;

    # find /path/to/volume -name '*KF-*kfm' | xargs -n 1 basename -s .kfm\n"
    [[ -z "$KF_MAP" ]] && export KF_MAP=KF-BioticsLab

    # 0 - normal, 1 - hard, 2 - suicidal, 3 - hell on earth
    [[ -z "$KF_DIFFICULTY" ]] && export KF_DIFFICULTY=0

    # Used for web console and in-game logins
    [[ -z "$KF_ADMIN_PASS" ]] && export KF_ADMIN_PASS=secret

    # Setting this creates a private server
    [[ -z "$KF_GAME_PASS" ]] && export KF_GAME_PASS=''

    # 0 - 4 waves, 1 - 7 waves, 2 - 10 waves, default 1
    [[ -z "$KF_GAME_LENGTH" ]] && export KF_GAME_LENGTH=1

    # Name that appears in the server browser
    [[ -z "$KF_SERVER_NAME" ]] && export KF_SERVER_NAME=KF2 Server

    # true or false, default false
    [[ -z "$KF_ENABLE_WEB" ]] && export KF_ENABLE_WEB=false

    # default to 7777
    [[ -z "$KF_PORT" ]] && export KF_PORT=7777

    # default to $(($KF_PORT + 19238))
    #    (19238 = 27015 - 7777)
    [[ -z "$KF_QUERY_PORT" ]] && export KF_QUERY_PORT="$(($KF_PORT + 19238))"

    # default to 8080
    [[ -z "$KF_WEBADMIN_PORT" ]] && export KF_WEBADMIN_PORT=8080


    ## Now we edit the config files to set the config
    sed -i "s/^GameLength=.*/GameLength=$KF_GAME_LENGTH\r/" "${HOME}/kf2server/KFGame/Config/LinuxServer-KFGame.ini"
    sed -i "s/^ServerName=.*/ServerName=$KF_SERVER_NAME\r/" "${HOME}/kf2server/KFGame/Config/LinuxServer-KFGame.ini"
    sed -i "s/^bEnabled=.*/bEnabled=$KF_ENABLE_WEB\r/" "${HOME}/kf2server/KFGame/Config/KFWeb.ini"
    [[ "${KF_DISABLE_TAKEOVER}" == 'true' ]] && sed -i 's/^bUsedForTakeover=.*/bUsedForTakeover=FALSE'"\r"'/' "${HOME}/kf2server/KFGame/Config/LinuxServer-KFEngine.ini"
    sed -i "s/^DownloadManagers=IpDrv.HTTPDownload/DownloadManagers=OnlineSubsystemSteamworks.SteamWorkshopDownload/" "${HOME}/kf2server/KFGame/Config/LinuxServer-KFEngine.ini"

}

function launch() {
    local cmd

    # cmd="${HOME}/kf2server/Binaries/Win64/KFGameSteamServer.bin.x86_64 "
    # cmd+="$KF_MAP?Game=KFGameContent.KFGameInfo_$KF_GAME_MODE"
    # cmd+="?Difficulty=$KF_DIFFICULTY"
    # cmd+="?AdminPassword=$KF_ADMIN_PASS"
    # [[ -z "$KF_MUTATORS" ]] || cmd+="?Mutator=$KF_MUTATORS"
    # [[ -z "$KF_GAME_PASS" ]] || cmd+="?GamePassword=$KF_GAME_PASS"
    # cmd+=" -Port=$KF_PORT"
    # cmd+=" -WebAdminPort=$KF_WEBADMIN_PORT"
    # cmd+=" -QueryPort=$KF_QUERY_PORT"

    cmd="./ucc-bin server KF-BioticsLab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=6 -nohomedir"
    echo "Running command: $cmd" > $0-cmd.log
    exec $cmd
}