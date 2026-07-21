# Day 39 – CI/CD Concepts

## 📌 Objective

Understand the fundamentals of **Continuous Integration (CI)**, **Continuous Delivery (CD)**, and **Continuous Deployment**, learn the anatomy of a CI/CD pipeline, and explore how modern software teams automate building, testing, and deploying applications.

---

# What is CI/CD?

CI/CD is a software development practice that automates the process of integrating code changes, testing applications, and deploying them to servers.

Instead of manually building and deploying software, CI/CD pipelines perform these tasks automatically whenever code changes are pushed to a repository.

---

# Why Do We Need CI/CD?

Imagine a team of five developers working on the same project.

Without CI/CD:

- Developers manually merge code.
- Someone manually builds the project.
- Tests are run manually.
- Deployment is done manually.
- Bugs are discovered after deployment.

Common problems include:

- Merge conflicts
- Developers overwriting each other's code
- Feature compatibility issues
- Docker configuration conflicts
- Database migration conflicts
- No automated testing
- Slow deployments

CI/CD solves these problems by automating repetitive tasks.

---

# "It Works on My Machine"

One of the most common software development problems is:

> "It works on my machine."

This usually happens because developers have different environments.

Examples:

- Different Node.js versions
- Different Go versions
- Different dependency versions
- Missing environment variables (.env)
- Different operating systems
- Different database versions

Using Docker and CI pipelines ensures everyone builds and tests the application in the same environment.

---

# Manual Deployment vs CI/CD

## Manual Deployment

A developer must:

- Pull latest code
- Install dependencies
- Build the project
- Run tests
- Build Docker image
- Push image
- SSH into the server
- Deploy application
- Verify deployment

Manual deployments are slow and error-prone.

---

## Automated CI/CD

Developer pushes code.

Everything else happens automatically.

```text
Developer Push
      │
      ▼
GitHub Actions
      │
      ▼
Build
      │
      ▼
Test
      │
      ▼
Deploy
```

---

# Continuous Integration (CI)

Continuous Integration automatically validates every code change.

Typical CI process:

```text
Developer Push
      │
      ▼
Checkout Code
      │
      ▼
Install Dependencies
      │
      ▼
Run Linter
      │
      ▼
Run Tests
      │
      ▼
Build Project
```

CI ensures:

- Code builds successfully
- Tests pass
- Code follows quality standards
- Bugs are detected early

---

# Continuous Delivery

Continuous Delivery goes one step further.

After successful testing and building, the application is prepared for deployment.

However, deployment still requires **manual approval**.

```text
Push
  │
Build
  │
Test
  │
Ready for Production
  │
Manual Approval
  │
Deploy
```

Common in:

- Banking
- Healthcare
- Airlines
- Government systems

---

# Continuous Deployment

Continuous Deployment automates everything.

If all tests pass, deployment happens automatically.

```text
Push
 │
Build
 │
Test
 │
Deploy Automatically
```

Common in:

- Netflix
- Amazon
- Meta
- Google

---

# CI vs Continuous Delivery vs Continuous Deployment

| Feature | CI | Continuous Delivery | Continuous Deployment |
|----------|----|--------------------|----------------------|
| Build | ✅ | ✅ | ✅ |
| Test | ✅ | ✅ | ✅ |
| Prepare Release | ❌ | ✅ | ✅ |
| Manual Approval | ❌ | ✅ | ❌ |
| Automatic Production Deployment | ❌ | ❌ | ✅ |

---

# Pipeline Anatomy

A CI/CD pipeline consists of multiple components.

## Trigger

A trigger starts the pipeline.

Example:

```yaml
on:
  push:
  pull_request:
```

Common triggers:

- push
- pull_request
- workflow_dispatch
- schedule (cron)

---

## Stage

A stage is a major phase of a pipeline.

Typical stages:

```text
Build

↓

Test

↓

Deploy
```

> **Note:** GitHub Actions doesn't have a `stages:` keyword like GitLab CI. The concept of stages still exists logically, but GitHub organizes workflows using jobs.

---

## Job

A job performs a group of related tasks.

Example:

```yaml
jobs:
  frontend:
```

Examples of jobs:

- Build Frontend
- Build Backend
- Run Tests
- Deploy

Multiple jobs can run in parallel.

---

## Step

A step is an individual action inside a job.

Example:

```yaml
steps:
  - uses: actions/checkout@v4

  - run: npm install

  - run: npm run build
```

Each command is a separate step.

---

## Runner

A Runner is the machine that executes the workflow.

### GitHub-hosted Runner

```yaml
runs-on: ubuntu-latest
```

GitHub creates a temporary virtual machine.

Workflow runs.

The VM is deleted afterward.

Benefits:

- Fresh environment
- No maintenance
- Fully managed by GitHub

---

### Self-hosted Runner

```yaml
runs-on: self-hosted
```

The workflow runs on your own machine or server.

Used when:

- Deploying applications
- Running Docker Compose
- Accessing private infrastructure
- Using custom hardware

---

# Artifact

An Artifact is the output produced by a job and saved for later use.

Examples:

- React `dist/`
- Go binary
- Test reports
- Coverage reports
- Generated documentation
- Docker image (conceptually a build output, though it's typically stored in a registry)

Example:

```yaml
- name: Upload Build

  uses: actions/upload-artifact@v4

  with:
    name: frontend-build
    path: dist/
```

Artifacts allow later jobs or users to access build outputs without rebuilding the project.

---

# Complete CI/CD Flow

```text
Developer
     │
git push
     │
     ▼
GitHub Repository
     │
     ▼
GitHub Actions Trigger
     │
     ▼
Checkout Code
     │
     ▼
Install Dependencies
     │
     ▼
Run Linter
     │
     ▼
Run Tests
     │
     ▼
Build Project
     │
     ▼
Generate Artifact
     │
     ▼
Deploy Application
```

---

# GitHub Actions Example

```yaml
name: CI

on:
  push:
    branches:
      - main

jobs:

  build:

    runs-on: ubuntu-latest

    steps:

      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: 22

      - run: npm install

      - run: npm run build
```

This workflow:

- Starts on every push to the `main` branch.
- Runs on a GitHub-hosted Ubuntu runner.
- Checks out the code.
- Installs Node.js.
- Installs dependencies.
- Builds the application.

---

# Real-World Open Source Workflows

Most large open-source projects use GitHub Actions.

Examples:

- React
- Docker CLI
- Kubernetes
- Go
- Node.js

Typical workflow:

- Trigger on push or pull request
- Checkout source code
- Set up language runtime
- Install dependencies
- Run linting
- Execute tests
- Build application
- Upload artifacts
- Report success or failure

---

# Key Takeaways

- CI automatically builds and tests code.
- Continuous Delivery prepares software for release with manual approval.
- Continuous Deployment releases software automatically.
- Pipelines consist of triggers, jobs, steps, runners, and artifacts.
- GitHub-hosted runners are temporary virtual machines.
- Self-hosted runners execute workflows on your own infrastructure.
- Artifacts store the outputs of builds and tests.
- CI/CD improves software quality, consistency, and deployment speed.

---

# Day 39 Summary

Today I learned the core concepts of CI/CD, including Continuous Integration, Continuous Delivery, and Continuous Deployment. I explored how pipelines are structured using triggers, jobs, steps, runners, and artifacts, and understood how GitHub Actions automates the software delivery process. These concepts form the foundation for building real-world CI/CD pipelines in upcoming projects.

---

# ✅ Day 39 Completed