![repo-size](https://img.shields.io/github/repo-size/vel-san/killing-floor-docker?label=Repo-Size&style=flat-square) [![contrib](https://img.shields.io/github/contributors/vel-san/killing-floor-docker?label=Contributors&style=flat-square)](https://github.com/Vel-San/killing-floor-docker/graphs/contributors) [![release](https://img.shields.io/github/v/release/vel-san/killing-floor-docker?label=Release&style=flat-square)](https://github.com/Vel-San/killing-floor-docker/releases) [![Docker](https://img.shields.io/badge/Docker%20Hub-White--Listed%20Vanilla-Blue?style=flat-square)](https://hub.docker.com/r/vel7an/kf1-docker)

- [killing-floor1-docker](#killing-floor1-docker)
  - [Docker Run Variables](#docker-run-variables)
  - [Build Command](#build-command)
  - [Run Command](#run-command)
  - [Useful docker commads](#useful-docker-commads)

# killing-floor1-docker

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
# Mutators to be enabled by default on server startup; sepereate by a Comma
# Use docker volume to modify and edit your mutators/maps @todo Document this more for noobies
KF_MUTATORS=
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
```

## Build Command

```bash
docker build -t kf1-docker .
```

## Run Command

- Replace the values in parens with your own values

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
        kf1-docker
```

<details>
  <summary>Copy/Paste</summary>

```bash
docker run -d --name kf1 -p 0.0.0.0:7707:7707/udp -p 0.0.0.0:7708:7708/udp -p 0.0.0.0:7717:7717/udp -p 0.0.0.0:28852:28852/udp -p 0.0.0.0:28852:28852/tcp -p 0.0.0.0:8075:8075/tcp -p 0.0.0.0:20560:20560/udp -p 0.0.0.0:20560:20560/tcp -v (your server folder):/home/steam/servers/kf -e STEAM_USER=(user) -e STEAM_PASSWORD=(pass) -e STEAM_CODE=(code) -e KF_MAP=KF-BioticsLab -e KF_DIFFICULTY=4 -e KF_GAME_LENGTH=2 -e KF_GAME_PASS=(pass) -e KF_SERVER_NAME='Killing Floor Server' -e KF_ADMIN_NAME=(name) -e KF_ADMIN_PASS=(pass) -e KF_ADMIN_EMAIL=(email) -e KF_MOTD=Welcome kf1-docker
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
  <summary>Copy/Paste</summary>

```bash
docker run -d --name kf1 -p 0.0.0.0:7707:7707/udp -p 0.0.0.0:7708:7708/udp -p 0.0.0.0:7717:7717/udp -p 0.0.0.0:28852:28852/udp -p 0.0.0.0:28852:28852/tcp -p 0.0.0.0:8075:8075/tcp -p 0.0.0.0:20560:20560/udp -p 0.0.0.0:20560:20560/tcp -v (your server folder):/home/steam/servers/kf -e STEAM_USER=(user) -e STEAM_PASSWORD=(pass) -e STEAM_CODE=(code) --env-file=env_file kf1-docker
```

</details>

## Useful docker commads

- Track installation/server setup after docker run command
  - `docker logs --follow kf1-docker`
