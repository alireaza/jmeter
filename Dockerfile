FROM openjdk:17.0.2-jdk-slim-buster

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
wget ca-certificates gnupg2 \
tzdata \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN mkdir /jmeter \
&& wget -O - https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.3.tgz | tar xzf - -C "/jmeter" --strip-components=1

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
libxext-dev \
libfontconfig1 libxrender1 \
libxtst-dev

ENV PATH $PATH:/jmeter/bin

ARG UNAME=udocker
ARG UID=1000
ARG GNAME=$UNAME
ARG GID=1000
ARG GROUPS=$GNAME

RUN groupadd -g $GID $GNAME \
&& useradd --create-home -d /home/$UNAME -g $GID -u $UID $UNAME \
&& usermod -a -G $GROUPS $UNAME
USER $UNAME
WORKDIR /home/$UNAME

ENTRYPOINT ["/jmeter/bin/jmeter"]

