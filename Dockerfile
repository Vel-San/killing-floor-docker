FROM cm2network/steamcmd as builder

ARG steamU=anonymous
ARG steamP=""
ARG code=""

RUN echo "Your Credentials: $steamU // $steamP // $code"
RUN /home/steam/steamcmd/steamcmd.sh \
        +login $steamU $steamP $code \
        +force_install_dir /home/steam/servers/kf \
        +app_update 215360 validate \
        +quit

FROM debian:stretch-slim

RUN apt-get update \
    && apt-get install --yes \
        lib32stdc++6 \
    && apt-get --yes clean autoclean autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m steam \
    # WORKDIR does not respect user :(
    && su steam -c "mkdir -p /home/steam/servers/kf"

USER steam
COPY --from=builder --chown=steam:steam /home/steam/servers/kf /home/steam/servers/kf

WORKDIR /home/steam/servers/kf/System

COPY KillingFloor.ini KillingFloor.ini

ARG serverN=""
ARG adminN=""
ARG adminE=""
ARG adminP=""
ARG motd=""
ARG redirect=""

RUN sed -i 's/ServerName=Killing Floor Server/ServerName=$serverN/g' KillingFloor.ini

EXPOSE 7707/udp 7708/udp 7717/udp 28852 8075/tcp 20560/udp
RUN ./ucc-bin server KF-BioticsLab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=6 -nohomedir
