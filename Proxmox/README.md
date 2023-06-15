
Create Proxmox VMs
`terraform apply --auto-approve`

Update inventory file with node IPs

Configure K8s
`ansible-playbook -i Ansible/inventory.ini Ansible/playbooks/main.yaml`

Manage Remotely
```bash
mkdir -p /Users/ezrahill/.kube && scp -r kube@192.168.21.90:/home/kube/.kube/config $HOME/.kube/config
kubectl cluster-info
kubectl get pods -A
```
