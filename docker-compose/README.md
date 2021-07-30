# Deploying Tiledesk Community using Docker Compose

Use this information to quickly start up Tiledesk Community using Docker Compose.

The Tiledesk Community Docker Compose file is beta and contains the latest work-in-progress deployment scripts and installs the latest development version of Tiledesk.

Our tests are executed using the latest version of Docker and Docker Compose provided by Travis.

## Prerequisites

To deploy Tiledesk Community using _docker-compose_, you'll need to install the following software:

| Component      | Installation Guide |
| ---------------| ------------------ |
| Docker         | https://docs.docker.com/ |
| Docker Compose | https://docs.docker.com/compose/install/ |

## Deploying Tiledesk Community
1. Download the [docker-compose](./docker-compose.yaml) file running: 

```bash
curl https://raw.githubusercontent.com/Tiledesk/tiledesk-deployment/master/docker-compose/docker-compose.yaml --output docker-compose.yml
```

2. Navigate to the folder where the _docker-compose.yml_ file is located.

3. Run Tiledesk with:
```bash
EXTERNAL_BASE_URL="http://localhost" EXTERNAL_MQTT_BASE_URL="ws://localhost" docker-compose up
```
If you have a public ip specify it in the EXTERNAL_BASE_URL and EXTERNAL_MQTT_BASE_URL env parameters as follow:  ```EXTERNAL_BASE_URL="http://99.88.77.66" EXTERNAL_MQTT_BASE_URL="ws://99.88.77.66" docker-compose up```

4. Open the following URL in your browser to start 
* Dashboard: [http://<machine_ip>/](http://localhost/)

5. Signin as admin with :
* email: admin@tiledesk.com
* password: adminadmin

**Note:**
* Make sure that exposed ports are open on your host. Check the _docker-compose.yml_ file to determine the exposed ports - refer to the ```host:container``` port definitions. You'll see they include 3000, 4200, 4500, 8080, 8004, 80 and 5672,15672,1883,15675 for rabbitmq and 27017 for mongodb. Use for example ```sudo lsof -i -P -n | grep LISTEN``` linux command to check the ports are unused when Tiledesk is stopped.
* If Docker is running on your local machine, the <machine_ip> address will be just _localhost_.

# Run in background
To start Tiledesk in background run:

```bash
EXTERNAL_BASE_URL="http://localhost" EXTERNAL_MQTT_BASE_URL="ws://localhost" docker-compose up -d
```
If you want to see the log run:

```bash
docker-compose logs -t -f --tail 5
```
# Update
To update Tiledesk images to the latest version, run:
```bash
docker-compose pull
```

# Cleanup
To bring the system down and cleanup the containers run the following command:

```bash
docker-compose down
```
To delete also the volumes run: 
```bash
docker-compose down -v
```
# Service Endpoints

| Service                                                                    | URL                         | Component             |
|----------------------------------------------------------------------------|-----------------------------|-----------------------|
| Reverse Proxy                                                              | http://localhost/           | tiledesk-docker-proxy |
| [Tiledesk REST API](https://developer.tiledesk.com/apis/rest-api)          | http://localhost/api/       | tiledesk-server       |
| [Tiledesk WebSocket API](https://developer.tiledesk.com/apis/realtime-api) | ws://localhost/ws/          | tiledesk-server       |
| Tiledesk Dashboard                                                         | http://localhost/dashboard/ | tiledesk-dashboard    |
| Web Chat                                                                   | http://localhost/chat/      | chat21-ionic          |
| Widget                                                                     | http://localhost/widget/    | chat21-web-widget     |
| Chat REST API                                                              | http://localhost/chatapi/   | chat21-http-server    |
| Chat Server MQTT                                                           |                             | chat21-server         |
| Rabbit MQ                                                                  | http://localhost/mqws/      | chat21-rabbitmq       |
