<h1 align="center">
Ansible Playbook for Timemap Deployment
</h1>

An Ansible playbook for remote deployment of an instance of Timemap in conjunction with a dedicated instance of datasheet-server. Multiple Timemap/Datasheet instances may be deployed to the same server, either hosting all sources on a single datasheet-server, or running different instances for each source. Datasheets and Timemaps are linked by their respective `name`s. 

# Overview

The playbook's tasks are broken down into four successive stages:

* `prepare` - installs the relevant packages on the remote server.
* `datasheet` - configures and builds an instance Datasheet-Server on the remote server, copies over any XLSX files, and launches the configured server inside a docker container.
* `timemap` - configures and builds an instance of Timemap locally, and then copies the static files to the remote server.
* `nginx.yml` configures the reverse proxy on the remote server to expose both
    `timemap` and `datasheet` externally.


To run all stages successfully, use:
```
ansible-playbook playbooks/deploy_timemap.yml
```

To run a single stage, use the `--tag` flag:
```
ansible-playbook playbooks/deploy_timemap.yml --tag datasheet
```

# Configuration

First make sure [Ansible is installed](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) on the machine that will be running the playbooks. The remote server(s) that Ansible can connect to is specified in the local inventory, which is located here `./inventories/hosts`. See Ansible's [documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html) for more details on how to configure the inventory.

Copy `example.env` to a new `.env` file in the same folder and provide your own host group (a server specified in the `inventories/hosts` file) and the location of the ssh key associated with this server.

Copy `example.vault.yml` to a new `vault.yml` in the same folder. The vault file contains all Timemap/Datasheet specific configuration. See the [Timemap](https://github.com/forensic-architecture/timemap) and [Datasheet-Server](https://github.com/forensic-architecture/datasheet-server) documentation for more infomation. All files that end in 'vault.yml' are ignored from git, so you can keep configuration for multiple applications inside this folder locally, and symlink to 'vault.yml' when deploying one.

Note: the domain name can also be an IP address for example:

```
domain_name: '104.154.99.51'
```

## Branch or Forked Git Repository

If you are working on a branch or forked repo you can override the Forensic Architecture defaults in `.env` as follows:

```
# override the defaults below with your own forked repository
# export DATASHEET_GIT_REPOSITORY='https://github.com/forensic-architecture/datasheet-server'
# export DATASHEET_GIT_BRANCH='develop'
# export TIMEMAP_GIT_REPOSITORY='https://github.com/forensic-architecture/timemap'
# export TIMEMAP_GIT_BRANCH='develop'
```

# Running the Playbook

First run

```
source .env
```

in the folder where the `.env` file is located.

Then install the dependency Playbooks:

```
ansible-galaxy install angstwad.docker_ubuntu
```

You'll also need [gawk](https://www.gnu.org/software/gawk/):
```
sudo apt install gawk # 'brew install gawk' on mac
```

The playbook can then be run via the command

```
ansible-playbook playbooks/deploy_timemap.yml

```

## Time Map Cloud Infrastructure Provisioning

If you don't have a server to install Timemap on then you can set one up in the Cloud on a Google Cloud Platform Virtual Machine or an EC2 AWS instance. For more info see [ReadMe](../provision/docs/terraform_readme.md)
