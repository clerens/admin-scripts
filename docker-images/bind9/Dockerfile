FROM alpine:latest

RUN apk update && apk add bind

RUN chown -R named:root /var/bind
RUN chown -R named:root /etc/bind

EXPOSE 53/udp 53/tcp 

CMD ["/usr/sbin/named", "-u", "named", "-g"]

#CMD ["/usr/sbin/named"]