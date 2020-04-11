# Devops

Ansible playbooks, terraform templates, and other infrastructure-as-code developed for investigations at [Forensic Architecture](https://forensic-architecture.org)

## Dependencies

The main dependencies at this time are Python and Ansible.   

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
