# 🚀 Deploying Tiledesk Community with Docker Compose

This guide explains how to quickly deploy **Tiledesk Community** using **Docker Compose**.

> ⚠️ The Tiledesk Community Docker Compose configuration is currently in **beta**.  
> It contains the latest work-in-progress deployment scripts and installs the latest development version of Tiledesk.

All tests are executed using the most recent versions of **Docker** and **Docker Compose**, as provided by **CircleCI**.

---

## 🧩 Prerequisites

Before you begin, ensure that the following software is installed:

| Component      | Installation Guide |
|----------------|--------------------|
| **Docker**         | [https://docs.docker.com/](https://docs.docker.com/) |
| **Docker Compose** | [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/) |

---

## ⚙️ Deploying Tiledesk Community

1. **Download the Docker Compose file:**
   ```bash
   curl https://raw.githubusercontent.com/Tiledesk/tiledesk-deployment/master/docker-compose/docker-compose.yml --output docker-compose.yml
   ```

2. **Start Tiledesk:**
   ```bash
   docker-compose up
   ```

3. **Open your browser and visit:**
   [http://localhost:8081/](http://localhost:8081/)

4. **Sign in as admin:**
   - Email: `admin@tiledesk.com`
   - Password: `superadmin`

---

### 💡 Tips & Troubleshooting

- **Public IP Configuration:**  
  If you have a public IP, set it in the `EXTERNAL_BASE_URL` and `EXTERNAL_MQTT_BASE_URL` environment variables:
  ```bash
  EXTERNAL_BASE_URL="http://99.88.77.66:8081" EXTERNAL_MQTT_BASE_URL="ws://99.88.77.66:8081" docker-compose up
  ```

- **Port Configuration:**  
  Ensure that all required ports are available on your host.  
  Refer to the `docker-compose.yml` file to identify the exposed ports (e.g., `3000`, `4200`, `4500`, `8081`, `8082`, `8004`, `5672`, `15672`, `1883`, `15675`, `27017`).  
  Use the command below to verify that ports are not already in use:
  ```bash
  sudo lsof -i -P -n | grep LISTEN
  ```

---

## 🧠 Using RAG (Retrieval-Augmented Generation)

Tiledesk supports **RAG (Retrieval-Augmented Generation)** to enhance chatbot answers using your own data sources. The Community version use Qdrant as vectore store.


### ⚙️ Configuration Steps

1. **Configure the GPTKEY environment variable to enable managed GPT integration:**
   For a centralized, managed AI setup across multiple tenants (projects), set your `GPTKEY` in the `docker-compose.yml` file under the `server`, `chatbot`, `backend-llm-train`, and `backend-llm-qa` container sections:

   ```yaml
   GPTKEY=sk-proj-I0Noo...
   ```
   Alternatively, you can configure individual keys per project by specifying the corresponding API key in Settings → Integrations (See point 3).
   <br>

2. **(Optional) Custom Embeddings**
   In order to use custom embeddings instead of OpenAI's default ones, under the `server` container section, set:
   ```yaml
   EMBEDDINGS_PROVIDER=your-embeddings-provider       #i.e. huggingface
   EMBEDDINGS_NAME=your-embedding-name                #i.e. sentence-transformers/all-MiniLM-L6-v2
   EMBEDDINGS_DIMENSIONE=your-embeddings-dimension    #i.e. 384
   ```

3. **(Optional) Native and Custom Models (Ollama)**
   Tiledesk natively supports OpenAI models and various common LLM models such as: Google Gemini, Anthropic, Groq and Cohere, for which you need to enter your API Key on the Tiledesk platform.
   ```yaml
   Example: Go to Settings -> Integration -> Google Gemini and set your API Key
   ```
   And to configure Ollama with your custom models.
   
   ```yaml
   Example: Go to Settings -> Integration -> Ollama and set
      - Server URL: https://ollama-dev.mycompany.internal:11434
      - Models: the list of your supported models
   ```


---

## 🧱 Running in Background

To run Tiledesk in detached mode:
```bash
docker-compose up -d
```

To view logs:
```bash
docker-compose logs -t -f --tail 5
```

---

## 🌙 Running the Latest Nightly Build

Use the following command to deploy the latest nightly build:
```bash
docker-compose -f docker-compose-latest.yml up
```

---

## 🌐 Setting Up a Custom Domain

You can configure a custom domain (e.g., `http://mydomain.com`) using **NGINX** as a reverse proxy.

1. **Install and configure NGINX:**
   ```bash
   sudo apt-get install nginx
   cd /etc/nginx/sites-enabled
   sudo nano mydomain.com.conf
   ```

2. **Add the following configuration (replace `mydomain.com` with your domain):**
   ```nginx
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
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection $connection_upgrade;
       }
   }
   ```

3. **Validate and restart NGINX:**
   ```bash
   sudo nginx -t
   sudo service nginx restart
   ```

4. **Run Tiledesk with your domain:**
   ```bash
   EXTERNAL_BASE_URL="http://mydomain.com" EXTERNAL_MQTT_BASE_URL="ws://mydomain.com" docker-compose up
   ```

Your installation should now be accessible at:  
👉 [http://mydomain.com](http://mydomain.com)

---

## 🔒 Adding HTTPS with Let's Encrypt

1. **Install Certbot and the NGINX plugin:**
   ```bash
   sudo apt install certbot
   sudo apt-get install python3-certbot-nginx
   ```

2. **Obtain and install the SSL certificate:**
   ```bash
   sudo certbot --nginx -d mydomain.com
   ```

3. **Run Tiledesk with HTTPS:**
   ```bash
   EXTERNAL_BASE_URL="https://mydomain.com" EXTERNAL_MQTT_BASE_URL="wss://mydomain.com" docker-compose up
   ```

> ⚠️ Make sure to use:
> - `https` in `EXTERNAL_BASE_URL`
> - `wss` in `EXTERNAL_MQTT_BASE_URL`

Your installation should now be accessible at:  
👉 [https://mydomain.com](https://mydomain.com)

---

## 🔄 Updating Tiledesk

To update all Tiledesk images to the latest version:
```bash
docker-compose pull
```

---

## 🧹 Cleanup

To stop and remove all containers:
```bash
docker-compose down
```

To also remove volumes:
```bash
docker-compose down -v
```

---

## 🧪 Try Online with Play With Docker

You can test Tiledesk directly in your browser using **Play With Docker**:

[![Try in Play With Docker](https://cdn.jsdelivr.net/gh/play-with-docker/stacks@cff22438/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/Tiledesk/tiledesk-deployment/master/docker-compose/docker-compose.yml)

---

## 📡 Service Endpoints

| Service | URL | Component |
|----------|-----|-----------|
| **Reverse Proxy** | [http://localhost:8081/](http://localhost:8081/) | tiledesk-docker-proxy |
| **Tiledesk REST API** ([docs](https://developer.tiledesk.com/apis/rest-api)) | [http://localhost:8081/api/](http://localhost:8081/api/) | tiledesk-server |
| **Tiledesk WebSocket API** ([docs](https://developer.tiledesk.com/apis/realtime-api)) | `ws://localhost:8081/ws/` | tiledesk-server |
| **Tiledesk Dashboard** | [http://localhost:8081/dashboard/](http://localhost:8081/dashboard/) | tiledesk-dashboard |
| **Web Chat** | [http://localhost:8081/chat/](http://localhost:8081/chat/) | chat21-ionic |
| **Widget** | [http://localhost:8081/widget/](http://localhost:8081/widget/) | chat21-web-widget |
| **Chat REST API** | [http://localhost:8081/chatapi/](http://localhost:8081/chatapi/) | chat21-http-server |
| **Chat Server MQTT** | – | chat21-server |
| **RabbitMQ** | [http://localhost:8081/mqws/](http://localhost:8081/mqws/) | chat21-rabbitmq |

> 💡 If SSL is enabled, replace `http` with `https` and `ws` with `wss`.

---
