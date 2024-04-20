# Create K8s VMs in Proxmox

## Deploy K8s VMs using Terraform

`terraform apply --auto-approve`

## Configure K8s Cluster using Ansible

1. Update inventory file with node IPs
2. Configure K8s
   `ansible-playbook -i Ansible/inventory.ini Ansible/playbooks/main.yaml`

## Setup Host to Manage K8s Remotely

```bash
mkdir -p /Users/ezrahill/.kube && scp -r kube@192.168.21.77:/home/kube/.kube/config $HOME/.kube/config
kubectl cluster-info
kubectl get pods -A
```

## Install MetalLB inside K8s Cluster

Run the following

```bash
./metallb-prep.sh
kubectl apply -f metallb-native.yaml
kubectl apply -f metallb-ip-pool.yaml
```

## Install Ingress NGNIX
*Using this for now, may change out for Traefik*

```bash
kubectl apply -f ingress-nginx.yaml
kubectl get service ingress-nginx-controller --namespace=ingress-nginx
```