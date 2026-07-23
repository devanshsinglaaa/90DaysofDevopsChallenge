# Day 43 - GitHub Actions: Jobs, Steps, Environment Variables & Conditionals

## Note : All workflows are added in .github/workflows.
## (conditionals.yml, jobs-output.yml, multi-job.yml, smart-piprline.yml, variables.yml)

## Workflow Images :



## 🎯 Objective

Learn how to control the execution flow of GitHub Actions workflows using multiple jobs, job dependencies, environment variables, job outputs, and conditional execution.

---

# 📚 Topics Covered

- Multi-Job Workflows
- Job Dependencies (`needs`)
- Environment Variables (`env`)
- GitHub Context Variables
- Job Outputs
- Conditional Execution (`if`)
- `failure()`
- `continue-on-error`
- Smart Pipeline

---

# 1️⃣ Multi-Job Workflows

A workflow can contain multiple jobs.

By default, all jobs run **in parallel** unless dependencies are defined.

Example:

```yaml
name: Multiple Depending Jobs Running Workflow

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Build
        run: echo "Building the application"

  test:
    needs: build
    runs-on: ubuntu-latest

    steps:
      - name: Test
        run: echo "Running tests"

  deploy:
    needs: test
    runs-on: ubuntu-latest

    steps:
      - name: Deploy
        run: echo "Deploying application"
```

Workflow Graph

```
Build
   │
   ▼
Test
   │
   ▼
Deploy
```

### What is `needs`?

The `needs` keyword creates dependencies between jobs.

Without `needs`:

```
Build
Test
Deploy
```

All three jobs run simultaneously.

With `needs`:

```
Build
   │
   ▼
Test
   │
   ▼
Deploy
```

Each job waits until the previous one completes successfully.

---

# 2️⃣ Environment Variables

GitHub Actions supports environment variables at three different levels.

## Workflow Level

Available to every job and every step.

```yaml
env:
  APP_NAME: myapp
```

---

## Job Level

Available only inside that job.

```yaml
jobs:
  build:
    env:
      ENVIRONMENT: staging
```

---

## Step Level

Available only inside that specific step.

```yaml
steps:
  - name: Print Variables
    env:
      VERSION: 1.0.0
```

---

## Complete Example

```yaml
name: Variables Env Scope

on:
  workflow_dispatch:

env:
  APP_NAME: myapp

jobs:
  build:
    runs-on: ubuntu-latest

    env:
      ENVIRONMENT: staging

    steps:
      - name: Print Variables
        env:
          VERSION: 1.0.0

        run: |
          echo "App Name: $APP_NAME"
          echo "Environment: $ENVIRONMENT"
          echo "Version: $VERSION"

          echo "Commit SHA: ${{ github.sha }}"
          echo "Triggered By: ${{ github.actor }}"
```

### Variable Scope

```
Workflow
│
├── APP_NAME
│
└── Job
      │
      ├── ENVIRONMENT
      │
      └── Step
             │
             ├── VERSION
             │
             └── Can access:
                 ✔ APP_NAME
                 ✔ ENVIRONMENT
                 ✔ VERSION
```

---

# GitHub Context Variables

GitHub automatically provides useful information through contexts.

Examples:

| Context | Description |
|----------|-------------|
| `${{ github.actor }}` | User who triggered the workflow |
| `${{ github.sha }}` | Commit SHA |
| `${{ github.ref }}` | Branch reference |
| `${{ github.event_name }}` | Trigger event |

---

# 3️⃣ Job Outputs

Each job runs on a different runner.

Therefore, environment variables **cannot be shared** between jobs.

To pass values from one job to another, GitHub provides **Job Outputs**.

Example:

```yaml
name: Job Outputs

on:
  workflow_dispatch:

jobs:

  get_date:
    runs-on: ubuntu-latest

    outputs:
      current_date: ${{ steps.today.outputs.date }}

    steps:
      - name: Generate Current Date
        id: today
        run: |
          echo "date=$(date)" >> $GITHUB_OUTPUT

  print_date:
    needs: get_date
    runs-on: ubuntu-latest

    steps:
      - name: Print Date
        run: |
          echo "Current Date: ${{ needs.get_date.outputs.current_date }}"
```

### Flow

```
Step

↓

$GITHUB_OUTPUT

↓

Step Output (date)

↓

Job Output (current_date)

↓

needs.get_date.outputs.current_date

↓

Next Job
```

