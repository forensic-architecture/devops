
# Google Cloud Platform (GCP)

[Google Cloud Platform](https://cloud.google.com/) provides a range of services including infrastructure. With the Terraform scripts included here you can automatically create:

* a Compute Engine Virtual Machine 
* GCP Storage Bucket

## Google Cloud Platform (GCP) Account

To use GCP you need to create a standard Google Account (e.g. your Gmail account) and then register for a GCP account. You'll need a credit card but GCP has a free tier that is adequate for many uses. Full instructions here:

[https://cloud.google.com/](https://cloud.google.com/)

Once you have registered you should be able to access the [GCP Console](https://console.cloud.google.com)

## GCP Project and Service Account credentials

With access to the console, you now need to 

* Use the GCP console to [Create a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) 

* Use the GCP console to [Create a service account](https://cloud.google.com/compute/docs/access/service-accounts) for your project on the IAM & admin ⇒ Service accounts tab. Grant the new service account permission to the ‘Compute Admin’ Role, within the project, using the Role drop-down menu. Create a private key for the service account, on the IAM & admin ⇒ Service accounts tab.  Choose the JSON key type. Download the private key JSON file and save it in a safe location, accessible to Ansible. Do not to check this file into source control. This file contains the service account’s credentials used to programmatically access GCP and administer compute resources. This private key contains the credentials for the service account, and is different than the SSH key will add to the project next. 

### Configure your GCP Project with an Ansible User 

Back on your machine, you need to create an SSH public/private key pair. The SSH key will be used to programmatically access the GCP VM. 

On a Mac, you can use the following commands to create a new key pair and copy the public key to the clipboard.

```
ssh-keygen -t rsa -b 4096 -C "id_rsa_your_key_name"
cat ~/.ssh/id_rsa_your_key_name.pub | pbcopy
```

#### Add the SSH Public Key to GCP's Compute Engine's Metadata 

To be able to interact with the GCP VM you need to register the new key back in the GCP console. 

Add your new public key clipboard contents to the project, on the Compute Engine ⇒ Metadata ⇒ SSH Keys tab. Adding the key here means it is usable by any VM in the project unless you explicitly block this option when provisioning a new VM and configure a key specifically for that VM.

Note the name associated with the key e.g. forensic-ansible-key as you'll use that to configure Ansible.


## Configure and initialise the .env file

You'll find instruction in the `example.env`file for how to configure GCP. Once you have updated the variables run this in the terminal:
 
```
source .env
```

You should now be able to follow the instructions in [terraform_readme.md](terraform_readme.md) to provision your infrastructure. 


