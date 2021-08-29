![repo-size](https://img.shields.io/github/repo-size/vel-san/killing-floor-docker?label=Repo-Size&style=flat-square) [![contrib](https://img.shields.io/github/contributors/vel-san/killing-floor-docker?label=Contributors&style=flat-square)](https://github.com/Vel-San/killing-floor-docker/graphs/contributors) [![release](https://img.shields.io/github/v/release/vel-san/killing-floor-docker?label=Release&style=flat-square)](https://github.com/Vel-San/killing-floor-docker/releases) [![Docker](https://img.shields.io/badge/Docker%20Hub-White--Listed%20Vanilla-Blue?style=flat-square)](https://hub.docker.com/r/vel7an/kf1-docker)

[![CI: Build & Deploy to DockerHub](https://github.com/Vel-San/killing-floor-docker/actions/workflows/Build_Deploy.yml/badge.svg?branch=master)](https://github.com/Vel-San/killing-floor-docker/actions/workflows/build_deploy.yml) [![CI: Container Scanner](https://github.com/Vel-San/killing-floor-docker/actions/workflows/trivy-analysis.yml/badge.svg)](https://github.com/Vel-San/killing-floor-docker/actions/workflows/trivy-analysis.yml)

[![](https://cache.gametracker.com/server_info/nn.h4ck.me:7707/b_560_95_1.png)](https://www.gametracker.com/server_info/nn.h4ck.me:7707/)

- [killing-floor1-docker](#killing-floor1-docker)
  - [READ BEFORE PROCEEDING](#read-before-proceeding)
  - [Docker Run Variables](#docker-run-variables)
  - [Build Command](#build-command)
  - [Run Command](#run-command)
  - [Useful docker commads](#useful-docker-commads)

# killing-floor1-docker

## READ BEFORE PROCEEDING

OSX 💻 Users: If, for any reason, you are encountering "Operation not permitted" issues while running, make sure you do the following:

1. In your Docker settings, disable/uncheck `Use gRPC FUSE for file sharing` and hit Restart to Apply changes
2. If the above doesn't solve your issue, go to your Machine Settings > Security & Privacy > Give `Full Disk Usage` to Docker.app (If this still doesn't work, give your terminal as well)

This should fix this issue 👍

## Docker Run Variables

When running a container for the first time, you will need to supply a steam login to install the server

- If you get password errors, just put your password in hyphons e.g 'Password_here'
- Make sure the code you provide (if you have 2FA enabled) is newly generated

```bash
STEAM_USER=
STEAM_PASSWORD=
STEAM_CODE=
```

Use these vars to tweak the server settings when a container starts

```bash
# Map Name
KF_MAP=
# 1 Begginer, 2 Normal, 4 Hard, 5 Suicidal, 7 Hell On Earth
KF_DIFFICULTY=
# 0 --> 4 waves, 1 --> 7 waves, 2 --> 10 waves
KF_GAME_LENGTH=
# Server Name
KF_SERVER_NAME=
# Game Password, Do not provide the parameter if you want no password
KF_GAME_PASS=
# Admin Name
KF_ADMIN_NAME=
# WebAdmin Password
KF_ADMIN_PASS=
# Admin E-Mail
KF_ADMIN_EMAIL=
# Message Of The Day - Shows when someone joins the server
KF_MOTD=
# Redirect URL, if not set, defaults to Skillzserver (Includes almost all KF1 Mods)
KF_REDIRECT=
# List of your mutators; seperated by commas and NO spaces -- It is recommended to use MutLoader to load your muts
KF_MUTATORS=
```

## Build Command

```bash
docker build -t kf1-docker .
```

## Run Command

- Replace the values in Parenthesis with your own values

Config directly as env vars:

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
        -e KF_REDIRECT=(redirect) \
        -e KF_MUTATORS=(mutators) \
        kf1-docker
```

<details>
  <summary>Copy/Paste (CLICK ME)</summary>

```bash
docker run -d --name kf1 -p 0.0.0.0:7707:7707/udp -p 0.0.0.0:7708:7708/udp -p 0.0.0.0:7717:7717/udp -p 0.0.0.0:28852:28852/udp -p 0.0.0.0:28852:28852/tcp -p 0.0.0.0:8075:8075/tcp -p 0.0.0.0:20560:20560/udp -p 0.0.0.0:20560:20560/tcp -v (your server folder):/home/steam/servers/kf -e STEAM_USER=(user) -e STEAM_PASSWORD=(pass) -e STEAM_CODE=(code) -e KF_MAP=KF-BioticsLab -e KF_DIFFICULTY=4 -e KF_GAME_LENGTH=2 -e KF_GAME_PASS=(pass) -e KF_SERVER_NAME='Killing Floor Server' -e KF_ADMIN_NAME=(name) -e KF_ADMIN_PASS=(pass) -e KF_ADMIN_EMAIL=(email) -e KF_MOTD=Welcome -e KF_REDIRECT=(redirect) -e KF_MUTATORS=(mutators) kf1-docker
```

</details>

or config taken from Env Var (see example env_file)

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
        --env-file=env_file \
        kf1-docker
```

<details>
  <summary>Copy/Paste (CLICK ME)</summary>

```bash
docker run -d --name kf1 -p 0.0.0.0:7707:7707/udp -p 0.0.0.0:7708:7708/udp -p 0.0.0.0:7717:7717/udp -p 0.0.0.0:28852:28852/udp -p 0.0.0.0:28852:28852/tcp -p 0.0.0.0:8075:8075/tcp -p 0.0.0.0:20560:20560/udp -p 0.0.0.0:20560:20560/tcp -v (your server folder):/home/steam/servers/kf -e STEAM_USER=(user) -e STEAM_PASSWORD=(pass) -e STEAM_CODE=(code) --env-file=env_file kf1-docker
```

</details>

## Useful docker commads

- Track installation/server setup after docker run command
  - `docker logs --follow kf1-docker`
