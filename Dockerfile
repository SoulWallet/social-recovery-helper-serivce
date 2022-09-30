FROM ubuntu:22.04

RUN set -ex \
    && apt -y update \
    && apt -y upgrade

# install node v16
RUN set -ex \
    && apt -y install curl wget\
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt -y install nodejs \
    && npm install pm2@latest -g

COPY ./package.json /root/dist/package.json

RUN set -ex \
    && cd /root/dist/;npm install

COPY ./start.sh /root/start.sh
RUN set -ex \
    && chmod +x /root/start.sh


RUN set -ex \
    && chmod +x /root/start.sh \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
    

COPY ./dist /root/dist

ENTRYPOINT ["/root/start.sh"]