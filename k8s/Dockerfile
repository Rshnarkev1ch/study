

FROM ubuntu:22.04

ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update
RUN apt-get -y install apache2
RUN apt-get -y install php

COPY ./index.php /var/www/html/index.php
