## Kubernetes worker node access

Use the helper script `nsenter-node.sh` to enter into any Kubernetes node.

### Usage example: 

Enter into an AWS Elastic Kubernetes Service (EKS) worker node:

```sh
# list Kubernetes nodes
kubectl get nodes

NAME                                         STATUS   ROLES    AGE     VERSION
ip-10-1-100-178.eu-west-1.compute.internal   Ready    <none>   16d     v1.21.4-eks-033ce7e
ip-10-1-102-66.eu-west-1.compute.internal    Ready    <none>   10h     v1.21.4-eks-033ce7e
ip-10-1-104-90.eu-west-1.compute.internal    Ready    <none>   23d     v1.21.4-eks-033ce7e

# enter into selected node with default shell as superuser
./nsenter-node.sh ip-10-1-100-178.eu-west-1.compute.internal

...

[root@ip-10-1-100-178 ~]#
```

Note: This solution does not require SSH access to be enabled on the nodes.
