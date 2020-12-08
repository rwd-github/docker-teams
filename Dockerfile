FROM ubuntu:18.04 as sysbase
ARG TEAMS_VERSION=1.3.00.25560

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
	fonts-symbola \
	xdg-utils firefox \
	bluez bluez-cups bluez-obexd \
	pulseaudio pulseaudio-module-bluetooth pulseaudio-utils 
#	--no-install-recommends 

ADD https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb /root/teams.deb
RUN	dpkg -i /root/teams.deb || true \
	&& apt-get -f -y install \
	&& apt-get update \
	&& apt-cache policy teams teams-insiders \
	&& TEAMS_VER=${TEAMS_VERSION} && if [ -n ${TEAMS_VER} ]; then TEAMS_VER="=${TEAMS_VER}"; fi && echo TEAMS_VER=${TEAMS_VER} \
	&& apt-get install -y --allow-downgrades teams${TEAMS_VER} teams-insiders${TEAMS_VER}

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
