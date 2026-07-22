# Day 42 - GitHub Actions: GitHub-Hosted & Self-Hosted Runners

## 🎯 Objective

Understand what **GitHub Actions runners** are, how GitHub-hosted runners work, and how to configure and use a **Self-Hosted Runner** to execute workflows on your own machine.

---

# 📚 Topics Covered

- What is a Runner?
- GitHub-Hosted Runners
- Exploring Pre-installed Software
- Self-Hosted Runner Setup
- Running Workflows on Self-Hosted Runner
- Runner Labels
- GitHub-Hosted vs Self-Hosted Comparison

---

## Live Images

![shell_script](../images/day42_01.png)

![shell_script](../images/day42_02.png)

![shell_script](../images/day42_03.png)

![shell_script](../images/day42_04.png)

![shell_script](../images/day42_05.png)

![shell_script](../images/day42_06.png)

![shell_script](../images/day42_07.png)

![shell_script](../images/day42_08.png)

![shell_script](../images/day42_09.png)

---

# What is a Runner?

A **Runner** is a machine that executes a GitHub Actions workflow.

Whenever a workflow is triggered, GitHub sends the job to a runner, which performs all the defined steps and reports the results back to GitHub.

Workflow execution flow:

```
Developer Pushes Code
          │
          ▼
 GitHub Actions Trigger
          │
          ▼
   Runner Receives Job
          │
          ▼
 Executes Workflow Steps
          │
          ▼
 Sends Logs Back to GitHub
```

Without a runner, GitHub Actions cannot execute workflows.

---

# Types of Runners

There are two types of runners:

```
                 Runner
                    │
        ┌───────────┴───────────┐
        │                       │
 GitHub-Hosted           Self-Hosted
```

---

# 1️⃣ GitHub-Hosted Runners

GitHub provides virtual machines that are automatically created whenever a workflow starts.

Example:

```yaml
name: Runner Demo

on:
  workflow_dispatch:

jobs:
  ubuntu:
    runs-on: ubuntu-latest

    steps:
      - name: Runner Information
        run: |
          echo "OS: ${{ runner.os }}"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"
```

GitHub automatically provisions:

- Ubuntu
- Windows
- macOS

depending on the value of `runs-on`.

Example:

```yaml
runs-on: ubuntu-latest
```

creates a fresh Ubuntu virtual machine.

```yaml
runs-on: windows-latest
```

creates a Windows virtual machine.

```yaml
runs-on: macos-latest
```

creates a macOS virtual machine.

These virtual machines are temporary and destroyed after the workflow completes.

---

# Multi-Platform Runner Example

```yaml
name: GitHub Hosted Runners

on:
  workflow_dispatch:

jobs:
  ubuntu-os:
    runs-on: ubuntu-latest

    steps:
      - name: Runner Information
        run: |
          echo "OS: ${{ runner.os }}"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"

  windows-os:
    runs-on: windows-latest

    steps:
      - name: Runner Information
        run: |
          Write-Host "OS: ${{ runner.os }}"
          Write-Host "Hostname: $env:COMPUTERNAME"
          Write-Host "User: $env:USERNAME"

  mac-os:
    runs-on: macos-latest

    steps:
      - name: Runner Information
        run: |
          echo "OS: ${{ runner.os }}"
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"
```

All three jobs execute in parallel.

---

# 2️⃣ Exploring Pre-installed Software

GitHub-hosted runners come with many development tools already installed.

Example workflow:

```yaml
name: Explore Runner

on:
  workflow_dispatch:

jobs:
  check-tools:
    runs-on: ubuntu-latest

    steps:
      - name: Print Installed Tools
        run: |
          docker --version
          python3 --version
          node --version
          git --version
```

Typical output:

```
Docker version xx.xx.xx

Python 3.x.x

Node vxx.x.x

git version xx.x.x
```

### Why are pre-installed tools important?

- Faster workflow execution
- No need to install common software every run
- Consistent development environment
- Reduced setup time
- Improved CI/CD performance

---

# 3️⃣ Self-Hosted Runner

A Self-Hosted Runner is your own machine that executes GitHub Actions workflows.

This machine can be:

- Local Linux PC
- Windows Machine
- macOS
- AWS EC2
- Azure VM
- VPS
- On-premise Server

Workflow execution:

```
GitHub
     │
 Internet
     │
     ▼
Self-Hosted Runner
     │
 Executes Workflow
```

Unlike GitHub-hosted runners, your machine remains online and waits for new jobs.

---

# Setting Up a Self-Hosted Runner

Navigate to:

```
Repository

↓

Settings

↓

Actions

↓

Runners

↓

New Self-Hosted Runner
```

Choose:

- Linux
- x64

GitHub generates setup commands.

Example:

```bash
mkdir actions-runner && cd actions-runner
```

```bash
curl -o actions-runner-linux-x64.tar.gz ...
```

```bash
tar xzf actions-runner-linux-x64.tar.gz
```

```bash
./config.sh --url <repository-url> --token <token>
```

```bash
./run.sh
```

Once connected, GitHub displays:

