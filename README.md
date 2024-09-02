# Table of contens
- [Docker getting atarted app by Ansible](#Docker-getting-atarted-app-by-Ansible)
    - [How it works?](#how-it-works)
    - [Project architecture](#Project-architecture)
- [Ping each other by Terraform](#Ping-each-other-by-Terraform)

# Docker getting atarted app by Ansible
In this part, 2 documents are created to deploy a single-node k8s cluster on a remote ECS and then deploy a Docker getting started app on this cluster. 
## How it works?
First of all, go to `inventory.yaml` and modify following champs `ansible_host`, `ansible_user` and `ansible_ssh_pass` in using your own host ip address, user name and password.  
  
Then execute the following command ```ansible-playbook playbook.yml -i inventory.yaml --ask-vault-pass``` to start deploying the applicaiton.  
  
As `inventory.yaml` is encrypted, you will be asked to enter the password to move forward.  
  
The address of the site is declared in the block `Create ingress resource for external access` of `deployment_app.yaml`.  
  
In this example, you can go to `http://47.76.230.115.nip.io/` to see a demostration. If it does not work, please contact the owner of this repository. 
## Project architecture
In this project, to store the data of the Docker getting started app, a MySQL database is deployed, and to deploy the database with persistence, a PV and a PVC are used to sotre data at local.  
  
Besides, a k8s cluster is deployed by k3s and Docker is installed. 
# Ping each other by Terraform
In this part, severals VM are created by Terraform and they are able to ping from one to another (ex. VM 1 ping VM 2, VM 2 ping VM 3, VM 3 ping VM 1).  
  
In `main.tf`, resources are defined to finish the task.  

In `provider.tf`, provider information is defined. To make sure that key information is secured, `access_key` and `secret_key` are defined by environment variables.  

In `variable.tf`, variables are defined.  

In `terraform.tfvars`, parameters of each VM created automatically are defined.  
  
To execute this project, you should firstly install Terraform and enter environment variables for `access_key` and `secret_key` in using your owns.  

Then you should execute following commands:  

`terraform init`  
  
`terraform plan`  
  
`terraform apply`  
  
If you want to delete all created resources, use `terraform destroy`


