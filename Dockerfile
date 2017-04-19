FROM debian:stretch
MAINTAINER idk <problemsolver@openmailbox.org>

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y apt-transport-https wget curl gnupg2 apt-utils dpkg-sig reprepro git apg

RUN echo "deb https://cmotc.github.io/apt-now/debian rolling main" | tee /etc/apt/sources.list.d/cmotc.github.io.list
RUN echo "deb-src https://cmotc.github.io/apt-now/debian rolling main" | tee -a /etc/apt/sources.list.d/cmotc.github.io.list
RUN wget -qO - https://cmotc.github.io/apt-now/cmotc.github.io.gpg.key | apt-key add -

RUN apt-get update
RUN apt-get install -y apt-now pkpage scpage mini-httpd devscripts debhelper
RUN apt-get build-dep -y apt-now pkpage scpage



RUN addgroup apt-now && adduser --system --home "/home/apt-now" --ingroup apt-now --disabled-login apt-now \
    && mkdir -p  /home/apt-now/packages /home/gpg/ \
    && chown -R apt-now:apt-now "/home/apt-now" "/home/gpg"

COPY aptnow.conf /home/apt-now/
COPY gpg.file /home/gpg
COPY gpg.file2 /home/gpg

RUN chown apt-now:apt-now /home/apt-now/aptnow.conf /home/gpg/gpg.file /home/gpg/gpg.file2
USER apt-now
RUN cd /home/gpg/ && echo Passphrase: $(apg -n 1) | tee -a gpg.file && \
   cat gpg.file gpg.file2 > gpg.batch && cat gpg.batch && gpg --gen-key --batch gpg.batch

RUN cd /home/apt-now/packages/ && apt-get source apt-now pkpage scpage
RUN cd /home/apt-now/packages/ && for folder in $(find -type d -maxdepth 1); do \
   cd $folder; \
   debuild -us -uc; \
   cd /home/apt-now/packages; \
   done

RUN cd /home/apt-now/ && apt-now

USER root

RUN cat /etc/mini-httpd.conf

CMD [mini_httpd, -d, /home/apt-now/]
