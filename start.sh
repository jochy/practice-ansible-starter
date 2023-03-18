#!/bin/sh

if [[ ! -f ssh_key/multipass-ssh-key ]]
then
    ssh-keygen -C vmuser -f ssh_key/multipass-ssh-key -N '' -q
    echo "\n      - $(cat ssh_key/multipass-ssh-key.pub)" >> cloud-init.yml
fi

echo "Removing previous vm"
multipass delete webserver database 2> /dev/null ; multipass purge

echo "Creating vm"
multipass launch --name webserver --cpus 1 --memory 1G --cloud-init cloud-init.yml
multipass launch --name database  --cpus 1 --memory 1G --cloud-init cloud-init.yml

echo "Extracting webserver ip"
IP=$(multipass info --format csv webserver | sed -n 2p | awk -F "\"*,\"*" '{print $3}')
echo $IP
sed "s/webserver.mhost.net/${IP}/g" hosts.yml.template > hosts.yml

echo "Extracting database ip"
IP=$(multipass info --format csv database | sed -n 2p | awk -F "\"*,\"*" '{print $3}')
echo $IP
sed "s/database.mhost.net/${IP}/g" hosts.yml > tmp.yml

echo "Writing hosts.yml for Ansible with the right ips"
rm hosts.yml
mv tmp.yml hosts.yml

ansible-galaxy install -r requirements.yml
