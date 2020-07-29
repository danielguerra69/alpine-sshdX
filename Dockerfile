FROM alpine:3.8
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>

RUN apk add --update openssh util-linux dbus ttf-freefont xauth xf86-input-keyboard sudo \
&& rm  -rf /tmp/* /var/cache/apk/*

RUN cp -r /etc/ssh /ssh_orig
RUN rm -rf /etc/ssh/*

ADD etc /etc
ADD docker-entrypoint.sh /usr/local/bin

RUN addgroup alpine
RUN adduser  -G alpine -s /bin/sh -D alpine
RUN echo "alpine:alpine" | /usr/sbin/chpasswd

VOLUME ["/etc/ssh","/home/alpine"]

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd","-D"]
