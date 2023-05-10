# Practice ansible
### LAST NAME : DOE
### First name : John

Starter used to practice ansible. Must be running on Linux or Mac. If running on Windows, please use a VM with VirtualBox or WSL.

# Getting started

## Requirements

* [Multipass](https://multipass.run/install)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)

### Windows particularity

If on Windows, you must use linux (Ansible works only with a linux environment):
* VirtualBox with a virtual machine (prefer latest ubuntu)
* Use WSL2

With WSL2, you need to add a file `/etc/wsl.conf` with at least this content:
```
[boot]
systemd=true

[automount]
options = "metadata"
```

Then you need to shutdown your WSL using Powershell (on windows) `wsl --shutdown`, then you need to update wsl2 `wsl --update` then you can restart wsl2. 

## Fedora particulary

Fedora has a firewall that may block the use of multipass. This is a known issue. If you encounter any issue while creating the virtual machines, you can disable the firewall by using this command: `sudo systemctl stop firewalld`. Do not forget to enable it after the practice. 

## Start virtual machines

This practice relies on Linux virtual machines. To create them, you have to run the following command: `./start.sh`. It can take a while, specially the first time. 

It will create 2 virtual machines:
* webserver
* database

## Make sure everything is working fine

Run `./webserver.sh`. It may ask you to trust the sshkey for the host, accept it. 
If there is no error, then everything is working fine, else make sure:

* VMs are running
  * Run the following command: `multipass list`
  * You should see that ubu1 and ubu2 are running
* You can login into the vms using: `multipass shell webserver` and `multipass shell database`
* IP matches between `multipass list` and `hosts.yml` file
* Try another driver
  * Ubuntu: 
    ```
    sudo apt install libvirt-daemon-system
    sudo snap connect multipass:libvirt
    multipass stop --all
    multipass set local.driver=libvirt
    ./start.sh
    ```
  * Fedora: 
    ```
    sudo dnf install @virtualization
    sudo systemctl start libvirtd
    sudo snap connect multipass:libvirt
    multipass stop --all
    multipass set local.driver=libvirt
    ./start.sh
    ```

## Shutdown and clean up

After working with it, you can destroy virtual machines by using the following command: 
```shell
multipass delete webserver database 
multipass purge
```
