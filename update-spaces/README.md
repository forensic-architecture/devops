playbooks for [DigitalOcean spaces](https://www.digitalocean.com/products/spaces/).

## Setup

1. Create a '.env' file based on the structure in the '.example.env'
template. The ID and secret keys are available from your DO portal.

### upload.yml 

Uploads a folder from your local to a DO space. Configure the variables
in .env, and then run the following commands:
```
source .env
ansible-playbook upload.yml
```
### publicise.yml

Makes all files in a folder in a space publicly accessible. (A requirement if
your assets are being used in websites, for example.)

```
source .env
ansible-playbook publicise.yml
```
