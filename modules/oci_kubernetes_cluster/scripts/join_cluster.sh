#!/bin/bash

. ./tmp/env.sh

# Join the cluster
for i in {1..50}; do kubeadm join --token=${K8S_TOKEN} --discovery-token-unsafe-skip-ca-verification --node-name=$(hostname -f) ${MST_FIXED_IP}:6443 && break || sleep 15; done