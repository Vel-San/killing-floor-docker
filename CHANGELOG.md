# v3.9 ( August 30 - 2021 )

- [feature] Added KF_SPECIMEN_EVENT_TYPE to control ZED skins based on special event types

## v3.8 ( August 30 - 2021 )

- [feature] Added KF_SPECTATORS to modify number of spectators in the server

## v3.7 ( August 22 - 2021 )

- [fix] Wrong paths for steam libs

## v3.6 ( August 21 - 2021 )

- [misc] Updated all scripts with better debugging
- [docker] Updated docker image in docker hub (Increased in size, too)
- [documentation] Added some critical notes regarding OSX users

## v3.5 ( June 13 - 2020 )

- Enhancement PR From @jdbrowndev includes the following changes:
  - Server install is done at run time instead of build time. This keeps the docker image small and allows you to easily tweak the server files post-install using a docker volume.
  - Custom maps and mutators have been removed to provide a vanilla install. These customizations can be added post-install.
