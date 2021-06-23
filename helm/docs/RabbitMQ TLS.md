
## Enable RabbitMQ TLS

First create a certificate for RabbitMQ:

https://www.rabbitmq.com/ssl.html#automated-certificate-generation

```console
kubectl create secret tls tiledesk-tls-secret --key tiledesk-ingress-tls.key --cert tiledesk-ingress-tls.crt
kubectl create secret generic rabbitmq-certificates33 --from-file=./ca.crt --from-file=./tls.crt --from-file=./tls.key


```


cd tls-gen/basic/result
kubectl create secret generic rabbitmq-certificates --from-file=./ca_certificate.pem --from-file=./server_certificate.pem --from-file=./server_key.pem

Update with:

```console
helm upgrade -f ./helm/values.yaml my-tiledesk ./helm --set rabbitmq.auth.tls.enabled=true --set rabbitmq.auth.tls.existingSecret=rabbitmq-certificates33
```



Info here to [Enable TLS for RabbitMQ](https://docs.bitnami.com/kubernetes/infrastructure/rabbitmq/administration/enable-tls/)


