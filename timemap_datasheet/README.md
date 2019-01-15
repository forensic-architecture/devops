# Playbook: Deploy Timemap/Datasheet

This playbook deploys a fully configured instance of
[Timemap](https://github.com/forensic-architecture/timemap) powered by
[Datasheet Server](https://github.com/forensic-architecture/datasheet-server),
to enable a full geo-spatial visualisation of data formatted in a Google sheet.

In order to run the playbook, you will have to modify the following files,
interpolating the appropriate variables:
* hosts
* ansible.cfg
* vars/main.yml
* vars/vault.yml
