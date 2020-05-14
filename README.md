# Docker-kf-1

This is a dockerized version of a Killing-Floor 1 dedicated server

## Current (and future) variables

```docker
# Used for building only - Steam Username
ARG steamU=anonymous
# Used for building only - Steam Password
ARG steamP=""
# Used for building only - 2FA Code
ARG code=""
# Server Name
ARG serverN=""
# Server Admin
ARG adminN=""
# Server Adming E-mail
ARG adminE=""
# Server Admin Password
ARG adminP=""
# Server Message of the day, shows when you join a match
ARG motd=""
# Server redirectURL
ARG redirect=""
```
