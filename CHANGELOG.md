# v3.6 ( June 13 - 2020 )

- Updated all scripts with better debugging
- Updated docker image in docker hub (Increased in size, too)
- Added some critical notes regarding OSX users

## v3.5 ( June 13 - 2020 )

- Enhancement PR From @jdbrowndev includes the following changes:
  - Server install is done at run time instead of build time. This keeps the docker image small and allows you to easily tweak the server files post-install using a docker volume.
  - Custom maps and mutators have been removed to provide a vanilla install. These customizations can be added post-install.
