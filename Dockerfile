FROM linuxserver/wireguard:alpine

ENV HOSTNAME=wireguard-http-proxy

ENV TZ=Asia/Dhaka

ENV PEERS=false
ENV PUID=1000
ENV PGID=1000


RUN apk update && apk add --no-cache \
	tinyproxy \
	coreutils \
	dnsmasq \
	tini && \
	rm -rf /var/cache/apk/*

RUN mkdir -p /config/wg_confs /tinyproxy

COPY ./tinyproxy/tinyproxy.conf /tinyproxy/tinyproxy.conf

COPY ./start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 8888

ENTRYPOINT ["/sbin/tini", "-s", "./start.sh"]