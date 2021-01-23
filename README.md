DEPRECATED moved to: https://gitlab.com/ytdocker/collection

# docker-teams

docker-compose
```
version: "2.2"

services:
  teams:
    image: rwd1/teams
    container_name: teams
    environment:
      - DISPLAY=$DISPLAY
      - TEAMS_USERNAME=user1
#      - TEAMS_UID=3001           # default= 1000
#      - TEAMS_GID=4001           # default= 1000
#      - TEAMS_TIMEZONE=Etc/UTC   # default= Europe/Berlin
#      - TEAMS_LOCALE=en_US.UTF-8 # default= de_DE.UTF-8
      - TEAMS_INSIDERS=false
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix
      - [PATHTOHOMEDIR] :/home
#      - /dev/shm:/dev/shm
      - /dev/snd:/dev/snd
    shm_size: 1gb
    cpuset: "0"
#    devices:
#      - /dev/snd:/dev/snd
    privileged: true


```


Note --device /dev/snd in Docker 1.8, before that you needed 
-v /dev/snd:/dev/snd --privileged


## Resources
https://docs.microsoft.com/en-us/microsoftteams/get-clients#linux
