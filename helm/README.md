# Install Tiledesk with Helm and Kubernetes

[Tiledesk](https://www.tiledesk.com/) is an open source live chat platform that can be deployed to any infrastructure that can run Node.js.

## Introduction

This chart bootstraps a [Tiledesk](https://github.com/tiledesk/tiledesk-deployment/helm) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites

- Kubernetes 1.14+
- Helm 3.2+
- Minikube or Google Kubernetes Engine (GKE)

## Download the project

Clone the repository and go to the deployment directory with :

```console
git clone https://github.com/Tiledesk/tiledesk-deployment.git
cd tiledesk-deployment
```

## Configure the Chart
Configure the required properties under values.yaml :

```
CHAT21_URL: https://CHANGEIT.cloudfunctions.net
CHAT21_ADMIN_TOKEN: CHANGEIT
CHAT21_APPID: tilechat

FIREBASE_PRIVATE_KEY: CHANGEIT
FIREBASE_CLIENT_EMAIL: CHANGEIT
FIREBASE_PROJECT_ID: CHANGEIT
FIREBASE_APIKEY: CHANGEIT
FIREBASE_AUTHDOMAIN: CHANGEIT.firebaseapp.com
FIREBASE_DATABASEURL: https://CHANGEIT.firebaseio.com
FIREBASE_STORAGEBUCKET: CHANGEIT.appspot.com
FIREBASE_MESSAGINGSENDERID: CHANGEIT
```

You can find more info about creating Firebase Project and configure it here: https://developer.tiledesk.com/installation/running-tiledesk-with-docker-compose#2-firebase-setup


## Installing the Chart

To install the chart with the release name `my-tiledesk`:

```console
helm install my-tiledesk helm
```

The command deploys Tiledesk on the Kubernetes cluster in the default configuration. 

## Uninstalling the Chart

To uninstall/delete the `my-tiledesk` deployment:

```console
helm delete my-tiledesk
```

The command removes all the Kubernetes components associated with the chart and deletes the release.



# Create Ingress


## Create a custom nginx Ingress controller 

Deploy nginx controller with:

```console
helm install nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true
```


## Create a GCE Ingress

If you are using Google GKE you must create the GCE Ingress.

See here for more info: https://cloud.google.com/community/tutorials/nginx-ingress-gke

If you have a TLS certificate please link it to the ManagedCertificate you created previously with:

```console
kubectl apply -f gce-ingress.yaml
```

Wait for the managed certificate to be provisioned. This may take up to 15 minutes. Create your DNS entry. You can check on the status of the certificate with the following command:


Use the command below to the ingress ip:

```console
gcloud compute addresses list --project tiledesk-kube
```

For GKE please use this guide: https://cloud.google.com/kubernetes-engine/docs/how-to/managed-certs

# Accessing Logs
This section describes how to get logs from the running containers.

1. Get the name of the pod which you want to get the logs of.
```console
kubectl --namespace <your namespace> \
    get pods
```
The output should be similar to this
```
NAME                                                  READY   STATUS    RESTARTS   AGE
nginx-ingress-controller-5c798c9ffc-t5wmb             1/1     Running   0          50d
nginx-ingress-default-backend-7db6cc5bf-qgdtb         1/1     Running   0          50d
tiledesk-helm-1593793077-dashboard-6f4654c465-f566q   1/1     Running   0          51d
tiledesk-helm-1593793077-ionic-56b474d986-jgqsl       1/1     Running   0          51d
tiledesk-helm-1593793077-mongodb-6d4fdf5965-kbcdg     1/1     Running   0          51d
tiledesk-helm-1593793077-server-5c4cbf75f5-v2d67      1/1     Running   0          48d
tiledesk-helm-1593793077-webwidget-7445fb45cc-gdpmd   1/1     Running   0          51d
```
tiledesk-helm-1593793077 is for example the name of the Tiledesk deployment.

2. To get the logs of the container run:

```console
kubectl --namespace <your namespace> \
    logs <name of the pod>
```




# Cluster Requirements
To install the Tiledesk chart, you need an existing Kubernetes cluster.
The requirements of the single pods can vary dependent on the model size and the number of users. We recommend providing at least the following resources:

| Deployment         | CPU | Memory |
|--------------------|-----|--------|
| tiledesk-server    | 1   | 1GB    |
| mongodb            | 0,5 | 512MB  |
| tiledesk-dashboard | 0,2 | 200MB  |
| chat21-web-widget  | 0,2 | 200MB  |
| chat21-ionic       | 0,2 | 200MB  |

We recommend a size at least 20 GiB for the database volume claim.
N1-standard-1 type is the minimum cluster type if you choose GKE.

