
# Tiledesk Deployment

This project contains the code for starting the entire Tiledesk product with **Docker** or **Kubernetes**.

The **master** branch of this repository will endeavour to support the following deployments:
- [Docker Compose](docs/docker-compose-deployment.md) (latest): For development and trials
- [MiniKube](docs/helm-deployment-minikube.md) (latest): For development and POCs
- [Helm - AWS Cloud with Kubernetes using Kops](docs/helm-deployment-aws_kops.md) (latest): As a deployment template which can be used as the basis for your specific deployment needs

To work with a specific release of Tiledesk, please refer to the [Helm Chart Releases](docs/helm-chart-releases.md) and select the appropriate tag for this repository.

## Contents of the deployment
Tiledesk deployed via `docker-compose` or Kubernetes contains the following:
1. Tiledesk Server
2. Tiledesk Dashboard
3. Chat21 ionic
4. Chat21 Web Widget
5. A Mongo DB  
6. A proxy

## Deployment options
* [Deploying with Helm charts on AWS using Kops](docs/helm-deployment-aws_kops.md)
* [Deploying with Helm charts on AWS using EKS](docs/helm-deployment-aws_eks.md)
* [Deploying with Helm charts using Minikube](docs/helm-deployment-minikube.md)
* [Deploying using Docker Compose](docs/docker-compose-deployment.md)
* [Customizing your deployment](docs/customising-deployment.md)

## Production environments
Tiledesk provides tested Helm charts as a "deployment template" for customers who want to take advantage of the container orchestration benefits of Kubernetes. These Helm charts are undergoing continual development and improvement, and should not be used "as is" for your production environments, but should help you save time and effort deploying Tiledesk for your organisation.

The Helm charts in this repository provide a MongoDB database in a Docker container and do not configure
any logging. This design has been chosen so that they can be installed in a Kubernetes cluster without
changes and are still flexible to be adopted to your actual environment. 

For your environment, you should use these charts as a starting point and modify them so that Tiledesk integrates
into your infrastructure. You typically want to remove the MongoDB container and connect the tiledesk-server
directly to your database.
Another typical change would be the integration of your company-wide monitoring and logging tools.

## Other information
* See alternative commands and start up [tutorial with AWS support](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md)
* [Tips and tricks](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/tips-and-tricks.md) for working with Kubernetes and Alfresco Content Services.
* The images downloaded directly from Docker Hub, or Quay.io are for a limited trial of the Enterprise version of Alfresco Content Services that goes into read-only mode after 2 days. Request an extended 30-day trial at
 https://www.alfresco.com/platform/content-services-ecm/trial/docker
* Alfresco customers can request Quay.io credentials by logging a ticket with [Alfresco Support](https://support.alfresco.com/). These credentials are required to pull private (Enterprise-only) Docker images from Quay.io.
