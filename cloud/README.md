# Cloud

## Google Cloud Platform (GCP)

A playbook to create a configurable virtual machine on the Google Cloud Platform.

## Setup and Configuration

First, you need to register for a GCP account and once you have that you need to:  

* [Create a project on GCP](https://cloud.google.com/resource-manager/docs/creating-managing-projects) .

* [Create a service account](https://cloud.google.com/compute/docs/access/service-accounts) for your project on the IAM & admin ⇒ Service accounts tab. Grant the new service account permission to the ‘Compute Admin’ Role, within the project, using the Role drop-down menu. Create a private key for the service account, on the IAM & admin ⇒ Service accounts tab. This private key is different than the SSH key will add to the project, next. This private key contains the credentials for the service account. Choose the JSON key type. 

Download the private key JSON file and place it in a safe location, accessible to Ansible. Be careful not to check this file into source control. Again, this file contains the service account’s credentials used to programmatically access GCP and administer compute resources.

Save an associated JSON security key that you'll then reference so copy the location where you store it. 


### Ansible User

Create an SSH public private key pair for the Ansible user in GCP.

Create an SSH public/private key pair. The SSH key will be used to programmatically access the GCE VM. Creating a separate key pair allows you to limit its use to just the new GCP project. If compromised, the key pair is easily deleted and replaced in the GCP project and in the Ansible configuration. On a Mac, you can use the following commands to create a new key pair and copy the public key to the clipboard.

```
ssh-keygen -t rsa -b 4096 -C "id_rsa_your_key_name"
cat ~/.ssh/id_rsa_your_key_name.pub | pbcopy
```

#### Add the SSH Public Key to GCP's Compute Engine's Metadata 

To be able to interact with GCP you need to register the new key. 

Add your new public key clipboard contents to the project, on the Compute Engine ⇒ Metadata ⇒ SSH Keys tab. Adding the key here means it is usable by any VM in the project unless you explicitly block this option when provisioning a new VM and configure a key specifically for that VM.

Note the name associated with the key e.g. forensic-ansible-key as you'll use that to configure Ansible.

## Configure Ansible

### Python Dependencies

For Ansible to talk to GCP you need to install a couple of Python packages:

```pip install requests google-auth```

### Ansible Environment Variables


Copy `.example.env` and rename it `.env`. Then open the file and update the following variables: 

* ANSIBLE_HOST_GROUP - 'localhost' - _can we leave that as a default?_
* ANSIBLE_SSH_KEY_PATH - the location of your ssh key e.g. `~/.ssh/id_rsa_your_key_name.pub`
* ANSIBLE_REMOTE_USER - the name you gave the key when you registered it with GCP e.g. `forensic-ansible-user`


## ansible.cfg

interpreter_python=/Users/frasercrichton/Development/ansible/ansible/bin/python3

## Instance

By default we've configured ansible to create an `f1-micro debian-9` image in the us-central1 region and us-central1-a zone but you may want to change this

## Disk

## Network

## Run the playbook

First you will need to load the environment variables into memory:

```
source .env
```
in the folder where the `.env` file is located.

The playbook can then be run via the command
```
ansible-playbook run.yml
```