### Why use Job Outputs?

They are commonly used to pass:

- Docker image tags
- Build numbers
- Version numbers
- Artifact names
- Release IDs
- Generated dates

between jobs without recalculating them.

---

# 4️⃣ Conditionals

The `if` keyword controls whether a step or job should execute.

---

## Run only on Main Branch

```yaml
- name: Deploy
  if: github.ref == 'refs/heads/main'

  run: echo "Deploying to Production"
```

---

## Run only if Previous Step Failed

```yaml
- name: Simulate Failure
  run: exit 1

- name: Execute on Failure
  if: failure()

  run: echo "Previous step failed."
```

---

## Run Job only on Push

```yaml
deploy:
  if: github.event_name == 'push'
```

The job is skipped for pull requests or manual executions.

---

## Continue on Error

Normally, a failed step stops the workflow.

```yaml
- name: Ignore Failure
  continue-on-error: true

  run: exit 1

- name: Continue Workflow
  run: echo "Workflow continues."
```

The failed step is marked as failed, but the workflow continues executing the remaining steps.

---

# 5️⃣ Smart Pipeline

Final practical combining everything learned.

```yaml
name: Smart Pipeline

on:
  push:
  workflow_dispatch:

jobs:

  lint:
    runs-on: ubuntu-latest

    steps:
      - name: Code Checkout
        run: echo "Performing Code Checkout"

      - name: Lint Code
        run: echo "Linting Code"

  test:
    runs-on: ubuntu-latest

    steps:
      - name: Run Tests
        run: echo "Running all the tests"

  summary:
    runs-on: ubuntu-latest

    needs:
      - lint
      - test

    steps:
      - name: Print Branch
        run: |
          echo "GitHub Branch: ${{ github.ref }}"

      - name: Main Branch
        if: github.ref == 'refs/heads/main'
        run: echo "Main Branch Push"

      - name: Feature Branch
        if: github.ref != 'refs/heads/main'
        run: echo "Feature Branch Push"

      - name: Commit Message
        if: github.event_name == 'push'
        run: |
          echo "Commit Message: ${{ github.event.commits[0].message }}"
```

Workflow Graph

```
              Push
                │
        ┌───────┴────────┐
        │                │
        ▼                ▼
      Lint             Test
        │                │
        └───────┬────────┘
                ▼
             Summary
```

---

# Key Takeaways

- Jobs run in parallel unless dependencies are created using `needs`.
- `needs` ensures jobs execute in the correct order.
- Environment variables can be defined at workflow, job, and step levels.
- GitHub Context variables provide information about the workflow, repository, branch, actor, and commit.
- Job Outputs allow one job to pass data to another.
- `if` controls whether a step or job executes.
- `failure()` executes steps only after previous failures.
- `continue-on-error` allows workflows to continue even when a step fails.
- Combining these features helps build efficient and maintainable CI/CD pipelines.

---

# Interview Questions

### 1. What is the purpose of `needs`?

`needs` creates dependencies between jobs so they execute in a specific order.

---

### 2. What happens if `needs` is not used?

All jobs execute in parallel.

---

### 3. What is the difference between Workflow, Job, and Step level environment variables?

- Workflow level → Available to every job and step.
- Job level → Available only within that job.
- Step level → Available only inside that specific step.

---

### 4. Why are Job Outputs used?

Job Outputs allow one job to pass information such as version numbers, Docker image tags, or build artifacts to another job.

---

### 5. What does `failure()` do?

It executes a step only if a previous step in the same job has failed.

---

### 6. What does `continue-on-error: true` do?

It allows the workflow to continue executing even if that step fails.

---

### 7. What is the difference between `${{ github.sha }}` and `$GITHUB_SHA`?

- `${{ github.sha }}` is a GitHub Actions expression evaluated by the workflow engine.
- `$GITHUB_SHA` is an environment variable available inside the runner's shell.

Both represent the commit SHA but are used in different contexts.

---

# 🚀 Summary

On Day 43, I learned how to build more intelligent GitHub Actions workflows by using multiple jobs, creating dependencies with `needs`, managing environment variables at different scopes, passing values between jobs using outputs, and controlling execution with conditional statements. I also built a smart pipeline that executes jobs in parallel, waits for dependencies, identifies the target branch, and prints the latest commit message.

---

**#90DaysOfDevOps #Day43 #GitHubActions #DevOps #CI #CD #Automation #GitHub #TrainWithShubham**