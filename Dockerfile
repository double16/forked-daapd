FROM debian:sid
MAINTAINER Patrick Double <pat@patdouble.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get -q update &&\
  apt-get -qy --force-yes dist-upgrade &&\
  apt-get install -qy --force-yes forked-daapd avahi-daemon &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

VOLUME /log
VOLUME /cache
VOLUME /media
EXPOSE 3689

COPY forked-daapd.conf /etc/

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

CMD ["/start.sh"]

