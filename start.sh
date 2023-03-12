#!/bin/sh

if [[ ! -f ssh_key/multipass-ssh-key ]]
then
    ssh-keygen -C vmuser -f ssh_key/multipass-ssh-key -N '' -q
    echo "\n      - $(cat ssh_key/multipass-ssh-key.pub)" >> cloud-init.yml
fi

multipass delete webserver database 2> /dev/null ; multipass purge

multipass launch --name webserver --cpus 1 --memory 1G --cloud-init cloud-init.yml
multipass launch --name database --cpus 1 --memory 1G --cloud-init cloud-init.yml

echo "Extracting webserver ip"
multipass info --format csv webserver | sed -n 2p | awk -F "\"*,\"*" '{print $3}'

echo "Extracting database ip"
multipass info --format csv database | sed -n 2p | awk -F "\"*,\"*" '{print $3}'
