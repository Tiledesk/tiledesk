# Deploying Tiledesk Community using Docker Compose

Use this information to quickly start up Tiledesk Community using Docker Compose.

## Prerequisites

To deploy Tiledesk Community using _docker-compose_, you'll need to install the following software:

| Component      | Installation Guide |
| ---------------| ------------------ |
| Docker         | https://docs.docker.com/ |
| Docker Compose | https://docs.docker.com/compose/install/ |

## Deploying Tiledesk Community
1. Download the [docker-compose](./docker-compose.yml) file running: 

```
curl https://raw.githubusercontent.com/Tiledesk/tiledesk-deployment/master/docker-compose/docker-compose.yaml --output docker-compose.yml
```

2. Navigate to the folder where the _docker-compose.yml_ file is located.

3. Run Tiledesk with:
```
docker-compose up
```

4. Open the following URL in your browser to start 
* Dashboard: [http://<machine_ip>/](http://localhost/)

5. Signin as admin with :
* email: admin@tiledesk.com
* password: adminadmin

**Note:**
* Make sure that exposed ports are open on your host. Check the _docker-compose.yml_ file to determine the exposed ports - refer to the ```host:container``` port definitions. You'll see they include 3000, 4200, 4500 and others.
* If Docker is running on your local machine, the IP address will be just _localhost_.
* If you're using the [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows), run the following command to find the IP address:
```bash
docker-machine ip
```

