FROM debian
ENV TZ=UTC

RUN DEBIAN_FRONTEND=noninteractive \
	TZ=AMERICA/EDMONTON \
	apt-get -yyqq update && \
	apt-get -yyqq install \
	avahi-daemon \
	avahi-discover \
	avahi-utils \
	libnss-mdns \
	dnsutils \
	git \
	python3-dev \
	python3-pip \
	flac \
	libflac-dev \
	shairport-sync
COPY . .
RUN pip3 install -r requirements.txt

RUN apt-get -yqq autoremove

CMD /etc/init.d/dbus start && \
	/etc/init.d/avahi-daemon start && \
	python3 src/main.py --iface=wlp3s0
