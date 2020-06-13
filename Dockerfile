FROM cm2network/steamcmd

USER root

# Install dependencies and create steam user
RUN apt-get update \
    && apt-get install --yes \
        lib32stdc++6 procps
USER steam

# Needed scripts - DO NOT REMOVE
WORKDIR /home/steam
COPY --chown=steam *.sh ./
RUN chmod +x *.sh
RUN mkdir -p ./servers/kf

# Expose needed ports
EXPOSE 7707/udp 7708/udp 7717/udp 28852/udp 28852/tcp 8075/tcp 20560/udp 20560/tcp
# Do some magic!
ENTRYPOINT ["/bin/bash", "kf1_install.sh"]