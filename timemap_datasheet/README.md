<h1 align="center">
Ansible Playbook for Timemap Deployment
</h1>

An Ansible playbook for remote deployment of an instance of Timemap in conjunction with a dedicated instance of datasheet-server. Multiple Timemap/Datasheet instances may be deployed to the same server, differentiated by the `application_name` set in `vault.yml` (see configuration steps below).

# Overview

The playbook's tasks are broken down into four subsets, which are stored in separate files:

* `prepare.yml` installs the relevant packages on the remote server.
* `datasheet.yml` configures and builds an instance Datasheet-Server on the remote server and launches it inside a docker container.
* `timemap.yml` configures and builds an instance of Timemap on the host machine and copies the static files to the remote server.
* `nginx.yml` configures the reverse proxy on the remote server

The subtasks are called in sequence from the `_master.yml` playbook file.

N.B. copies of the configuration files for both Timemap and Datasheet-Server in the `credentials` folder on the remote server.

# Configuration

First make sure [Ansible is installed](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) on the machine that will be running the playbooks. The remote server(s) that Ansible can connect to is specified in the global inventory, which is located in `/etc/ansible/hosts` by default. See Ansible's [documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html) for more details on how to configure the inventory.

Copy `example.env` to a new `.env` file in the same folder and provide your own host group (a server specified in the inventory) and the location of the ssh key associated with this server.

Copy `example.vault.yml` to a new `vault.yml` in the same folder. The vault file contains all Timemap/Datasheet specific configuration. See the [Timemap](https://github.com/forensic-architecture/timemap) and [Datasheet-Server](https://github.com/forensic-architecture/datasheet-server) documentation for more infomation.


# Running the playbook

First run
```
source .env
```
in the folder where the `.env` file is located.

Then install the dependency playbooks:
```
ansible-galaxy install angstwad.docker_ubuntu
```

The playbook can then be run via the command
```
ansible-playbook _master.yml
```
