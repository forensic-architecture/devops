# Terraform

[Terraform](https://www.terraform.io/) is an automated infrastructure provisioning tool that can create the web server and file storage infrastructure that Timemap relies on. The scripts included here will create resources on the Google Cloud Platform (GCP) and Amazon Web Services (AWS) platforms.

## Install Terraform
You should be able to install Terraform as follows:

Mac:

```
brew install terraform
```

Windows:
```
 choco install terraform
```

Full instructions here: [Installing Terraform](https://learn.hashicorp.com/terraform/gcp/install)

## Common Terraform Workflow

For both GCP and AWS there is a common workflow but prior to running that you will need to follow the instructions for setting up an account and associated security credentials. Depending on your choice of platform follow the instructions for:
AWS [aws-account-readme.md](aws-account-readme.md) and then switch to the `aws-instance` directory.
GCP [gcp-account-readme.md](gcp-account-readme.md) and then switch to the `gcp-instance` directory.

## Initialise the project

Terraform needs initialised prior to use. Run:

```
terraform init
```

## Configure Terraform Variables

The Terraform scripts come with some defaults but you will still need to update a couple of security credential related variables. To do that copy:
 
`example.terraform.tfvars`

Rename the file:

`terraform.tfvars`

Then use the instructions in the comments to update the file appropriately. You can also change the values to create infrastructure appropriate to your requirements.  

## Run Terraform and create infrastructure 

With everything configured, you are now able to run Terraform and spin up the infrastructure. Run:

```
terraform apply
```
Terraform will ask you to confirm making changes to your infrastructure and when it completes running it will tell you the IP address of the virtual machine it has just created e.g.

```
EC2-instance-ip = 34.228.180.239
```

Copy the IP address as you need to update your `vault.yml` file *domain name* with that IP and you also need to update the `deploy_timemap/inventories/hosts` file with the IP address.  

#### IP Addresses - Static vs Ephemeral

When the scripts run they create an 'ephemeral' external IP address for the VM by default. You use that IP address to access the VM and (once you have installed it) Timemap. 

'Ephemeral' means that every time you stop and start the VM it will be assigned a new IP address and you will have to use that new address. If you don't stop and start it will retain the IP address and this may be enough for you for test and demonstration purposes. It is also possible to create VM with a static external IP address but you can only have one resource at a time using a static external IP address in a project.
You can rerun Terraform to change infrastructure at any time and you can also destroy all the Timemap related infrastructure at any time.

Your infrastructure is now ready to be provisioned with Timemap and Datasheet as described in the deploy_timemap [README.md](../../deploy_timemap/README.md)
