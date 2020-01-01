# Kubernetes Operations (kubeops)
"GitOps" repo for Cloud Native Indonesia Kubernetes environment. This repo controls the applications running in the kubernetes environment available to the Cloud Native Indonesia community. 

## Quickstart

If you want to deploy new app, create new folder and put your manifests or helm chart, then add new configuration to `apps.yaml`. Refer to argocd [docs](https://argoproj.github.io/argo-cd/user-guide/application_sources/) for references.

To see what's currently being managed and synced by Argocd, open the UI:
```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
then open `localhost:8080` on your browser.

### Installing Argocd
Argocd is used for continuous delivery and GitOps sync of this repo, modify bootstrap.sh with your account and execute it:
```sh
./scripts/bootstrap.sh
```
