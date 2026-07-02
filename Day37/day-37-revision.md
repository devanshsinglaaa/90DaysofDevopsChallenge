# Day 37 – Docker Revision & Self Assessment

## Objective

Today was dedicated to revising everything learned from Day 29 through Day 36. Instead of learning new concepts, the focus was on reinforcing Docker fundamentals, reviewing commands, and identifying weak areas.

---

# Self Assessment Checklist

| Topic | Status |
|--------|--------|
| Run containers (Interactive & Detached) | ✅ Can Do |
| List, Stop & Remove Containers | ✅ Can Do |
| Explain Images & Layers | ✅ Can Do |
| Write Dockerfile | ✅ Can Do |
| CMD vs ENTRYPOINT | ✅ Can Do |
| Build & Tag Images | ✅ Can Do |
| Named Volumes | ✅ Can Do |
| Bind Mounts | ✅ Can Do |
| Custom Networks | ✅ Can Do |
| Docker Compose | ✅ Can Do |
| Environment Variables | ✅ Can Do |
| Multi-stage Builds | ✅ Can Do |
| Push Images to Docker Hub | ✅ Can Do |
| Healthchecks & depends_on | ✅ Can Do |

---

# Quick Fire Answers

## 1. Image vs Container

Image is a read-only template.

Container is a running instance of an image.

---

## 2. What happens when a container is removed?

Any data stored inside the container is lost unless it is stored in a Docker Volume or Bind Mount.

---

## 3. How do containers communicate?

Containers on the same custom Docker network communicate using their service or container names.

Example

```
backend → mysql
```

---

## 4. Difference between

```
docker compose down
```

and

```
docker compose down -v
```

`down`

- Removes containers
- Preserves volumes

`down -v`

- Removes containers
- Removes volumes
- Deletes database data

---

## 5. Why use Multi-stage Builds?

- Smaller images
- Faster deployments
- Better security
- Production optimized

---

## 6. COPY vs ADD

COPY

- Copies local files

ADD

- Copies files
- Can extract archives
- Supports remote URLs

COPY is recommended unless ADD features are required.

---

## 7. Meaning of

```
-p 8080:80
```

Maps

Host Port

```
8080
```

to

Container Port

```
80
```

---

## 8. Docker Disk Usage

```
docker system df
```

---

# Topics Revised

- Docker Images
- Containers
- Dockerfile
- Docker Compose
- Networks
- Volumes
- Multi-stage Builds
- Docker Hub
- Environment Variables
- Healthchecks
- Container Debugging

---

# Practical Revision

Revisited the deployment of the Production Management System created during Day 36.

Verified

- Frontend
- Backend
- MySQL
- Docker Network
- Persistent Volumes
- Healthchecks
- Nginx Configuration
- React SPA Routing

---

# Key Learnings

Over the past few days I have learned how Docker enables consistent application deployment by packaging applications and their dependencies into lightweight containers.

I also gained hands-on experience with:

- Multi-container deployments
- Container networking
- Persistent storage using volumes
- Image optimization with multi-stage builds
- Docker Hub image publishing
- Debugging real deployment issues
- Deploying a production-style full-stack application

These concepts closely match real-world DevOps workflows and provide a strong foundation for moving towards CI/CD, Kubernetes, and cloud deployments.

---

# Weak Areas

Although I am comfortable with Docker fundamentals, I plan to practice the following topics further:

- Reverse Proxy configuration with Nginx
- Docker Swarm (upcoming)
- Docker Secrets
- Image security scanning

---

# Outcome

✅ Revised Docker fundamentals

✅ Reviewed all important Docker commands

✅ Strengthened understanding of Docker Compose

✅ Practiced multi-container architecture

✅ Revisited image optimization

✅ Improved troubleshooting skills

✅ Ready to move to Kubernetes and CI/CD topics

---

**Day 37 Complete ✅**

**#90DaysOfDevOps**