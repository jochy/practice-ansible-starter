# Practice ansible
### LAST NAME : DOE
### First name : John

Starter used to practice ansible. Must be running on Linux or Mac. If running on Windows, please use Git bash (or use a VM).

# Getting started

## Requirements

* [Multipass](https://multipass.run/install)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)
  * Ansible must be installed using Git Bash for Windows

## Start virtual machines

This practice relies on Linux virtual machines. To create them, you have to run the following command: `./start.sh`. It can take a while, specially the first time. 

It will create 2 virtual machines:
* webserver
* database

## Make sure everything is working fine

First, run the following command: `ansible-galaxy install -r requirements.yml`

Run `./webserver.sh`. It may ask you to trust the sshkey for the host, accept it. 
If there is no error, then everything is working fine, else make sure:

* VMs are running
  * Run the following command: `multipass list`
  * You should see that ubu1 and ubu2 are running
* You can login into the vms using: `multipass shell webserver` and `multipass shell database`
* IP matches between `multipass list` and `hosts.yml` file

## Shutdown and clean up

After working with it, you can destroy virtual machines by using the following command: 
```shell
multipass delete webserver database 
multipass purge
```