FROM cm2network/steamcmd

# Steam Logic Creds
ARG steamU=anonymous
ARG steamP=""
ARG code=""

RUN echo "Your Credentials: $steamU // $steamP // $code"
# Login to steam and download KF1
RUN /home/steam/steamcmd/steamcmd.sh \
        +login $steamU $steamP $code \
        +force_install_dir /home/steam/servers/kf \
        +app_update 215360 validate \
        +quit

USER root
# Install dependencies and create steam user
RUN apt-get update \
    && apt-get install --yes \
        lib32stdc++6 procps

USER steam

# Add scripts needed for entry point
WORKDIR /home/steam/servers/kf/System
# Copy Maps and Systems for customized mutators
COPY Maps /home/steam/servers/kf/Maps
COPY System /home/steam/servers/kf/System
RUN pwd && ls

# Needed scripts - DO NOT REMOVE
ADD kf1_functions.sh kf1_functions.sh
ADD main main

# Expose needed ports
EXPOSE 7707/udp 7708/udp 7717/udp 28852/udp 28852/tcp 8075/tcp 20560/udp 20560/tcp
# Do some magic!
ENTRYPOINT ["/bin/bash", "main"]
