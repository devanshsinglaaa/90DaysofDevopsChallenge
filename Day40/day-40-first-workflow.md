# Day 40 – My First GitHub Actions Workflow

## Note : hello.yml is added in .github\workflows , kindly checkout from there....

## 📌 Objective

Today I created and executed my first GitHub Actions workflow. This was my first experience running automation in GitHub's cloud instead of my local machine. I learned how workflows are triggered, how jobs and steps work, and how GitHub-hosted runners execute my code.

---

# What is GitHub Actions?

GitHub Actions is GitHub's CI/CD platform that allows developers to automate software workflows directly from a GitHub repository.

Using workflows, GitHub can automatically:

- Build applications
- Run tests
- Perform code quality checks
- Build Docker images
- Deploy applications
- Execute custom scripts

Every workflow is defined using a YAML (`.yml`) file inside:

```text
.github/workflows/
```

---

# Repository Structure

```text
github-actions-practice/
│
├── .github/
│   └── workflows/
│       └── hello.yml
│
├── README.md
│
└── day-40-first-workflow.md
```

---

# My First Workflow

**File:** `.github/workflows/hello.yml`

```yaml
name: Hello World Github Workflow

on:
  push:
  workflow_dispatch:

jobs:

  greet:
    name: Hello World

    runs-on: ubuntu-latest

    steps:

      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Print Greeting Message
        run: echo "Hello World! This is my first GitHub Actions workflow!"

  print-env-info:
    name: Environment Information

    runs-on: ubuntu-latest

    steps:

      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Current Date & Time
        run: date

      - name: Print Current Branch
        run: echo "Current Branch: ${{ github.ref_name }}"

      - name: List Repository Files
        run: ls -la

      - name: Print Runner Operating System
        run: echo "Runner OS: ${{ runner.os }}"

      - name: Print Repository Name
        run: echo "Repository: ${{ github.repository }}"

      - name: Print Triggered By
        run: echo "Triggered By: ${{ github.actor }}"
```

---

# Workflow Execution

Every time I:

- Push code
- Or manually trigger the workflow

GitHub automatically creates an Ubuntu runner and executes every job.

Workflow execution:

```text
Git Push
    │
    ▼
GitHub Repository
    │
    ▼
Workflow Triggered
    │
    ▼
GitHub Runner Created
    │
    ├───────────────┐
    ▼               ▼
Greeting Job   Environment Job
    │               │
    ▼               ▼
Workflow Completed
```

---

# Understanding Every Keyword

## `name`

```yaml
name: Hello World Github Workflow
```

The workflow name displayed inside the GitHub Actions tab.

---

## `on`

```yaml
on:
  push:
  workflow_dispatch:
```

Defines when the workflow should run.

### push

Runs automatically whenever code is pushed.

### workflow_dispatch

Allows manual execution from the GitHub Actions tab.

---

## `jobs`

```yaml
jobs:
```

A workflow contains one or more jobs.

Each job runs independently on its own runner.

---

## Job ID

```yaml
greet:
```

Unique identifier of the job.

GitHub uses this internally.

---

## Job Name

```yaml
name: Hello World
```

Human-readable name shown in the GitHub Actions interface.

---

## `runs-on`

```yaml
runs-on: ubuntu-latest
```

Specifies the runner used to execute the job.

GitHub creates a temporary Ubuntu virtual machine for this workflow.

---

## `steps`

```yaml
steps:
```

A job is divided into multiple steps.

Steps execute sequentially inside the same job.

---

## `uses`

```yaml
uses: actions/checkout@v4
```

Downloads the repository onto the runner.

Without this step, the workflow cannot access project files.

---

## `run`

```yaml
run: echo "Hello World"
```

Executes shell commands on the runner.

Examples:

- echo
- ls
- date
- npm install
- go test
- docker build

---

## Step Name

```yaml
- name: Print Greeting Message
```

Provides a descriptive label for each step in the GitHub Actions UI.

---

# GitHub Context Variables Used

## Current Branch

```yaml
${{ github.ref_name }}
```

Example Output:

```text
Current Branch: master
```

---

## Runner Operating System

```yaml
${{ runner.os }}
```

Example Output:

```text
Runner OS: Linux
```

---

## Repository Name

```yaml
${{ github.repository }}
```

Example Output:

```text
Repository: DevanshSingla/github-actions-practice
```

---

## Triggered By

```yaml
${{ github.actor }}
```

Example Output:

```text
Triggered By: DevanshSingla
```

---

# Jobs and Parallel Execution

My workflow contains two jobs:

- Greeting Job
- Environment Information Job

Since no dependency is defined, GitHub executes them in parallel.

```text
Workflow Started
        │
 ┌──────┴────────┐
 ▼               ▼
Greeting Job   Environment Job
        │
        ▼
 Workflow Completed
```

If I want one job to wait for another, I can use:

```yaml
needs: greet
```

---

# GitHub-Hosted Runner

I used:

```yaml
runs-on: ubuntu-latest
```

GitHub automatically:

- Creates a temporary virtual machine
- Downloads my repository
- Executes the workflow
- Deletes the runner after completion

Benefits:

- Clean environment
- No setup required
- Fully managed by GitHub

---

# Workflow Output

The workflow printed:

- Greeting message
- Current date & time
- Branch name
- Repository files
- Runner operating system
- Repository name
- GitHub username

---

# Breaking the Workflow

To understand failures, I intentionally added:

```yaml
- name: Intentional Failure
  run: exit 1
```

Result:

- Workflow status became **Failed** (red ❌).
- GitHub stopped executing the remaining steps in that job.
- The logs clearly showed which step failed and the associated error message.

After removing the failing command and pushing again, the workflow completed successfully with a green ✔️ status.

---

# Screenshot

> 📷 **Add your screenshot of the successful GitHub Actions workflow here.**

Example:

```text
images/day-40-green-workflow.png
```

---

# Key Learnings

- GitHub Actions automates software workflows.
- Workflow files are stored inside `.github/workflows/`.
- `on:` defines workflow triggers.
- `jobs:` defines independent units of work.
- `steps:` define individual actions within a job.
- `uses:` runs reusable GitHub Actions.
- `run:` executes shell commands.
- Each job runs on its own runner.
- GitHub-hosted runners are temporary virtual machines.
- Jobs run in parallel by default.
- `needs` creates dependencies between jobs.
- GitHub provides built-in context variables like `github.ref_name`, `github.actor`, and `runner.os`.

---

# Day 40 Summary

Today I created my first GitHub Actions workflow and successfully executed it on GitHub's cloud infrastructure. I learned how workflows are triggered, how jobs and steps are organized, how GitHub-hosted runners execute workflows, and how to use built-in GitHub variables to access runtime information. I also explored workflow failures by intentionally breaking the pipeline and understanding how GitHub reports errors. This hands-on experience gave me a solid foundation for building real CI/CD pipelines in the coming days.

---

# ✅ Day 40 Completed
```