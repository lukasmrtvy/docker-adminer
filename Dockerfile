FROM alpine:latest

ENV VERSION=4.3.1

RUN apk update && apk upgrade && \
    apk add \
        wget \
        ca-certificates \
        php7@community \
        php7-session \
        php7-mysqli && \
    wget https://github.com/vrana/adminer/releases/download/v$VERSION/adminer-$VERSION.php -O /srv/index.php && \
    apk del wget ca-certificates && \
    rm -rf /var/cache/apk/*

WORKDIR srv

EXPOSE 80

CMD /usr/bin/php -S 0.0.0.0:80
