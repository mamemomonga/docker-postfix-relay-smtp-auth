FROM debian:jessie

RUN set -xe && \
        rm /etc/localtime && \
        ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
        echo 'Asia/Tokyo' > /etc/timezone

RUN set -xe && \
        apt-get update && \
        apt-get install -y postfix sasl2-bin rsyslog && \
		rm -rf /var/lib/apt/lists/*

ADD assets/ /

ENTRYPOINT ["/entrypoint.sh"]

