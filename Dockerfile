FROM alpine:latest

ENV ADMINER_VERSION 4.3.1


ENV UID 1000
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
        php7-mysqli && \
    wget https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -O /srv/index.php && \
    apk del wget ca-certificates && \

WORKDIR srv

EXPOSE 80

USER ${USER}

CMD /usr/bin/php -S 0.0.0.0:80
