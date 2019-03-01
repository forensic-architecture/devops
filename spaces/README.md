playbooks for [DigitalOcean spaces](https://www.digitalocean.com/products/spaces/).

first create a '.env' file based on the structure in the '.example.env'
template. the ID and secret keys are available from the DO portal.

### upload public folder 
```
source .env
ansible-playbook upload.yml
```
### make existing folder public 
```
source .env
ansible-playbook publicise.yml
```
