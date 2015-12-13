FROM ubuntu:latest
MAINTAINER Patrick Double <pat@patdouble.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get -q update &&\
  apt-get -qy --force-yes dist-upgrade &&\
  apt-get install -qy --force-yes apt-utils forked-daapd avahi-daemon

RUN apt-get install -qy --force-yes build-essential git autotools-dev autoconf libtool gettext gawk gperf antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev libasound2-dev libmxml-dev libgcrypt11-dev libavahi-client-dev zlib1g-dev libevent-dev libcurl4-openssl-dev
  
RUN apt-get install -qy --force-yes wget &&\
  wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list &&\
  apt-get update &&\
  apt-get install -qy --force-yes python-spotify &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

RUN git clone https://github.com/ejurgensen/forked-daapd.git &&\
  cd forked-daapd &&\
  autoreconf -i &&\
  ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-spotify --enable-lastfm --enable-mpd &&\
  make &&\
  make install
  

VOLUME /log
VOLUME /cache
VOLUME /media
EXPOSE 3689

COPY forked-daapd.conf /etc/

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

CMD ["/start.sh"]

