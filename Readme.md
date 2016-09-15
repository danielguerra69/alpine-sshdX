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
terminal. See note Xquartz

ssh to your new container
```bash
ssh -i id_rsa -p 4848 -X root@<dockerhost>
```

For ssh key forwarding use ssh-agent
```bash
ssh-agent
ssh-add id_rsa
ssh -A -p 4848 -X root@<dockerhost>
ssh -C -A -t -X -p 4848  root@<dockerhost> ssh -C -A -t -X -p 777 root@<hop> firefox
```
in the last example the each hop must have the same authorized_keys.

# Xquartz note
For cmd+v cmd+c e.g. copy/paste to work you need to do this on your mac.
```bash
cd ~/
vi .Xdefaults
```

paste this line (without the quotes)

`*VT100.translations: #override  Meta <KeyPress> V:  insert-selection(PRIMARY, CUT_BUFFER0) \n`

esc :wq

Then
```bash
xrdb -merge ~/.Xdefaults
```
restart Xquartz and cmd+c and cmd+v works.
