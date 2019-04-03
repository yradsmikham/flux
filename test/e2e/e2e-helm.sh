#!/usr/bin/env bash

# Install the `helm` executable, and with that, install Tiller in the
# cluster.

set -o errexit

source $(dirname $0)/e2e-paths.env
source $(dirname $0)/e2e-kube.env

echo ">>> Installing Helm to $BASE/bin"
if ! [ -f "$BASE/bin/helm" ]; then
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | env HELM_INSTALL_DIR="$BASE/bin" USE_SUDO=false bash
fi

echo '>>> Installing Tiller in cluster'
kubectl --namespace kube-system create sa tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --upgrade --wait
