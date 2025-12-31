# Deploying Geoserver to Linode

This repo is an example of how to deploy geoserver to a linode server using Terraform and ansible.

The purpose is to demonstrate that server provision and management for Geospatial Data Science should not be done with ClickOps. Instead, it must be done with IaaC and configuration files so that processes and changes can be tracked. This ensures auditability.


## Requirements

Install terraform and ansible.

# How to Use

There are 2 steps:
1. use Terraform to provide the infrastructure
2. use Ansible to configure the infrastructure

## Providing the Cloud Infrastructure

Generate a linode api token with the right privileges (read and write).

Add the token to `# ~/.config/linode`

```bash
[default]
token = <TOKEN VALUE>
```

This is how Terraform authenticates.

Now let's execute terraform

```
terraform apply
```

click yes. An IP Address will be printed out and `./ansible/inventory.ini` will be created. There is an IP Address which is the server's public ip address. We will use this to SSH and configure.

Register the IP Address

```bash
export IP_ADDRESS=# INSERT IP ADDRESS
ssh-keyscan -H $IP_ADDRESS >> ~/.ssh/known_hosts
```

## Ansible

Now that we have the IP Address, go to the DNS provider and register an A record for the IP Address.

You must configure the URL's origin. As this is my repo, I've set it to:

```yaml
# ./ansible/main.yaml
  vars:
    site_name: geoserver.sutan.co.uk
    email: sutan@rekayasadata.co.uk
    app_user: geoserver
```

In this case, my geoserver will be deployed on [https://geoserver.sutan.co.uk/geoserver](https://geoserver.sutan.co.uk/geoserver)

Run the playbook

```bash
ansible-playbook -i inventory.ini main.yaml
```

