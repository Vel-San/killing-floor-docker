FROM cm2network/steamcmd as builder

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

FROM debian:stretch-slim

# Install dependencies and create steam user
RUN apt-get update \
    && apt-get install --yes \
        lib32stdc++6 \
    && apt-get --yes clean autoclean autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m steam \
    # WORKDIR does not respect user :(
    && su steam -c "mkdir -p /home/steam/servers/kf"

# Copy KF1 from to the new directory
USER steam
COPY --from=builder --chown=steam:steam /home/steam/servers/kf /home/steam/servers/kf

# Add scripts needed for entry point
WORKDIR /home/steam/servers/kf/System
ADD kf1_functions.sh kf1_functions.sh
ADD main main

# Will enable this later to make custom Maps & Mutators support
# COPY Maps /home/steam/servers/kf/
# COPY System /home/steam/servers/kf/

# Expose needed ports
EXPOSE 7707/udp 7708/udp 7717/udp 28852 8075/tcp 20560/udp
# Do some magic!
ENTRYPOINT ["/bin/bash", "main"]
