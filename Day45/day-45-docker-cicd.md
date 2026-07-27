# 🚀 Day 45 – Complete CI/CD Pipeline with GitHub Actions, Docker Hub & AWS EC2

## 📌 Objective

Today I built a complete **CI/CD pipeline** for my full-stack application using **GitHub Actions**, **Docker**, **Docker Hub**, and a **Self-Hosted Runner** on AWS EC2.

The goal was to automate the entire deployment process so that every push to GitHub automatically builds, publishes, and deploys the latest version of the application without any manual intervention.

---

# 🛠 Tech Stack

- Git & GitHub
- GitHub Actions
- Docker
- Docker Compose
- Docker Hub
- AWS EC2
- Self-Hosted GitHub Runner
- React (Vite)
- Node.js
- Express.js
- MySQL

---

# 📂 Project Structure

```
login-react/
│
├── .github/
│   └── workflows/
│       └── cicd.yml
│
├── backend/
│   ├── Dockerfile
│
├── outstaff-app/
│   ├── Dockerfile
│
├── docker-compose.yml
│
└── README.md
```

---

# ⚙ CI/CD Workflow

```yaml
name: cicd_login_react

on:
  push:
    branches:
      - cicd_branch

jobs:

  docker-ci:
    runs-on: ubuntu-latest

    steps:

      - name: Code checkout
        uses: actions/checkout@v4

      - name: Docker login
        uses: docker/login-action@v4
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Docker Build and Push Frontend
        uses: docker/build-push-action@v6
        with:
          context: ./outstaff-app
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/login-react-frontend:latest

      - name: Docker Build and Push Backend
        uses: docker/build-push-action@v6
        with:
          context: ./backend
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/login-react-backend:latest

  docker-cd:
    runs-on: self-hosted

    needs: docker-ci

    steps:

      - name: Code checkout
        uses: actions/checkout@v4

      - name: Docker login
        uses: docker/login-action@v4
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Deploy containers
        run: |
          docker compose pull
          docker compose up -d --force-recreate
```

---

# 🔄 CI Pipeline

The Continuous Integration (CI) job performs the following tasks:

- Checks out the latest source code
- Logs into Docker Hub
- Builds the frontend Docker image
- Builds the backend Docker image
- Pushes both images to Docker Hub

This ensures that every commit always produces fresh Docker images.

---

# 🚀 CD Pipeline

The Continuous Deployment (CD) job runs on my AWS EC2 Self-Hosted Runner.

Once the CI job finishes successfully, GitHub Actions automatically:

- Pulls the latest Docker images
- Recreates the running containers
- Deploys the updated application

No manual SSH or Docker commands are required.

---

# 🐳 Docker Images

Frontend

```
https://hub.docker.com/r/devopsdevansh/login-react-frontend
```

Backend

```
https://hub.docker.com/r/devopsdevansh/login-react-backend
```

---

# ☁ Deployment Architecture

```
                 Git Push
                     │
                     ▼
              GitHub Repository
                     │
                     ▼
           GitHub Actions (CI)
      ┌─────────────────────────┐
      │ Checkout Source Code    │
      │ Build Docker Images     │
      │ Push to Docker Hub      │
      └─────────────────────────┘
                     │
                     ▼
         GitHub Actions (CD Job)
      (AWS EC2 Self-Hosted Runner)
                     │
                     ▼
           docker compose pull
                     │
                     ▼
 docker compose up -d --force-recreate
                     │
                     ▼
        Updated Application Running
```

---

# 📚 What I Learned

- Difference between CI and CD
- Creating GitHub Actions workflows
- Building Docker images automatically
- Publishing images to Docker Hub
- Using GitHub Secrets securely
- Setting up a Self-Hosted Runner
- Automating deployments on AWS EC2
- Deploying applications with Docker Compose
- Debugging CORS, Docker networking, and environment variable issues
- Understanding production deployment workflows

---

# 🎯 Challenges Faced

During this project I encountered several real-world issues, including:

- Docker Compose configuration errors
- CORS policy errors
- Incorrect environment variables
- Frontend pointing to localhost instead of the deployed backend
- Docker networking issues
- Self-hosted runner configuration
- Authentication and password validation issues

Each issue helped me understand how production deployments work and improved my troubleshooting skills.

---

# ✅ Outcome

Successfully implemented a fully automated CI/CD pipeline where:

✔ Pushing code to GitHub triggers GitHub Actions

✔ Docker images are built automatically

✔ Images are pushed to Docker Hub

✔ AWS EC2 Self-Hosted Runner deploys the latest images

✔ Docker Compose recreates the containers automatically

✔ Application is updated without manual deployment

---

# 📸 Screenshots

Include the following screenshots:

- Successful GitHub Actions workflow
- Docker Hub repositories
- Self-Hosted Runner online
- Running Docker containers
- Live application after deployment

---

# 🚀 Key Takeaway

CI ensures every code change is built and packaged correctly.

CD ensures those changes are automatically deployed to the server.

Together, CI/CD enables faster, more reliable, and repeatable software delivery while reducing manual effort and deployment errors.

---

# 🔖 Tags

#90DaysOfDevOps
#TrainWithShubham
#GitHubActions
#CI
#CD
#Docker
#DockerCompose
#DockerHub
#AWS
#EC2
#React
#NodeJS
#Express
#MySQL
#DevOps
#Cloud
#Automation