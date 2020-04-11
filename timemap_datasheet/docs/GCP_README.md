# Cloud Platform Dev Ops

Ansible playbooks to create and maintain cloud based resources.

# Overview

Google Cloud Platform (GCP), Amazon Web Services (AWS) and Microsoft Azure all provide Platform as a Service and Infrastructure as a Service offerings that are increasingly used by organisations looking to save money and time on configuring infrastructure and application resources. The Ansible scripts included here help with common tasks around cloud provisioning.  

## Google Cloud Platform (GCP)

GCP 

Create a Google Account and then register for a GCP account here (you'll need a credit card but GCP has a free tier that is adequate for many uses):

[https://cloud.google.com/](https://cloud.google.com/)

Once you have registered you should be able to access the [GCP Console](https://console.cloud.google.com)

## Google Cloud Platform (GCP) Virtual Machine

From here you can manually create a GCP Virtual Machine or run in the Ansible Playbook included here to provision one. To do that you'll need to compete the following steps:  

* Use the GCP console to [Create a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) 

* Use the GCP console to [Create a service account](https://cloud.google.com/compute/docs/access/service-accounts) for your project on the IAM & admin ⇒ Service accounts tab. Grant the new service account permission to the ‘Compute Admin’ Role, within the project, using the Role drop-down menu. Create a private key for the service account, on the IAM & admin ⇒ Service accounts tab.  Choose the JSON key type. Download the private key JSON file and save it in a safe location, accessible to Ansible. Do not to check this file into source control. This file contains the service account’s credentials used to programmatically access GCP and administer compute resources. This private key contains the credentials for the service account, and is different than the SSH key will add to the project next. 

You now have everything set up in GCP to allow Ansible to run and provision resources.

### Ansible User Configuration

Back on your machine you need to create an SSH public/private key pair. The SSH key will be used to programmatically access the GCE VM. 

On a Mac, you can use the following commands to create a new key pair and copy the public key to the clipboard.

```
ssh-keygen -t rsa -b 4096 -C "id_rsa_your_key_name"
cat ~/.ssh/id_rsa_your_key_name.pub | pbcopy
```

#### Add the SSH Public Key to GCP's Compute Engine's Metadata 

To be able to interact with the GCP VM you need to register the new key back in the GCP console. 

Add your new public key clipboard contents to the project, on the Compute Engine ⇒ Metadata ⇒ SSH Keys tab. Adding the key here means it is usable by any VM in the project unless you explicitly block this option when provisioning a new VM and configure a key specifically for that VM.

Note the name associated with the key e.g. forensic-ansible-key as you'll use that to configure Ansible.

## Configure the Ansible Playbook

You are now ready to configure Ansible. 

### Python Dependencies

For Ansible to talk to GCP you need to install a couple of Python packages:

```
pip install requests google-auth
```

### Ansible Environment Variables

Copy `.example.env` and rename it `.env`. Then open the file and update the following variables: 

* ANSIBLE_HOST_GROUP - 'localhost' - you are running Ansible locally 
* ANSIBLE_SSH_KEY_PATH - the location of your ssh key you created e.g. `~/.ssh/id_rsa_your_key_name.pub`
* ANSIBLE_REMOTE_USER - the name you gave the key when you registered it with GCP e.g. `forensic-ansible-user`
* PYTHON_INTERPRETER - the location of your Python installation e.g. `localansible/bin/python3`

## GCP VM Instance Configuration

By default we've configured Ansible to create an `f1-micro debian-9` image in the `us-central1` region and `us-central1-a` zone but you may want to change this. Configuration options are available in the following files located under: [vars](./vars) 

### Instance

Name, type of machine, machine image, geographic locations allowed ports and the authorisation scheme.

### Disk

Size and image source.

### Network

Network type and name.

## Configure the playbook


# Instance Name

By default the VM you will create is called: `forensic-architecture-vm` 

You can change that to your organisation's name in the `vars/google-cloud-platform/instance` template under 

```
gce_name: forensic-architecture-vm
```

## IP Addresses - Static vs Ephemeral

When the Ansible scripts run they create an 'ephemeral' external IP address for the VM by default. You use that IP address to access the VM and (once you have installed it) Timemap on. 

'Ephemeral' means that every time you stop and start the VM it will be assigned a new IP address and you will have to use that new address. If you don't stop and start it will retain the IP address and this maybe enough for you for test and demonstration purposes. It is also possible to create VM with a static external IP address but you can only have one resource at a time using a static external IP address in a project.

[Reserving a static external IP address](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address)

```
ip_address_state: ephemeral
```

## Run the Playbook

Once everything is configured you can run the playbook. First you will need to load the environment variables into memory. In the current `timemap_datasheet` folder run:

```
source .env
```

The playbook can then be run via the command:

```
ansible-playbook create_gcp_vm.yml --ask-become-pass
```

## Install Timemap and Datasheet with Ansible

```
ansible-playbook -i inventories/webservers_gcp.yml _master.yml --ask-b
ecome-pass                                                  
````

   forensic_architecture_timemap: "'forensic-architecture-timemap' in name"



gcloud beta compute --project "forensic-265906" ssh --zone "us-central1-a" "timemap-demo"


