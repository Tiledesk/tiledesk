# Install Tiledesk with Helm and Kubernetes

[Tiledesk](https://www.tiledesk.com/) is an open source live chat platform that can be deployed to any infrastructure that can run Node.js.

## Introduction

This chart bootstraps a [Tiledesk](https://github.com/tiledesk/tiledesk-deployment/helm) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites

- Kubernetes 1.14+
- Helm 3.2+

## Installing the Chart

To install the chart with the release name `my-tiledesk`:

```console
$ helm install my-tiledesk bitnami/parse
```

The command deploys Tiledesk on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-tiledesk` deployment:

```console
$ helm delete my-tiledesk
```

The command removes all the Kubernetes components associated with the chart and deletes the release.



# Create Ingress

## Create a custom nginx Ingress controller 

```
helm install nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true
```



## Create a GCE Ingress

Create the Ingress, linking it to the ManagedCertificate you created previously with:

```
kubectl apply -f gce-ingress.yaml
```


Wait for the managed certificate to be provisioned. This may take up to 15 minutes. Create your DNS entry. You can check on the status of the certificate with the following command:


Use the command below to the ingress ip:

gcloud compute addresses list --project tiledesk-kube

For GKE please use this guide: https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs

