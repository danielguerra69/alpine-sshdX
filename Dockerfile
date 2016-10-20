FROM alpine:edge
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>

RUN apk add --update openssh util-linux dbus ttf-freefont xauth xf86-input-keyboard \
    && rm  -rf /tmp/* /var/cache/apk/*
ADD docker-entrypoint.sh /usr/sbin
ENTRYPOINT ["docker-entrypoint.sh"]
ENV QT_XKB_CONFIG_ROOT /usr/share/X11/locale
CMD ["/usr/sbin/sshd","-D"]
