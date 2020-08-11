FROM mikebrady/shairport-sync
FROM ubuntu

#!/usr/bin/env bash
#make sure the vagrant user is in the audio group
# RUN usermod -a -G audio vagrant

#install the newest alsa kernel modules
# RUN apt-add-repository ppa:ubuntu-audio-dev/alsa-daily
RUN apt-get -qq update
# RUN apt-get install oem-audio-hda-daily-dkms

#reload sound module
# RUN modprobe snd-hda-intel

# RUN apt-get install -yq git wget autoconf libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev alsa-utils
RUN apt-get -yqq install git

#also do https://wiki.ubuntuusers.de/Soundkarten_konfigurieren/HDA?redirect=no
# RUN apt-get remove --purge alsa-base pulseaudio
# RUN apt-get install alsa-base pulseaudio
# RUN alsa force-reload
# RUN echo "options snd-hda-intel model=3stack" | tee -a /etc/modprobe.d/alsa-base.conf

COPY . .
#install python dependencies
RUN apt-get install -yqq python3-dev python3-pip flac libflac-dev
RUN pip3 install -r requirements.txt

RUN apt-get -yqq autoremove

CMD python3 src/main.py
