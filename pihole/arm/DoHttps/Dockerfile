FROM balenalib/raspberrypi3-debian:sid-20220125

RUN apt-get update && apt install -y --no-install-recommends stubby ca-certificates dns-root-data ldnsutils libyaml-0-2

RUN set -e -x && \
    groupadd -r stubby && \
    useradd --no-log-init -r -g stubby stubby

EXPOSE 8053

USER stubby:stubby

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s CMD drill @127.0.0.1 -p 8053 cloudflare.com || exit 1

CMD ["/usr/bin/stubby", "-C", "/config/stubby.yml"]
