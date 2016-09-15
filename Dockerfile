FROM alpine:edge
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>

RUN apk add --update openssh util-linux dbus ttf-freefont xauth \
    && rm  -rf /tmp/* /var/cache/apk/*
ADD docker-entrypoint.sh /usr/sbin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
