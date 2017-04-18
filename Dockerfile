FROM debian:jessie
MAINTAINER idk <problemsolver@openmailbox.org>

RUN apt-get update && apt-get dist-upgrade

RUN echo "deb https://cmotc.github.io/apt-now/debian unstable main" | tee /etc/apt/sources.list.d/cmotc.github.io.list
RUN wget -qO - https://cmotc.github.io/apt-now/cmotc.github.io.gpg.key | apt-key add -

RUN apt-get update
RUN apt-get install apt-now pkpage scpage mini-httpd
