#!/bin/sh

set -e

rm -rf /var/run/dbus.pid
mkdir -p /var/run/dbus
 
echo '1'
dbus-uuidgen --ensure
echo '2'
dbus-daemon --system

echo '3'
avahi-daemon --daemonize --no-chroot

echo '4'
python3 ./src/main.py --iface=wlp3s0
