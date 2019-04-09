FROM evserykh/rails:ruby2.6.2

##########################
####### CHROME ########
##########################
RUN apt-get update -qqy && apt-get -qqy install xvfb xdg-utils fonts-liberation libappindicator3-1 libasound2 libnspr4 libnss3 libxss1

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u11_amd64.deb
RUN dpkg -i libssl1.0.0_1.0.1t-1+deb8u11_amd64.deb

RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl-dev_1.0.1t-1+deb8u11_amd64.deb
RUN dpkg -i libssl-dev_1.0.1t-1+deb8u11_amd64.deb

RUN wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
RUN mkdir /opt/firefox
RUN tar xjf FirefoxSetup.tar.bz2 -C /opt/firefox/
RUN ln -s /opt/firefox/firefox/firefox /usr/local/sbin
