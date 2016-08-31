FROM webhippie/php-caddy:latest

VOLUME ["/storage", "/opt/invoiceninja/vendor"]

CMD ["/bin/s6-svscan", "/etc/s6"]
EXPOSE 8080
WORKDIR /opt/invoiceninja

RUN apk update && \
  apk add \
    git \
    php5-apcu \
    sqlite&& \
  rm -rf \
    /var/cache/apk/*

ENV INVOICENINJA_VERSION 2.6.10
ENV INVOICENINJA_TARBALL https://github.com/invoiceninja/invoiceninja/archive/v${INVOICENINJA_VERSION}.tar.gz

RUN curl -sLo - \
  ${INVOICENINJA_TARBALL} | tar -xzf - --strip 1 -C /opt/invoiceninja

ADD rootfs /
