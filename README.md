# Table of contens
- [Docker getting atarted app by Ansible](#Docker-getting-atarted-app-by-Ansible)
    - [How it works?](#how-it-works)
- [Ping each other by Terraform](#Ping-each-other-by-Terraform)

# Docker getting atarted app by Ansible
In this part, I have created 2 documents to deploy a single-node k8s cluster on a remote ECS and then deploy a Docker getting started app on this cluster. 
## How it works?
First of all, go to `inventory.yaml` and modify following champs `ansible_host`, `ansible_user` and `ansible_ssh_pass` in using your own host ip address, user name and password.  
Then execute the following command ```ansible-playbook playbook.yml -i inventory.yaml --ask-vault-pass``` to start deploying the applicaiton.  
As `inventory.yaml` is encrypted, you will be asked to enter the password to move forward.  
The address of the site is declared in the block `Create ingress resource for external access` of `deployment_app.yaml`.
# Ping each other by Terraform

