# docker-teams

* under construction
* no audio



```
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v PATHTOHOMEFOLDERS:/home \
	--shm-size="1gb" \
	rwd1/teams
```


mount dir with one or more homefolder. 
Create a file ".mypass" with prehashed password. 
mkpasswd -m sha-512
