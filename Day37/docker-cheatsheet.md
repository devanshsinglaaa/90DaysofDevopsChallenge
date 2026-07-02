# 🐳 Docker Cheat Sheet

A quick reference for commonly used Docker commands and Dockerfile instructions.

---

# 📦 Container Commands

| Command | Description |
|----------|-------------|
| `docker run image` | Run a container |
| `docker run -it image` | Interactive container |
| `docker run -d image` | Detached mode |
| `docker run --name myapp image` | Run with custom name |
| `docker run -p 8080:80 image` | Map host port to container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop container` | Stop a container |
| `docker start container` | Start a stopped container |
| `docker restart container` | Restart container |
| `docker rm container` | Remove container |
| `docker exec -it container sh` | Open shell inside container |
| `docker logs container` | View logs |
| `docker logs -f container` | Follow logs |

---

# 🖼 Image Commands

| Command | Description |
|----------|-------------|
| `docker build -t app .` | Build image |
| `docker images` | List images |
| `docker image ls` | List images |
| `docker rmi image` | Remove image |
| `docker pull image` | Download image |
| `docker push image` | Push image |
| `docker tag image user/image:v1` | Tag image |
| `docker history image` | View image layers |
| `docker inspect image` | Inspect image |

---

# 💾 Volume Commands

| Command | Description |
|----------|-------------|
| `docker volume create data` | Create volume |
| `docker volume ls` | List volumes |
| `docker volume inspect data` | Inspect volume |
| `docker volume rm data` | Remove volume |

---

# 🌐 Network Commands

| Command | Description |
|----------|-------------|
| `docker network ls` | List networks |
| `docker network create backend` | Create network |
| `docker network inspect backend` | Inspect network |
| `docker network connect backend container` | Connect container |
| `docker network rm backend` | Remove network |

---

# 🐳 Docker Compose

| Command | Description |
|----------|-------------|
| `docker compose up` | Start services |
| `docker compose up -d` | Detached mode |
| `docker compose up --build` | Rebuild & start |
| `docker compose down` | Stop containers |
| `docker compose down -v` | Remove containers & volumes |
| `docker compose ps` | List compose services |
| `docker compose logs` | View logs |
| `docker compose build` | Build images |
| `docker compose restart` | Restart services |

---

# 🧹 Cleanup Commands

| Command | Description |
|----------|-------------|
| `docker system df` | Docker disk usage |
| `docker system prune` | Remove unused resources |
| `docker image prune` | Remove dangling images |
| `docker container prune` | Remove stopped containers |
| `docker volume prune` | Remove unused volumes |
| `docker network prune` | Remove unused networks |

---

# 📝 Dockerfile Instructions

| Instruction | Purpose |
|-------------|----------|
| `FROM` | Base image |
| `WORKDIR` | Working directory |
| `COPY` | Copy local files |
| `ADD` | Copy + extract archives / remote URLs |
| `RUN` | Execute commands during build |
| `ENV` | Environment variables |
| `EXPOSE` | Document container port |
| `CMD` | Default command |
| `ENTRYPOINT` | Fixed executable |
| `LABEL` | Metadata |
| `USER` | Run as specific user |
| `ARG` | Build-time variables |

---

# ⚡ Multi-Stage Build Pattern

```Dockerfile
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
```

---

# 🔥 Common Docker Run Options

```
-it          Interactive terminal
-d           Detached mode
-p           Port mapping
-v           Volume mapping
--name       Container name
--network    Network
-e           Environment variable
--rm         Remove after exit
```

---

# 📚 Common Port Mapping

```
-p 3000:80

Host Port      →     Container Port
3000                 80
```

---

# 📁 Volume Mapping

```
-v mysql_data:/var/lib/mysql
```

Named volume

---

```
-v $(pwd):/app
```

Bind mount

---

# 🌐 Container Communication

Containers on the same Docker network communicate using

```
service-name:port
```

Example

```
backend → mysql:3306
```

No IP addresses required.

---

# 🚀 Docker Hub

```
docker login

docker tag app username/app:v1

docker push username/app:v1

docker pull username/app:v1
```

---

# 💡 Best Practices

- Use Alpine images
- Use Multi-stage builds
- Use `.dockerignore`
- Install production dependencies only
- Don't run containers as root
- Use named volumes
- Use healthchecks
- Pin image versions
- Store secrets in environment variables
- Keep images small

---

Happy Dockering! 🐳