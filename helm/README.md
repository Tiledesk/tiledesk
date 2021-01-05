# Install Tiledesk with Helm and Kubernetes

[Tiledesk](https://www.tiledesk.com/) is an open source live chat platform that can be deployed to any infrastructure that can run Node.js.

## Introduction

This chart bootstraps a [Tiledesk](https://github.com/tiledesk/tiledesk-deployment/helm) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites

- Kubernetes 1.14+
- Helm 3.2+
- Minikube with [Ingress plugin enabled](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/#enable-the-ingress-controller) or Google Kubernetes Engine (GKE)



## Cluster Requirements
To install the Tiledesk chart, you need an existing Kubernetes cluster.
The requirements of the single pods can vary dependent on the model size and the number of users. We recommend providing at least the following resources:

| Deployment         | CPU | Memory |
|--------------------|-----|--------|
| tiledesk-server    | 1   | 1GB    |
| mongodb            | 0,5 | 512MB  |
| tiledesk-dashboard | 0,2 | 200MB  |
| chat21-web-widget  | 0,2 | 200MB  |
| chat21-ionic       | 0,2 | 200MB  |

We recommend a size at least 30 GiB for the database volume claim.
N1-standard-1 type is the minimum cluster type if you choose GKE.

## Download the project

Clone the repository and go to the deployment directory with :

```console
git clone https://github.com/Tiledesk/tiledesk-deployment.git
cd tiledesk-deployment
```

## Configure the Chart
Configure the required properties under values.yaml. You can find more info about creating Firebase Project and configure it here: 
* [Chat21 Firebase Installation](https://developer.tiledesk.com/installation/chat21-installation/chat21-firebase-installation)
* [Chat21 Channel Configuration](https://developer.tiledesk.com/configuration/channel)

```
CHAT21_ENABLED: true

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
FIREBASE_APP_ID: CHANGEIT
```
Attention. The default configuration of the values.yaml download the *latest* docker images of each Tiledesk components. If you are deploying in a production environment please change the docker tag of each components to a stable version.

## Installing the Chart

To install the chart with the release name `my-tiledesk`:

```console
helm install my-tiledesk helm
```

The command deploys Tiledesk on the Kubernetes cluster in the default configuration. 

## Configure the Chat21 webhooks

[Configure the Chat21 webhooks](https://developer.tiledesk.com/installation/chat21-installation/chat21-firebase-installation#2-2-configure-the-chat21-webhooks) to point to the new Kubernetes tiledesk-server endpoint (tiledesk-server service hostname or ip)


## Create an nginx Ingress controller (Optional)
If your cluster doesn't have a built-in nginx ingress controller (ex. GKE) you must mannually deploy it with :

```console
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx/
helm install ingress-nginx ingress-nginx/ingress-nginx
```

More info here: https://kubernetes.github.io/ingress-nginx/deploy/#using-helm

or with the old nginx ingress version :

```console
helm install nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true
```
With rbac.create=true you configure Role Based Access Controll (https://kubernetes.github.io/ingress-nginx/deploy/rbac/)



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

# Open the dashboard

As default setting the Tiledesk dashboard is esposed under http://console.tiledesk.local/dashboard/ url.

So create a DNS entry (just for testing modify your /etc/hosts file) like below:
console.tiledesk.local -> (A record) -> <YOUR_INGRESS_IP>

Open the browser at http://console.tiledesk.local/dashboard/ and signin as admin with :

* email: admin@tiledesk.com
* password: adminadmin


# Other configurations

## Configure TLS

See [here](https://github.com/Tiledesk/tiledesk-deployment/blob/master/helm/docs/tls.md) how to configure TLS certificate for the Tiledesk installation. 

## Push Notifications

Push notifications are available only with a configured TLS certificate.

# Usefull instructions

## Upgrade the Chart


To upgrade the `my-tiledesk` deployment:

```console
helm upgrade -f ./helm/values.yaml my-tiledesk ./helm
```
## Install the Chart passing inline parameters

To install the `my-tiledesk` deployment passing the parameters inline without modifing the value.yaml file:

```console
helm install helm --set CHAT21_URL=https://CHANGE_IT.cloudfunctions.net --set FIREBASE_CLIENT_EMAIL=firebase-adminsdk-CHANGE_IT@CHANGE_IT.iam.gserviceaccount.com --set FIREBASE_PROJECT_ID=CHANGE_IT --set FIREBASE_APIKEY=CHANGE_IT --set FIREBASE_AUTHDOMAIN=CHANGE_IT.firebaseapp.com --set FIREBASE_DATABASEURL=https://CHANGE_IT.firebaseio.com --set FIREBASE_STORAGEBUCKET=CHANGE_IT.appspot.com --set FIREBASE_MESSAGINGSENDERID=CHANGE_IT --set FIREBASE_APP_ID=CHANGEIT 
```
## Uninstalling the Chart

To uninstall/delete the `my-tiledesk` deployment:

```console
helm delete my-tiledesk
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
