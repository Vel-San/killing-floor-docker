![repo-size](https://img.shields.io/github/repo-size/vel-san/killing-floor-docker?label=Repo-Size&style=flat-square) [![contrib](https://img.shields.io/github/contributors/vel-san/killing-floor-docker?label=Contributors&style=flat-square)](https://github.com/Vel-San/killing-floor-docker/graphs/contributors) [![release](https://img.shields.io/github/v/release/vel-san/killing-floor-docker?label=Release&style=flat-square)](https://github.com/Vel-San/killing-floor-docker/releases) [![Docker](https://img.shields.io/badge/Docker%20Hub-White--Listed%20Vanilla-Blue?style=flat-square)](https://hub.docker.com/r/vel7an/kf1-docker)

[![CI: Build & Deploy to DockerHub](https://github.com/Vel-San/killing-floor-docker/actions/workflows/build_deploy.yml/badge.svg?branch=master)](https://github.com/Vel-San/killing-floor-docker/actions/workflows/build_deploy.yml) [![CI: Container Scanner](https://github.com/Vel-San/killing-floor-docker/actions/workflows/trivy-analysis.yml/badge.svg)](https://github.com/Vel-San/killing-floor-docker/actions/workflows/trivy-analysis.yml)

- [Killing Floor 1: Dockerized!](#killing-floor-1-dockerized)
  - [Important Notes](#important-notes)
    - [OSX 💻 Users](#osx--users)
    - [Multi-Server 🌩 support](#multi-server--support)
  - [Docker Run Variables](#docker-run-variables)
  - [Build Command](#build-command)
  - [Run Command](#run-command)
  - [Update the server](#update-the-server)
  - [Useful docker commads](#useful-docker-commads)

# Killing Floor 1: Dockerized!

## Important Notes

### OSX 💻 Users 

If, for any reason, you are encountering "Operation not permitted" issues while running, make sure you do the following:

1. In your Docker settings, disable/uncheck `Use gRPC FUSE for file sharing` and hit Restart to Apply changes
2. If the above doesn't solve your issue, go to your Machine Settings > Security & Privacy > Give `Full Disk Usage` to Docker.app (If this still doesn't work, give your terminal as well)

This should fix this issue 👍

____

### Multi-Server 🌩 support

In case you want to run more than 1 server (e.g. several containers), do not forget to change the exposed ports in the docker run command to match the following:

```
KF_GAME_PORT=
KF_QUERY_PORT=
KF_WEBADMIN_PORT=
```

Also, keep in mind to update the folder you are using for the mounted volume on your local

>-v (your server folder):/home/steam/servers/kf

And MOST IMPORTANT:

> DO NOT Forget to change your steam ports to "Ranged" ports e.g.
>
> 20560:20569 (udp+tcp)
>
> 28852:28859 (udp+tcp)
>
> 7707:7710 (udp) # This change is for the 7708 port, in case you're doing only 2x servers
>
> If you're running more than 2x servers, you need to keep incrementing your ports accordingly! +2 is optimal for all ports

You can run your containers using `--net=host`, or simply change the ports from the run command.

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

>NOTE: Removing variables or not putting any values will automatically use the default values, as found [HERE](https://github.com/Vel-San/killing-floor-docker/blob/master/scripts/kf1_functions.sh#L25)

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
# Number of Max Spectators that can be in your server
KF_SPECTATORS=
# Change ZED skins based on the special events
# Select 1 of the following:
# ET_None -- Default
# ET_SummerSideshow -- for the summer ZEDs
# ET_HillbillyHorror -- for the Halloween ZEDs
# ET_TwistedChristmas -- for the Christmas ZEDs
KF_SPECIMEN_EVENT_TYPE=
# List of your mutators; seperated by commas and NO spaces -- It is recommended to use MutLoader to load your muts
KF_MUTATORS=
# DO. NOT. TOUCH! Port variables if you don't know what you're doing!
# Game Port
KF_GAME_PORT=
# Query Port
KF_QUERY_PORT=
# WebAdmin Port
KF_WEBADMIN_PORT=
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
        -e KF_SPECTATORS=6 \
        -e KF_SPECIMEN_EVENT_TYPE=ET_None \
        -e KF_MUTATORS=(mutators) \
        -e KF_GAME_PORT=7707 \
        -e KF_QUERY_PORT=7717 \
        -e KF_WEBADMIN_PORT=8075
        kf1-docker
```

<details>
  <summary>Copy/Paste (CLICK ME)</summary>

```bash
docker run -d --name kf1 -p 0.0.0.0:7707:7707/udp -p 0.0.0.0:7708:7708/udp -p 0.0.0.0:7717:7717/udp -p 0.0.0.0:28852:28852/udp -p 0.0.0.0:28852:28852/tcp -p 0.0.0.0:8075:8075/tcp -p 0.0.0.0:20560:20560/udp -p 0.0.0.0:20560:20560/tcp -v (your server folder):/home/steam/servers/kf -e STEAM_USER=(user) -e STEAM_PASSWORD=(pass) -e STEAM_CODE=(code) -e KF_MAP=KF-BioticsLab -e KF_DIFFICULTY=4 -e KF_GAME_LENGTH=2 -e KF_GAME_PASS=(pass) -e KF_SERVER_NAME='Killing Floor Server' -e KF_ADMIN_NAME=(name) -e KF_ADMIN_PASS=(pass) -e KF_ADMIN_EMAIL=(email) -e KF_MOTD=Welcome -e KF_REDIRECT=(redirect) -e KF_SPECTATORS=6 -e KF_SPECIMEN_EVENT_TYPE=ET_None -e KF_MUTATORS=(mutators) -e KF_GAME_PORT=7707 -e KF_QUERY_PORT=7717 -e KF_WEBADMIN_PORT=8075 kf1-docker
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

## Update the server

Sometimes, you need to update SteamLibs or in general the server if needed. 

To do so, all you have to do is delete `Core.u` from your Volume/System/ and simply run the server as you usually do. If you use 2FA/Steam Guard, make sure to provide the proper code before running.

## Useful docker commads

- Track installation/server setup after docker run command
  - `docker logs --follow kf1-docker`
- Stop & remove server container
  - `docker stop $(docker ps -aq); docker rm -f Server_name_here`
