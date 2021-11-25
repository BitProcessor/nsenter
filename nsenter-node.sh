#!/bin/sh

node=${1}
nodeName=$(kubectl get node ${node} -o template --template='{{index .metadata.labels "kubernetes.io/hostname"}}')
nodeSelector='"nodeSelector": { "kubernetes.io/hostname": "'${nodeName:?}'" },'
podName=${USER}-nsenter-${node}
# convert @ to -
podName=${podName//@/-}
# convert . to -
podName=${podName//./-}
# truncate podName to 63 characters which is the kubernetes max length for it
podName=${podName:0:63}

echo "Pod name: ${podName:?}"
kubectl run ${podName:?} --restart=Never -it --rm --image overriden --overrides '
{
  "spec": {
    "hostPID": true,
    "hostNetwork": true,
    '"${nodeSelector?}"'
    "tolerations": [{
        "operator": "Exists"
    }],
    "containers": [
      {
        "name": "nsenter",
        "image": "ghcr.io/bitprocessor/nsenter:latest",
        "args": [
          "-m", "-u", "-i", "-n", "-p", "-C", "-r", "-w", "--target=1", "--", "su", "-"
        ],
        "stdin": true,
        "tty": true,
        "securityContext": {
          "privileged": true
        },
        "resources": {
          "requests": {
            "cpu": "10m"
          }
        }
      }
    ]
  }
}' --attach "$@"
