
# TLS
To configure TLS (HTTPS) you must:
1) Get an SSL Certificate
2) Create a secret for the SSL certificate
3) Update the Ingress with the TLS configuration

## Get an SSL Certificate
To get the SSL Certificate you can:
* Generate a new SSL Certificate
* Use your existing SSL Certificate

### Generate a new SSL certificate

#### Generate self signed TLS certificates
For this article, let’s generate a self-signed certificate with openssl. For production use, you should request a trusted, signed certificate through a provider or your own certificate authority (CA). 

The following example generates a 2048-bit RSA X509 certificate valid for 365 days named *tiledesk-ingress-tls.crt*. The private key file is named *tiledesk-ingress-tls.key*. A Kubernetes TLS secret requires *both* of these files.

This article works with the *console.tiledesk.local* subject common name and doesn't need to be changed. For production use, specify your own organizational values for the -subj parameter:

```console
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out tiledesk-ingress-tls.crt \
    -keyout tiledesk-ingress-tls.key \
    -subj "/CN=console.tiledesk.local/O=tiledesk-ingress-tls"
```


#### Generate GKE Managed TLS certificates


If you are using Google Kubernetes Engine (GKE) you can optionally choose the Google ManagedCertificate resource. This resource specifies the domains that the SSL certificate will be created for. Remember that [Google managed-certs are only supported for GKE External Ingress](https://cloud.google.com/load-balancing/docs/ssl-certificates/google-managed-certs)

Create a file named certificate-tiledesk.yaml like below:

```
apiVersion: networking.gke.io/v1beta1
kind: ManagedCertificate
metadata:
 name: certificate-tiledesk
spec:
 domains:
  - console.tiledesk.local
```
After you must:
* Create the DNS entry
* Create a new certificate running:

```console
kubectl apply -f certificate-tiledesk.yaml
```

View your ssl certificates with:  ```kubectl describe managedcertificate certificate-tiledesk```. You can also use : ```gcloud beta compute ssl-certificates list --project GOOGLE_PROJECT_NAME```. If you want to delete an existing GKE certificate run: ```gcloud compute ssl-certificates delete CERTIFICATE_ID --project GOOGLE_PROJECT_NAME```


### Use your existing SSL Certificate
if you already have a valid SSL certificate released by a trusted CA, copy the certificate to the project folder and  rename your SSL files like follow:
* tiledesk-ingress-tls.crt. This must be the server certificate
* tiledesk-ingress-tls.key. This must be the private key.


## Create a secret for the SSL certificate

Create a Kubernetes Secret of the certificate using the following command:

```console
kubectl create secret tls tiledesk-tls-secret --key tiledesk-ingress-tls.key --cert tiledesk-ingress-tls.crt
```

The required files are:
* tiledesk-ingress-tls.crt. This is the server certificate
* tiledesk-ingress-tls.key. This is the private key.


## Update the Ingress with the TLS configuration
Update the TLS Ingress Rule with :

```console
helm upgrade -f ./helm/values.yaml my-tiledesk ./helm --set ingress.tls[0].secretName=tiledesk-tls-secret --set ingress.tls[0].hosts[0]=console.YOUR_CUSTOM_DOMAIN --set MQTT_ENDPOINT=wss://console.YOUR_CUSTOM_DOMAIN/mqws/ws --set EXTERNAL_BASE_URL=https://console.YOUR_CUSTOM_DOMAIN --set ingress.hosts[0].enabled=false --set ingress.hosts[1].enabled=true --set ingress.hosts[1].host=console.YOUR_CUSTOM_DOMAIN
```
Add ```--recreate-pods``` option to the above command if you want to be sure all the pods are restarted with the new values.

With the MQTT_ENDPOINT env variable we are setting an absolute secure (wss) websocket URL.

Please see [this example](https://github.com/kubernetes/contrib/tree/master/ingress/controllers/nginx/examples/tls) for more information.



