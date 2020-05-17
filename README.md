- [Docker-kf-1](#docker-kf-1)
  - [Current (and future) variables](#current-and-future-variables)
    - [Build Vars](#build-vars)
    - [Run Vars](#run-vars)
  - [Build Command](#build-command)
  - [Run Command](#run-command)

# Docker-kf-1

This is a dockerized version of a Killing-Floor 1 dedicated server

## Current (and future) variables

### Build Vars

```Dockerfile
# Used for building only - Steam Username
ARG steamU=anonymous
# Used for building only - Steam Password
ARG steamP=""
# Used for building only - 2FA Code
ARG code=""
```

### Run Vars

```bash
# Server Name
serverN=""
# Server Admin
adminN=""
# Server Adming E-mail
adminE=""
# Server Admin Password
adminP=""
# Server Message of the day, shows when you join a match
motd=""
# Server redirectURL
redirect=""
```

## Build Command

```bash
docker build -t vel-san/killing-floor --build-arg steamU=... --build-arg steamP=... --build-arg code=... .
```

## Run Command

> To Be Filled Later
