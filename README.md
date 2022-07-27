# Tiledesk Introduction

Tiledesk is an Open Source Live Chat platform with integrated Chatbots written in NodeJs and Express. Build your own customer support with a multi-channel platform for Web, Android and iOS.

Designed to be open source since the beginning, we actively worked on it to create a totally new, first class customer service platform based on instant messaging.

What is Tiledesk today? It became the open source “conversational app development” platform that everyone needs 😌

You can use Tiledesk to increase sales for your website or for post-sales customer service. Every conversation can be automated using our first class native chatbot technology. You can also connect your own applications using our APIs or Webhooks. Moreover you can deploy entire visual applications inside a conversation. And your applications can converse with your chatbots or your end-users! We know this is cool 😎

Tiledesk is multichannel in a totally new way. You can write your chatbot scripts with images, buttons and other cool elements that your channels support. But you will configureyour chatbot replies only once. They will run on every channel, auto-adapting the responses to the target channel whatever it is, Whatsapp, Facebook Messenger, Telegram etc.

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
directly to your database. For the production environment we suggest you not to use the internal instance of K8s MongoDB but to use MongoAtlas or an external installation of MongoDB with Replica Set.
Another typical change would be the integration of your company-wide monitoring and logging tools.

# Enterprise version
Tiledesk Enterprise customers can request enterprise credentials sending and email at: info@tiledesk.com. These credentials are required to pull private (Enterprise-only) Docker images.

# Community? Questions? Support ?
If you need help or just want to hang out, come, say hi on our [<img width="15" alt="Tiledesk discord" src="https://seeklogo.com/images/D/discord-color-logo-E5E6DFEF80-seeklogo.com.png"> Discord](https://discord.gg/nERZEZ7SmG) server or make a post on our [Forum](https://tiledesk.discourse.group).
