# killing-floor-docker

This is a fork of [Vel-San/killing-floor-docker](https://github.com/Vel-San/killing-floor-docker) with a few notable changes:
- Server install is done at run time instead of build time. This keeps the docker image small and allows you to easily tweak the server files post-install using a docker volume.
- Custom maps and mutators have been removed to provide a vanilla install. These customizations can be added post-install.

## Current (and future) variables

### Run Vars

When running a container for the first time, you will need to supply a steam login to install the server.

```bash
STEAM_USER=
STEAM_PASSWORD=
STEAM_CODE=
```

Use these vars to tweak the server settings when a container starts.

```bash
# Map Name
KF_MAP=
# 1 Begginer, 2 Normal, 4 Hard, 5 Suicidal, 7 Hell On Earth
KF_DIFFICULTY=
# 0 - 4 waves, 1 - 7 waves, 2 - 10 waves
KF_GAME_LENGTH=
# Server Name
KF_SERVER_NAME=
# Game Password, Do not provide the parameter if you want no password
KF_GAME_PASS=
# Mutators to be enabled by default on server startup; sepereate by a Comma
# And make sure to configure your System/ directory before building to add the mutators
KF_MUTATORS=
# Admin Name
KF_ADMIN_NAME=
# WebAdmin Password
KF_ADMIN_PASS=
# Admin E-Mail
KF_ADMIN_EMAIL=
# Message Of The Day - Shows when someone joins the server
KF_MOTD=
# Redirect URL
KF_REDIRECT=
```

## Build Command

```bash
docker build -t kf1-docker
```

## Run Command

Here's an example first run command. Replace the values in parens with your own values.

```bash
docker run -d --name kf1 \
        -p 0.0.0.0:7707:7707/udp \
        -p 0.0.0.0:7708:7708/udp \
        -p 0.0.0.0:7717:7717/udp \
        -p 0.0.0.0:28852:28852/udp \
        -p 0.0.0.0:28852:28852/tcp \
        -p 0.0.0.0:8075:8075/tcp \
        -p 0.0.0.0:20560:20560/udp \
        -p 0.0.0.0:20560:20560/tcp \
        -v (your server folder):/home/steam/servers/kf \
        -e STEAM_USER=(user) \
        -e STEAM_PASSWORD=(pass) \
        -e STEAM_CODE=(code) \
        -e KF_MAP=KF-BioticsLab \
        -e KF_DIFFICULTY=4 \
        -e KF_GAME_LENGTH=2 \
        -e KF_GAME_PASS=(pass) \
        -e KF_SERVER_NAME='Killing Floor Server' \
        -e KF_ADMIN_NAME=(name) \
        -e KF_ADMIN_PASS=(pass) \
        -e KF_ADMIN_EMAIL=(email) \
        -e KF_MOTD=Welcome \
        kf1-docker
```