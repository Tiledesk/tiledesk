# Get the services 
```
kubectl get services
```

# Create namespace
```
kubectl create namespace ci
```

# Debugging the Chart

```
helm template helm/ > a.yaml
```






helm repo add bitnami https://charts.bitnami.com/bitnami
helm install tiledesk-rabbitmq-prod-01 bitnami/rabbitmq
helm delete tiledesk-rabbitmq-prod-01
user:p4a0IcH9P1
ErLang Cookie : eYnbstGzGFMwVGsTZ0i55AXXhZlC9RGh


NAME: tiledesk-rabbitmq-prod-01
LAST DEPLOYED: Thu Jun 24 12:46:29 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

Credentials:

    echo "Username      : user"
    echo "Password      : $(kubectl get secret --namespace default tiledesk-rabbitmq-prod-01 -o jsonpath="{.data.rabbitmq-password}" | base64 --decode)"
    echo "ErLang Cookie : $(kubectl get secret --namespace default tiledesk-rabbitmq-prod-01 -o jsonpath="{.data.rabbitmq-erlang-cookie}" | base64 --decode)"

RabbitMQ can be accessed within the cluster on port  at tiledesk-rabbitmq-prod-01.default.svc.

To access for outside the cluster, perform the following steps:

To Access the RabbitMQ AMQP port:

    echo "URL : amqp://127.0.0.1:5672/"
    kubectl port-forward --namespace default svc/tiledesk-rabbitmq-prod-01 5672:5672

To Access the RabbitMQ Management interface:

    echo "URL : http://127.0.0.1:15672/"
    kubectl port-forward --namespace default svc/tiledesk-rabbitmq-prod-01 15672:15672



https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/#forward-a-local-port-to-a-port-on-the-pod


kubectl port-forward my-rabbit-test-rabbitmq-0 15672:5672



helm template helm  > a.yaml

helm template helm   --set ingress.annotations."networking.gke.io/managed-certificates: certificate-tiledesk" > b.yaml

networking\.gke\.io/managed-certificates: certificate-tiledesk