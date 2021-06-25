
# Tiledesk Deployment

This project contains the code for starting the entire Tiledesk product with **Docker** or **Kubernetes**.

The **master** branch of this repository will endeavour to support the following deployments:
- [Docker Compose](./docker-compose/README.md) (latest): For development and trials
- [Kubernetes with Helm](helm/README.md) (latest): For development, POCs and production


## Contents of the deployment
Tiledesk deployed via `docker-compose` or Kubernetes contains the following:
1. Tiledesk Server
2. Tiledesk Dashboard
3. Chat21 ionic
4. Chat21 Web Widget
5. Chat21 Server
6. Chat21 Http Server
7. A Mongo DB  
8. A proxy

## Production environments
Tiledesk provides tested Helm charts as a "deployment template" for customers who want to take advantage of the container orchestration benefits of Kubernetes. These Helm charts are undergoing continual development and improvement, and should not be used "as is" for your production environments, but should help you save time and effort deploying Tiledesk for your organisation.

The Helm charts in this repository provide a MongoDB database in a Docker container and do not configure
any logging. This design has been chosen so that they can be installed in a Kubernetes cluster without
changes and are still flexible to be adopted to your actual environment. 

For your environment, you should use these charts as a starting point and modify them so that Tiledesk integrates
into your infrastructure. You typically want to remove the MongoDB container and connect the tiledesk-server
directly to your database.
Another typical change would be the integration of your company-wide monitoring and logging tools.

# Enterprise version
Tiledesk Enterprise customers can request enterprise credentials sending and email at: info@tiledesk.com. These credentials are required to pull private (Enterprise-only) Docker images.
