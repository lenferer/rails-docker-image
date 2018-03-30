FROM ruby:2.4

############################
########## LOCALE ##########
############################
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

ENV CONTAINER_LOCALE en_US
RUN sed -i -e "s/# ${CONTAINER_LOCALE}.UTF-8 UTF-8/${CONTAINER_LOCALE}.UTF-8 UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=${CONTAINER_LOCALE}.UTF-8

ENV LANG ${CONTAINER_LOCALE}.UTF-8

############################
########## NODEJS ##########
############################
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

##########################
########## YARN ##########
##########################
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

##########################
########## GOSU ##########
##########################
ENV GOSU_VERSION 1.10
RUN set -ex; \
  \
  fetchDeps=' \
    ca-certificates \
    wget \
  '; \
  apt-get update; \
  apt-get install -y --no-install-recommends $fetchDeps; \
  rm -rf /var/lib/apt/lists/*; \
  \
  dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
  \
# verify the signature
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
  gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
  rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
  \
  chmod +x /usr/local/bin/gosu; \
# verify that the binary works
  gosu nobody true; \
  \
  apt-get purge -y --auto-remove wget

#################################
########## ImageMagick ##########
#################################

RUN apt-get update && \
    apt-get install -y imagemagick libmagickcore-dev libmagickwand-dev
ENV PATH /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/:${PATH}

##########################
####### PHANTOMJS ########
##########################

RUN apt-get update && \
    apt-get install -y wget build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev

RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
    tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/ && \
    ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm phantomjs-2.1.1-linux-x86_64.tar.bz2

##########################
########## REST ##########
##########################

ADD inputrc /etc/skel/.inputrc
