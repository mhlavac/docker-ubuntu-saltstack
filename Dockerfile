FROM ubuntu:16.04
MAINTAINER Martin Hlavac <info@mhlavac.net>

# locales fix
RUN \
    locale-gen en_US.UTF-8 && \
    localedef en_US.UTF-8 -i en_US -fUTF-8 && \
    dpkg-reconfigure locales && \
    echo "LANG=en_US.UTF-8" >> /etc/default/locale && \
    echo "LANGUAGE=en_US.UTF-8" >> /etc/default/locale && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale && \
    export LANG=en_US.UTF-8 && \
    export LANGUAGE=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    LANG=en_US.UTF-8 && \
    LANGUAGE=en_US.UTF-8 && \
    LC_ALL=en_US.UTF-8 && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "it_IT.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "nl_NL.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

# UTC timezone
RUN \
    echo "UTC" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata && \
    cp /etc/timezone /tz/ && cp /etc/localtime /tz/

# All apt-gets, we have to install some first to get apt-add-repository command
RUN \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y syslinux-common python-software-properties software-properties-common python-git salt-minion && \
    mkdir -p /srv

# Clear some caches
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/*

CMD ["/bin/bash"]
