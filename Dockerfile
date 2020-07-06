FROM ubuntu:20.04

ENV PATH $PATH:/root/.roswell/bin

WORKDIR /
RUN apt-get update \
	&& apt-get install -y git build-essential automake libcurl4-openssl-dev libcurl3-gnutls \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone -b v20.06.14.107 https://github.com/roswell/roswell.git

WORKDIR /roswell
RUN sh bootstrap \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

WORKDIR /
RUN ros setup

CMD ["ros", "run"]
