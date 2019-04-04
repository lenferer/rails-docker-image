FROM evserykh/rails:ruby2.6.2

##########################
####### CHROME ########
##########################
RUN apt-get update -qqy && apt-get -qqy install xvfb xdg-utils fonts-liberation libappindicator3-1 libasound2 libnspr4 libnss3 libxss1

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN wget http://ftp.br.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb7u4_amd64.deb
RUN dpkg -i libssl1.0.0_1.0.1t-1+deb7u4_amd64.deb

RUN wget http://ftp.br.debian.org/debian-security/pool/updates/main/o/openssl/libssl-dev_1.0.1t-1+deb7u4_amd64.deb
RUN dpkg -i libssl-dev_1.0.1t-1+deb7u4_amd64.deb