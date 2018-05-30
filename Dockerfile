FROM alpine:latest

ENV ADMINER_VERSION 4.3.1

ENV UID 1000
ENV GID 1000
ENV USER htpc
ENV GROUP htpc

RUN addgroup -S ${GROUP} && adduser -D -S -u ${UID} ${USER} ${GROUP} && \
    echo "@community http://dl-4.alpinelinux.org/alpine/latest-stable/community/" >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add --no-cache \
        wget \
        ca-certificates \
        php7@community \
        php7-session \
        php7-mysqli \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite && \
    wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /srv/index.php && \
    chown -R ${USER}:${GROUP}  /srv/  && \
    apk del wget ca-certificates 

WORKDIR /srv/

EXPOSE 8080

LABEL url=https://github.com/vrana/adminer/
LABEL version=${ADMINER_VERSION}

USER ${USER}

CMD /usr/bin/php -S 0.0.0.0:8080
