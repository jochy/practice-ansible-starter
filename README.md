# Practice ansible
### LAST NAME : DOE
### First name : John

Starter used to practice ansible. Must be running on Linux or Mac. If running on Windows, please use Git bash (or use a VM).

# Getting started

## Requirements
### Mac Silicon (M1 or M2)

Make sure [Brew](https://brew.sh/) is installed: 
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Restart shell and run the following commands: 
```shell
# Install vagrant and VMware
brew install --cask vmware-fusion
brew install --cask vagrant
brew install --cask vagrant-vmware-utility
vagrant plugin install vagrant-vmware-desktop

# Install ansible
brew install ansible
```

To obtain a free personal VMWare licence:
* Create an account on [VMWare website](https://customerconnect.vmware.com/evalcenter?p=fusion-player-personal-13)
* Log in with your account
* Go to [this page](https://customerconnect.vmware.com/evalcenter?p=fusion-player-personal-13)
* Open licence & download tab
* You have the licence serial number displayed
* Copy and paste it in VMWare application

VMWare will ask some permissions. You'll have to allow them ;)

### Windows, Linux and Mac Intel

You'll need to install: 
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/Downloads)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)
 * Ansible must be installed using Git Bash for Windows

## Start virtual machines

This practice relies on Linux virtual machines. To create them, you have to run the following command: `vagrant up`. It can take a while, specially the first time. 

It will create 2 virtual machines:
* ubu1 with ssh port forwarded on 2721
* ubu2 with ssh port forwarded on 2722

Have a look at [Vagrantfile](./Vagrantfile)

On Mac Silicon (Mx processors), it will open an interface for each virtual machine. Do not touch anything on this interfaces: just put them on the background.

## Make sure everything is working fine

First, run the following command: `ansible-galaxy install -r requirements.yml`

Run `./webserver.sh`. It may ask you to trust the sshkey for the host, accept it. 
If you see "Webserver deployed", then everything is working fine, else make sure:

* The ssh key path is the right one
  * Run the following command: `vagrant ssh-config`
  * Make sure the path indicated at `IdentityFile` is the same indicated in `hosts.yml` on each `ansible_ssh_private_key_file`
* VMs are running
  * Run the following command: `vagrant status`
  * You should see that ubu1 and ubu2 are running
* You can login into the vms using: `vagrant ssh ubu1` and `vagrant ssh ubu2`

## Shutdown and clean up

After working with it, you can destroy virtual machines by using the following command: `vagrant destroy -f`