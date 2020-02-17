FROM ubuntu:18.04 as sysbase

# Set the locale
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y locales \
	&& locale-gen de_DE.UTF-8 en_US.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8
ENV DEBIAN_FRONTEND noninteractive

ADD https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb /root/

RUN apt-get update && apt-get upgrade -y \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#	&& apt-get install -y \
#	tmux \

#RUN unlink /etc/localtime \
#	&& ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

VOLUME [ "/home" ]

