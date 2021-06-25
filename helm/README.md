# Install Tiledesk with Helm and Kubernetes

[Tiledesk](https://www.tiledesk.com/) is an open source live chat platform.

## Introduction

This chart bootstraps a Tiledesk deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Attention. The default configuration of the values.yaml download the *latest* docker images of each Tiledesk components. If you are deploying in a production environment please change the docker tag of each components to a stable version.

## Prerequisites

- Kubernetes 1.14+
- Helm 3.2+
- A Kubernetes Cluster. This guide is tested with: Minikube with [Ingress plugin enabled](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/#enable-the-ingress-controller) (This [Minkube Tiledesk Guide](./MINIKUBE.md) can be helpful) and Google Kubernetes Engine (GKE)


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
| chat21-server      | 0,5 | 512MB  |
| chat21-http-server | 0,2 | 200MB  |
| rabbitmq           | 0,2 | 512MB  |

We recommend a size at least 30 GiB for the database volume claim.

N1-standard-1 type is the minimum cluster type if you choose GKE.

## Download the project

Clone the repository and go to the deployment directory with :

```console
git clone https://github.com/Tiledesk/tiledesk-deployment.git
cd tiledesk-deployment
```

Optional. See [Configure Tiledesk with Chat21 Firebase Engine](./firebase-config.md) if you want to use the Chat21 Google Firebase chat engine instead the new Chat21 RabbitMQ + MQTT chat engine

## Installing the Chart

To install the chart with the release name `my-tiledesk`:

```console
helm install my-tiledesk helm
```

The command deploys Tiledesk on the Kubernetes cluster in the default namespace. 

# Open the dashboard
Open the browser at http://<YOUR_INGRESS_IP>/dashboard/ and signin as admin with :

* email: admin@tiledesk.com
* password: adminadmin

You can get the Ingress Ip from the Address column running ```kubectl get ingress my-tiledesk-proxy-nginx```

# Accessing Logs
This section describes how to get logs from the running containers.

1. Get the name of the pod which you want to get the logs of with: ```kubectl get pods```
If namespace is used run : ```kubectl --namespace <your namespace> get pods ```
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

2. To get the logs of the container run: ```kubectl --namespace <your namespace> logs -f <name of the pod>```

## Ingress

The default Tiledesk Ingress is configured whitout the hostname, so the rule applies to all inbound HTTP traffic through the IP address specified. There are other ingress hosts in the configuration but they are disabled by default. See the values.yaml file.

# Other configurations (Optional)

## Create an nginx Ingress controller
If your cluster doesn't have a built-in nginx ingress controller (ex. GKE) you must mannually deploy it with :

```console
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx/
helm install ingress-nginx ingress-nginx/ingress-nginx
```

More info here: https://kubernetes.github.io/ingress-nginx/deploy/#using-helm



## Configure a Custom Domain

As default setting for the Ingress configuration, the Tiledesk dashboard is also esposed under http://console.tiledesk.local/dashboard/ url.

Create a DNS entries (just for testing modify your /etc/hosts file) like below:
* console.tiledesk.local -> (A record) -> <YOUR_INGRESS_IP>
* api.tiledesk.local -> (A record) -> <YOUR_INGRESS_IP>
* widget.tiledesk.local -> (A record) -> <YOUR_INGRESS_IP>


You can configure the Custom Domain passing the Ingress parameters inline without modifing the value.yaml file for the hosts as follow:


```console
helm upgrade -f ./helm/values.yaml my-tiledesk ./helm --set EXTERNAL_BASE_URL=http://console.YOUR_CUSTOM_DOMAIN --set ingress.hosts[1].enabled=true --set ingress.hosts[1].host=console.YOUR_CUSTOM_DOMAIN
```

Disable the first ingress host (all inbound HTTP traffic through the IP address) if you want with : --set ingress.hosts[0].enabled=false

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
##  Passing inline environment variables

To install the `my-tiledesk` deployment passing the parameters inline without modifing the value.yaml you can for example :

```console
helm install helm --set EMAIL_ENABLED=true --set EMAIL_HOST=YOUR_EMAIL_HOST 
```

## Uninstalling the Chart

To uninstall/delete the `my-tiledesk` deployment:

```console
helm delete my-tiledesk
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
