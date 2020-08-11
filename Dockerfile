FROM python:3

COPY requirements.txt .
RUN apt-get -yyqq update && \
	apt-get -yyqq install \
	python3-dev \
	python3-pip \
	flac \
	libflac-dev \
	shairport-sync \
&& pip3 install -r requirements.txt
RUN apt-get -yqq autoremove

COPY . .

CMD [ "bash", "./start.sh"]
