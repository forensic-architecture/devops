# Devops

Ansible playbooks, terraform templates, and other infrastructure-as-code developed for investigations at [Forensic Architecture](https://forensic-architecture.org)

## Setup 

The main dependencies at this time are Python, Ansible, and Terraform.

### Python and Pip set up

Install [Python](https://www.python.org/) and [pip3](https://pip.pypa.io/en/stable/installing/) then use Pip to set up your Python local environment:

```
pip install virtualenv
virtualenv forensic-devops
source forensic-devops/bin/activate
```

### Ansible set up

With Python and pip installed run:

```
pip install ansible
```

### Terraform set up

Installation instructions can be found in [provision/README.md](./provision/README.md).

## Outline of IaC

### provision 

For more info see [provision/README.md](./provision/README.md).

### deploy_timemap

A set of ansible playbooks to deploy new instances of
[Timemap](https://github.com/forensic-architecture/timemap), along with a fully
configured [Datasheet Server](https://github.com/datasheet-server) backend, to
a cloud instance. For more info see
[deploy_timemap/README.md](./deploy_timemap/README.md)

### Updating DO spaces
We recommend using the
[s3cmd](https://www.digitalocean.com/docs/spaces/resources/s3cmd/) tool to sync
to spaces programmatically. A list of useful commands can be found
[here](https://www.digitalocean.com/community/questions/how-to-manage-digitalocean-spaces-using-s3cmd).
