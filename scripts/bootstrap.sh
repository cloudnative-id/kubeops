#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

err_report() {
  echo "Exited with error on line $1"
}
trap 'err_report $LINENO' ERR

function grant_cluster_admin {
  local username="$1"
  kubectl create clusterrolebinding $username-cluster-admin-binding --clusterrole=cluster-admin --user=$username
}

function init_argocd {
  kubectl create namespace argocd
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
}

function download_argocd_tools() {
  if [ "$(uname)" == "Darwin" ]; then
    brew tap argoproj/tap
    brew install argoproj/tap/argocd
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
    chmod +x /usr/local/bin/argocd
  fi
}

### main program
init_argocd
download_argocd_tools

# TODO(admin): Anyone that wants to execute argocd need to be cluster admin
grant_cluster_admin girikuncoro@gmail.com
