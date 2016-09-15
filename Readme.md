# About this container

This an alpine sshd container made for X forwarding.
Start a local X-server. On mac you can use XQuartz.
Ssh into the container and run your favorite alpine
x-app (e.g. firefox) and see it on your local machine.

# Usage key based

For key based authentication create a volume to keep
authorized_keys.
```bash
tar cv --files-from /dev/null | docker import - scratch
docker create -v /root/.ssh --name ssh-container scratch /bin/true
docker cp id_rsa.pub ssh-container:/root/.ssh/authorized_keys
```

Then the sshd service
```bash
docker run -p 4848:22 --name alpine-sshdx --hostname alpine-sshdx --volumes-from ssh-container  -d danielguerra/alpine-sshdx
```

# Usage password

Didn't want key based set a password for root.
```bash
docker run -p 4848:22 --name alpine-sshdx --hostname alpine-sshdx -d danielguerra/alpine-sshdx
docker exec -ti alpine-sshdx passwd
```

# On you workstation

After this from your linux
X environment or from the Xquartz
terminal.

ssh to your new container
```bash
ssh -i id_rsa -p 4848 -X root@<dockerhost>
```

Inside the new docker container

I used firefox, wireshark as example
```bash
apk --update add firefox-esr wireshark
firefox &
wireshark
```

Alpine firefox/wireshark runs in your X now.
