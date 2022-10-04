FROM ubuntu:14.04

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2

RUN apt-get update && \
    apt-get --force-yes -y install \
    apache2 \
    dos2unix \
    libc-dev \
    git \
    libc6 \
    libc6-dev \
    libssl-dev \
    wget \
    socat \
    netcat \
    gcc \
    vim \
    software-properties-common \
    build-essential \
    python \
    curl

RUN sudo chmod u+s /usr/bin/find
RUN sudo chmod u+s /usr/bin/vim
RUN sudo chmod u+s /bin/cp
RUN sudo chmod u+s /bin/mv

RUN mkdir /var/run/apache2

ADD cgi-bin/shockme.cgi /usr/lib/cgi-bin/
ADD cgi-bin/sophyslair.cgi /usr/lib/cgi-bin/
ADD escape.sh /
RUN chmod +x /usr/lib/cgi-bin/shockme.cgi
RUN chmod +x escape.sh

RUN a2enmod cgid

# Install vulnerable bash
RUN wget --no-check-certificate https://ftp.gnu.org/gnu/bash/bash-4.3.tar.gz && \
    tar zxvf bash-4.3.tar.gz && \
    cd bash-4.3 && \
    ./configure && \
    make && \
    make install
RUN mkdir /usr/share/shellshock
WORKDIR /usr/share/shellshock

RUN wget https://storageaccountvseeast.blob.core.windows.net/spenblob/exploit-1.c
RUN wget https://storageaccountvseeast.blob.core.windows.net/spenblob/exploit-2.c

RUN useradd -d /home/sophy \
    -ms /usr/local/bin/bash \
    -p "$(openssl passwd -1 -salt salt intelix)" sophy
RUN usermod -aG sudo sophy && echo "sophy ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sophy
ADD the_game_begins.txt /home/sophy/

EXPOSE 80


ENTRYPOINT ["/usr/sbin/apache2"]

CMD ["-D", "FOREGROUND"]
