<h1 align="center">
Ansible Playbook for Timemap Deployment
</h1>

An Ansible playbook for remote deployment of an instance of Timemap in
conjunction with a dedicated instance of datasheet-server. Multiple
Timemap/Datasheet instances may be deployed to the same server, either hosting
all sources on a single datasheet-server, or running different instances for
each source. Datasheets and Timemaps are linked by their respective `name`s. 

# Overview
The playbook's tasks are broken down into four successive stages:

### prepare
Installs the relevant packages on the remote server.

### datasheet
Configures and builds an instance of
[datasheet-server](https://github.com/forensic-architecture/datasheet-server)
on the remote server, copies over any local datasheets, and launches the
configured server inside a docker container.

### timemap
Configures and builds an instance of Timemap locally, and then copies the
static files to the remote server.

### nginx
Configures the reverse proxy on the remote server to expose both `timemap` and
`datasheet` externally.


# Setup 

First make sure [Ansible is
installed](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
on the machine that will be running the playbooks. The remote server(s) that
Ansible can connect to is specified in the local inventory, which is located
here `./inventories/hosts`. See Ansible's
[documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
for more details on how to configure the inventory.

Copy `example.env` to a new `.env` file in the same folder and provide your own
host group (a server specified in the `inventories/hosts` file) and the
location of the ssh key associated with this server.

Copy `example.vault.yml` to a new `vault.yml` in the same folder. The vault
file contains all Timemap/Datasheet specific configuration. See the
[Timemap](https://github.com/forensic-architecture/timemap) and
Datasheet-Server](https://github.com/forensic-architecture/datasheet-server)
documentation for more infomation. All files that end in 'vault.yml' are
ignored from git, so you can keep configuration for multiple applications
inside this folder locally, and symlink to 'vault.yml' when deploying one.

Note: the domain name can also be an IP address for example:
```
domain_name: '104.154.99.51'
```

NOTE: If you don't have a server to install Timemap on then you can set one up
in the Cloud on a Google Cloud Platform Virtual Machine or an EC2 AWS instance.
For more info see the [provision directory](../provision/docs/terraform_readme.md).

# Running 

First install the dependencies:
```
ansible-galaxy install angstwad.docker_ubuntu
sudo apt install gawk # or 'brew install gawk' on mac
pip3 install jmespath
```

Always run commands from inside this directory ('deploy_timemap'), sourcing the
'.env' file before running any commands:
```
source .env
```
### Check your vault
In order to deploy timemap successfully, you need to make sure that your vault
variables can appropriately generate the configs. Enter your **local** sudo
command when prompted: 
```
ansible-playbook -K playbooks/check_templates.yml
```

### Deploy timemap
Deploy to the remote you specified in the '.env' file with the following
command. Enter your **remote** sudo command when prompted:
```
ansible-playbook playbooks/deploy_timemap.yml --ask-become-pass
```

To run a single stage, use the `--tag` flag:
```
ansible-playbook playbooks/deploy_timemap.yml --tags timemap --ask-become-pass
```


### HTTPS and Certificates
To install a certificate on the server and enable HTTPS (you should only need
to do this once per server) run:
```
ansible-playbook playbooks/add_https_certificate.yml --ask-become-pass

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
