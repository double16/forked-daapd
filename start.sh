#!/bin/bash

if [ -n "$PUID" -a "$(id -u daapd)" != "$PUID" ]; then usermod -o -u "$PUID" daapd ; fi

mkdir -p /log/forked-daapd /cache/forked-daapd
chown -R daapd /log/forked-daapd /cache/forked-daapd
chmod -R u+rw /log/forked-daapd /cache/forked-daapd

sed -i -e "s/name = \"Music Server\"/name = \"${MUSIC_SERVER_NAME:-Music Server}\"/" /etc/forked-daapd.conf
sed -i -e "s:/media:${MUSIC_SERVER_DATA:-/media}:" /etc/forked-daapd.conf

/etc/init.d/dbus start
/usr/sbin/avahi-daemon --no-chroot -D
/usr/sbin/forked-daapd -f -c /etc/forked-daapd.conf
/usr/sbin/avahi-daemon -k
/etc/init.d/dbus stop

