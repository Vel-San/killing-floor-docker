- [Docker-kf-1](#docker-kf-1)
  - [Current (and future) variables](#current-and-future-variables)
    - [Build Vars](#build-vars)
    - [Run Vars](#run-vars)
  - [Build Command](#build-command)
  - [Run Command](#run-command)
    - [Start the server](#start-the-server)
    - [Finalized RUN Command](#finalized-run-command)

# Docker-kf-1

This is a dockerized version of a Killing-Floor 1 dedicated server

## Current (and future) variables

### Build Vars

```Dockerfile
# Used for building only - Steam Username
ARG steamU=""
# Used for building only - Steam Password
ARG steamP=""
# Used for building only - 2FA Code - Please try to put a code the was newly generated or it won't last untill the image is pulled
ARG code=""
```

### Run Vars

```bash
# Map Name
KF_MAP=
# 1 Begginer, 2 Normal, 4 Hard, 5 Suicidal, 7 Hell On Earth
KF_DIFFICULTY=
# 0 - 4 waves, 1 - 7 waves, 2 - 10 waves
KF_GAME_LENGTH=
# Server Name
KF_SERVER_NAME=
# Admin Name
KF_ADMIN_NAME=
# WebAdmin Password
KF_ADMIN_PASS=
# Admin E-Mail
KF_ADMIN_EMAIL=
# Message Of The Day - Shows when someone joins the server
KF_MOTD=
```

## Build Command

Put your password inside the hyphons to avoid any errors from bash, e.g 'password'

```bash
docker build -t vel-san/killing-floor --build-arg steamU=... --build-arg steamP=... --build-arg code=... .
```

## Run Command

### Start the server

- Edit `env_file` to your own custom vars
    >`bash run_docker.sh` or double click it!

### Finalized RUN Command

```bash
docker run --rm -it --name kf1-docker -p 0.0.0.0:7707:7707/udp -p 0.0.0.0:7708:7708/udp -p 0.0.0.0:7717:7717/udp -p 0.0.0.0:28852:28852/udp -p 0.0.0.0:8075:8075/tcp -p 0.0.0.0:20560:20560/udp --env-file=env_file vel-san/killing-floor
```
