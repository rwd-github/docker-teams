FROM ubuntu:18.04 as sysbase

# Set the locale
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y locales tzdata
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y \
	gpg \
	xterm \
	apt-transport-https \
	ca-certificates \
	curl \
	wget \
	gnupg \
	libsecret-1-0 \
	hicolor-icon-theme \
	libcanberra-gtk* \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpango1.0-0 \
	libpulse0 \
	libv4l-0 \
	fonts-symbola 
#	bluez bluez-cups bluez-obexd \
#	pulseaudio pulseaudio-module-bluetooth pulseaudio-utils 
#	--no-install-recommends 

ADD https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb /root/teams.deb
RUN	dpkg -i /root/teams.deb || true \
	&& apt-get -f -y install \
	&& apt-get update && apt-get install -y teams-insiders

RUN	apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ADD createuser.sh /root/createuser.sh
RUN chmod +x /root/createuser.sh

ENV TEAMS_USERNAME=teamsuser
ENV TEAMS_UID=1000
ENV TEAMS_GID=1000
ENV TEAMS_TIMEZONE=Europe/Berlin
ENV TEAMS_LOCALE=de_DE.UTF-8
ENV TEAMS_INSIDERS=true

VOLUME [ "/home" ]

ENTRYPOINT [ "/entrypoint.sh" ]
