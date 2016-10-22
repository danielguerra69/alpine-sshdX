#!/bin/sh
# generate fresh rsa key
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa

# generate fresh dsa key
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

#prepare run dir
mkdir -p /var/run/sshd

#prepare sshd config
 sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
 && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
 && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
 && sed -i "s/#AuthorizedKeysFile/AuthorizedKeysFile/g" /etc/ssh/sshd_config \
 && sed -i "s/#X11Forwarding no/X11Forwarding yes/g" /etc/ssh/sshd_config \
 && sed -i "s/#PermitUserEnvironment no/PermitUserEnvironment yes/g" /etc/ssh/sshd_config \
 && echo "ForwardX11Trusted yes" >> /etc/ssh/ssh_config

#prepare xauth
touch /root/.Xauthority

# generate machine-id
uuidgen > /etc/machine-id

# set keyboard for all sh users
echo "export QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /etc/profile
# set keyboard for direct command use
echo "QT_XKB_CONFIG_ROOT=/usr/share/X11/locale" >> /root/.ssh/environment

source /etc/profile

exec "$@"
