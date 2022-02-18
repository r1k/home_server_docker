Install Homebridge WOL

docker exec -it homebridge /bin/bash

# generate key and write to /homebridge/id_rsa
ssh-keygen -t rsa -b 4096
chown abc:abc id_rsa*
chmod 400 id_rsa*

ssh-copy-id -i /homebridge/id_rsa.pub <pc to shutdown>

set shutdown command to 

ssh -oStrictHostKeyChecking=no -i /homebridge/id_rsa rk@192.168.221.2 'sudo shutdown -h now'

