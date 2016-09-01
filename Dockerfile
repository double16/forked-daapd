FROM blitznote/debootstrap-amd64:16.04
MAINTAINER Patrick Double <pat@patdouble.com>

RUN apt-get -q update &&\
  apt-get install -qy forked-daapd avahi-daemon &&\
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

