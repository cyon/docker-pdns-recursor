FROM alpine:3.8

ENV PDNS_INCLUDE_DIR /etc/pdns/conf.d

RUN apk --update --no-cache add \
        bash \
        tini \
        pdns-recursor

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

CMD ["pdns_recursor", "--disable-syslog=yes", "--daemon=no", "--local-address=0.0.0.0"]
