# Table of contens
- [Docker getting atarted app by Ansible](#Docker-getting-atarted-app-by-Ansible)
    - [How it works?](#how-it-works)
- [Ping each other by Terraform](#Ping-each-other-by-Terraform)

# Docker getting atarted app by Ansible
In this part, I have created 2 documents to deploy a single-node k8s cluster on a remote ECS and then deploy a Docker getting started app on this cluster. 
## How it works?
First of all, go to `inventory.yaml` and modify following champs
`
ansible_host: 47.76.230.115
ansible_user: root
ansible_ssh_pass: !vault |
    $ANSIBLE_VAULT;1.1;AES256
    31626439323662386262373237373632376537323365336337636436363962663265646435386132
    3933613230386466386432376464343537353237656330300a666632333764376364643236393535
    37623834353037636537643433303438313765396637303533323835663264623337383039363862
    6363376334313233340a656232303538626132313265386165633830356363363233656164383363
    3937
`
in using your own host ip address, user name and password.
# Ping each other by Terraform

