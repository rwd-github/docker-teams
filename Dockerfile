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

RUN apt-get update && apt-get upgrade -y \
	&& apt-get install -y \
	gpg \
	xterm \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	hicolor-icon-theme \
	libcanberra-gtk* \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpango1.0-0 \
	libpulse0 \
	libv4l-0 \
	fonts-symbola \
	--no-install-recommends 

ADD https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb /root/teams.deb
RUN	dpkg -i /root/teams.deb || true \
	&& apt-get -f -y install

RUN	apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh


#RUN unlink /etc/localtime \
#	&& ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

ADD createuser.sh /root/createuser.sh
RUN chmod +x /root/createuser.sh


#RUN groupadd --gid 1000 user && \
#        useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash user
##RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

VOLUME [ "/home" ]
#USER user

ENTRYPOINT [ "/entrypoint.sh" ]
