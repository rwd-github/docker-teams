# docker-teams

* under construction
* no audio



```
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v PATHTOHOMEFOLDERS:/home \
    --cpuset-cpus 0 \
    --device /dev/snd \
    -v /dev/shm:/dev/shm \
    --net=host \
	rwd1/teams
#	--shm-size="1gb" \

```



Note  for --device /dev/snd in Docker 1.8, before that you needed -v /dev/snd:/dev/snd --privileged.


mount dir with one or more homefolder. 
Create a file ".mypass" with prehashed password. 
mkpasswd -m sha-512
