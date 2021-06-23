# Create a cluster 

If you are running Tiledesk using Minikube start it using the following command:

```console
minikube start --vm=true --driver=hyperkit
```

After that remember to enable the ingress add-on with:

```console
minikube addons enable ingress
```

# Useful commands (Optional)

## Using minikube tunnel
Services of type LoadBalancer can be exposed via the minikube tunnel command. 

```console
minikube tunnel
```

More info here https://minikube.sigs.k8s.io/docs/handbook/accessing/#using-minikube-tunnel

## Open a service

```console
minikube service my-tiledesk-server
```

```console
minikube service my-tiledesk-c21httpsrv
```

## Get ingress detail

```console
kubectl get ingress my-tiledesk-proxy-nginx
```

## Get the SVC
```console
kubectl get svc 
```

## Get components SVC

```console
kubectl get svc my-tiledesk-mongodb -o wide 
kubectl get svc my-tiledesk-server -o wide 
kubectl get svc my-tiledesk-c21httpsrv -o wide 
```

## Increase disk space
```console
minikube config set disk-size 8000
```