```
🟢 Idle
```

meaning the runner is connected and waiting for jobs.

---

# Running as a Service

Instead of manually starting the runner every time:

```bash
./run.sh
```

Install it as a service:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
```

Now the runner automatically starts whenever the server boots.

---

# 4️⃣ Running a Workflow on a Self-Hosted Runner

Example:

```yaml
name: Self Hosted Runner Demo

on:
  workflow_dispatch:

jobs:
  self-hosted-job:
    runs-on: self-hosted

    steps:
      - name: Runner Information
        run: |
          echo "Hostname: $(hostname)"
          echo "User: $(whoami)"
          echo "Working Directory: $(pwd)"

      - name: Create Test File
        run: |
          touch runner-test.txt

      - name: Verify File
        run: |
          ls -l
```

Unlike GitHub-hosted runners, the file:

```
runner-test.txt
```

is created on your own machine.

---

# 5️⃣ Runner Labels

Every self-hosted runner automatically receives labels.

Example:

```
self-hosted

Linux

X64
```

You can add custom labels.

Example:

```
my-linux-runner
```

Workflow:

```yaml
runs-on:
  - self-hosted
  - my-linux-runner
```

or

```yaml
runs-on: [self-hosted, my-linux-runner]
```

GitHub only assigns the job to runners that contain **all specified labels**.

---

# Why Use Labels?

Imagine three runners:

| Runner | Labels |
|---------|--------|
| Runner A | self-hosted, linux, docker |
| Runner B | self-hosted, windows |
| Runner C | self-hosted, linux, gpu |

Workflow:

```yaml
runs-on:
  - self-hosted
  - gpu
```

Only **Runner C** executes the workflow.

Labels help route workflows to the correct machine.

---

# 6️⃣ GitHub-Hosted vs Self-Hosted

| Feature | GitHub-Hosted | Self-Hosted |
|----------|---------------|-------------|
| **Who manages it?** | GitHub | You |
| **Infrastructure** | GitHub Virtual Machines | Your Server / EC2 / VPS / Local Machine |
| **Cost** | Free minutes for public repositories and limited free minutes for private repositories (additional usage depends on your plan) | You pay for your own infrastructure |
| **Pre-installed Tools** | Yes | Only what you install |
| **Maintenance** | GitHub | You |
| **Scaling** | Automatic | Manual |
| **Best For** | CI, Testing, Open Source Projects | Internal Deployments, Production Servers, Private Networks |
| **Security Responsibility** | GitHub | You |
| **Customization** | Limited | Complete Control |

---

# Practical Architecture

```
Developer
     │
     ▼
GitHub Repository
     │
     ▼
GitHub Actions
     │
     ├──────────────┐
     ▼              ▼
GitHub Runner   Self-Hosted Runner
(Build/Test)     (Deploy)
```

This architecture is commonly used in production environments.

---

# Key Takeaways

- A Runner is the machine that executes GitHub Actions workflows.
- GitHub-hosted runners are temporary virtual machines managed by GitHub.
- Self-hosted runners are machines owned and managed by the user.
- GitHub-hosted runners come with many development tools pre-installed.
- Self-hosted runners allow complete customization and access to private infrastructure.
- Runner labels help target specific self-hosted machines.
- Multiple self-hosted runners can be managed efficiently using labels.

---

# Interview Questions

### 1. What is a GitHub Actions Runner?

A Runner is a machine responsible for executing GitHub Actions workflows.

---

### 2. What is a GitHub-hosted Runner?

A temporary virtual machine managed by GitHub that automatically executes workflows and is destroyed after completion.

---

### 3. What is a Self-Hosted Runner?

A machine owned and managed by the user that executes GitHub Actions workflows.

---

### 4. Why use a Self-Hosted Runner?

- Access private networks
- Deploy applications
- Use custom software
- Use specialized hardware (GPU, ARM, etc.)
- Full control over the execution environment

---

### 5. What are Runner Labels?

Labels are identifiers assigned to self-hosted runners that help GitHub select the correct machine for executing workflows.

---

### 6. Why are pre-installed tools important?

They reduce workflow setup time, improve CI/CD performance, and provide a consistent execution environment.

---

# 📸 Screenshots

## GitHub Self-Hosted Runner (Idle)

> *(Insert screenshot showing the runner with a green **Idle** status.)*

## Workflow Running on Self-Hosted Runner

> *(Insert screenshot of a workflow executing on the self-hosted runner.)*

---

# 🚀 Summary

In Day 42, I learned how GitHub Actions workflows are executed using **Runners**. I explored GitHub-hosted runners across Ubuntu, Windows, and macOS, examined the software pre-installed on GitHub-managed virtual machines, and successfully configured a **Self-Hosted Runner** on my own server. I also learned how runner labels help target specific machines in environments with multiple runners and compared GitHub-hosted and self-hosted runners based on management, cost, customization, security, and real-world use cases.

---

**#90DaysOfDevOps #Day42 #GitHubActions #GitHubRunners #SelfHostedRunner #DevOps #CI #CD #Automation #Linux #AWS #TrainWithShubham**