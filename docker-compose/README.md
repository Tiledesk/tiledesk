# Deploying Tiledesk Community using Docker Compose

Use this information to quickly start up Tiledesk Community using Docker Compose.

The Tiledesk Community Docker Compose file is beta and contains the latest work-in-progress deployment scripts and installs the latest development version of Tiledesk.

Our tests are executed using the latest version of Docker and Docker Compose provided by CircleCI.

## Prerequisites

To deploy Tiledesk Community using _docker-compose_, you'll need to install the following software:

| Component      | Installation Guide |
| ---------------| ------------------ |
| Docker         | https://docs.docker.com/ |
| Docker Compose | https://docs.docker.com/compose/install/ |

## Deploying Tiledesk Community
1. Download the [docker-compose](./docker-compose.yml) file running: 

```bash
curl https://raw.githubusercontent.com/Tiledesk/tiledesk-deployment/master/docker-compose/docker-compose.yml --output docker-compose.yml
```

2. Navigate to the folder where the _docker-compose.yml_ file is located.

3. Run Tiledesk with:
```bash
EXTERNAL_BASE_URL="http://localhost:8081" EXTERNAL_MQTT_BASE_URL="ws://localhost:8081" docker-compose up
```
If you have a public ip specify it in the EXTERNAL_BASE_URL and EXTERNAL_MQTT_BASE_URL env parameters as follow:  ```EXTERNAL_BASE_URL="http://99.88.77.66:8081" EXTERNAL_MQTT_BASE_URL="ws://99.88.77.66:8081" docker-compose up```


4. Open the following URL in your browser to start 
* Dashboard: [http://<machine_ip>:8081/](http://localhost:8081/)

5. Signin as admin with :
* email: admin@tiledesk.com
* password: adminadmin

**Note:**
* Make sure that exposed ports are open on your host. Check the _docker-compose.yml_ file to determine the exposed ports - refer to the ```host:container``` port definitions. You'll see they include 3000, 4200, 4500, 8082, 8004, 8081 and 5672,15672,1883,15675 for rabbitmq and 27017 for mongodb. Use for example ```sudo lsof -i -P -n | grep LISTEN``` linux command to check the ports are unused when Tiledesk is stopped.
* If Docker is running on your local machine, the <machine_ip> address will be just _localhost_.

## Run the lastest nightly build release

Run the lastest nightly build Tiledesk release with:

```bash
EXTERNAL_BASE_URL="http://localhost:8081" EXTERNAL_MQTT_BASE_URL="ws://localhost:8081" docker-compose -f docker-compose-latest.yml up
```

# Run in background
To start Tiledesk in background run:

```bash
EXTERNAL_BASE_URL="http://localhost:8081" EXTERNAL_MQTT_BASE_URL="ws://localhost:8081" docker-compose up -d
```
If you want to see the log run:

```bash
docker-compose logs -t -f --tail 5
```

# Setting up a custom domain
You can configure a custom domain to access to you installation (Ex http://mydomain.com) using an NGINX web server as a reverse proxy .

```bash
sudo apt-get install nginx
cd /etc/nginx/sites-enabled
nano mydomain.com.conf
```

Use the following Nginx config after replacing the mydomain.com in server_name .

```bash
map $http_upgrade $connection_upgrade {
        default upgrade;
        '' close;
}
server {
        listen 80;
        server_name mydomain.com;
        location / {
                proxy_pass http://localhost:8081;
                proxy_http_version 1.1;
                proxy_set_header        Upgrade $http_upgrade;
                proxy_set_header Connection $connection_upgrade;
        }
}
```
Verify and reload your Nginx config by running the following command.

```bash
nginx -t
sudo service nginx restart
```

Run Tiledesk with the custom domain:
```bash
EXTERNAL_BASE_URL="http://mydomain.com" EXTERNAL_MQTT_BASE_URL="ws://mydomain.com" docker-compose up
```

Your installation should be accessible from the http://mydomain.com now.


# Add HTTPS 
You can configure HTTPS using Let's Encrypt. 

```bash
apt  install certbot
apt-get install python3-certbot-nginx
certbot --nginx -d mydomain.com
```

Run Tiledesk with HTTPS :
```bash
EXTERNAL_BASE_URL="https://mydomain.com" EXTERNAL_MQTT_BASE_URL="wss://mydomain.com" docker-compose up
```
Attention you must specify *https* in the EXTERNAL_BASE_URL and *wss* in the EXTERNAL_MQTT_BASE_URL env variables.

Your installation should be accessible from the https://mydomain.com now.


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

# Try online with Play With Docker

<a href="https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/Tiledesk/tiledesk-deployment/master/docker-compose/docker-compose.yml" class="btn btn-default btn-lg">
  <img src="https://cdn.jsdelivr.net/gh/play-with-docker/stacks@cff22438/assets/images/button.png">
</a>


# Service Endpoints

| Service                                                                    | URL                              | Component             |
|----------------------------------------------------------------------------|----------------------------------|-----------------------|
| Reverse Proxy                                                              | http://localhost.8081/           | tiledesk-docker-proxy |
| [Tiledesk REST API](https://developer.tiledesk.com/apis/rest-api)          | http://localhost.8081/api/       | tiledesk-server       |
| [Tiledesk WebSocket API](https://developer.tiledesk.com/apis/realtime-api) | ws://localhost:8081/ws/          | tiledesk-server       |
| Tiledesk Dashboard                                                         | http://localhost:8081/dashboard/ | tiledesk-dashboard    |
| Web Chat                                                                   | http://localhost:8081/chat/      | chat21-ionic          |
| Widget                                                                     | http://localhost:8081/widget/    | chat21-web-widget     |
| Chat REST API                                                              | http://localhost:8081/chatapi/   | chat21-http-server    |
| Chat Server MQTT                                                           |                                  | chat21-server         |
| Rabbit MQ                                                                  | http://localhost:8081/mqws/      | chat21-rabbitmq       |
