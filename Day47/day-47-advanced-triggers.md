# 🚀 Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines

## 📌 Objective

Today I explored advanced GitHub Actions triggers beyond the basic `push` and `pull_request` events. I learned how to automate workflows using Pull Request lifecycle events, scheduled cron jobs, path and branch filters, workflow chaining with `workflow_run`, and external event triggers using `repository_dispatch`.

---

# 📂 Workflows Created

During Day 47, I created the following workflows:

| Workflow | File | Purpose |
|----------|------|---------|
| Pull Request Lifecycle | `.github/workflows/pr-lifecycle.yml` | Monitors different Pull Request lifecycle events. |
| PR Validation | `.github/workflows/pr-checks.yml` | Validates branch names, file sizes, and PR descriptions. |
| Scheduled Tasks | `.github/workflows/scheduled-tasks.yml` | Runs workflows using cron schedules and performs health checks. |
| Smart Triggers | `.github/workflows/smart-triggers.yml` | Executes only when changes occur in specific directories. |
| Ignore Documentation | `.github/workflows/ignore-docs.yml` | Skips workflow execution for documentation-only changes. |
| Run Tests | `.github/workflows/tests.yml` | Simulates running tests on every push. |
| Deploy After Tests | `.github/workflows/deploy-after-tests.yml` | Deploys only after the test workflow completes successfully. |
| External Trigger | `.github/workflows/external-trigger.yml` | Allows external applications to trigger GitHub Actions workflows. |

---

# 🛠 Technologies Used

- Git
- GitHub
- GitHub Actions
- YAML
- Bash
- Cron
- GitHub CLI

---

# 📚 Task 1 – Pull Request Lifecycle Events

## Goal

Create a workflow that reacts to different Pull Request lifecycle events.

### Events Covered

- opened
- synchronize
- reopened
- closed

### Workflow

**File**

```
.github/workflows/pr-lifecycle.yml
```

### Features

- Prints event name
- Prints event action
- Prints PR title
- Prints PR author
- Prints source branch
- Prints target branch
- Runs an additional step only when the PR is merged

### Events Used

| Event | Description |
|--------|-------------|
| opened | Triggered when a PR is created |
| synchronize | Triggered when new commits are pushed to an existing PR |
| reopened | Triggered when a closed PR is reopened |
| closed | Triggered when a PR is closed or merged |

---

# 📚 Task 2 – PR Validation Workflow

## Goal

Implement automated validation checks before merging Pull Requests.

**File**

```
.github/workflows/pr-checks.yml
```

### Validation Jobs

## 1. File Size Check

- Checks every file in the repository.
- Fails if any file exceeds **1 MB**.

## 2. Branch Name Validation

Allowed branch naming conventions:

```
feature/*
fix/*
docs/*
```

Regex used:

```bash
^(feature|fix|docs)/.+$
```

If the branch name doesn't match the required format, the workflow fails.

## 3. PR Description Check

Reads:

```yaml
${{ github.event.pull_request.body }}
```

If the description is empty:

- Displays a warning.
- Does **not** fail the workflow.

---

# 📚 Task 3 – Scheduled Workflows (Cron)

## Goal

Execute workflows automatically at scheduled times.

**File**

```
.github/workflows/scheduled-tasks.yml
```

### Triggers

```yaml
workflow_dispatch
```

Allows manual execution.

```yaml
schedule:
  - cron: '30 2 * * 1'
  - cron: '0 */6 * * *'
```

### Cron Expressions

| Cron | Meaning |
|------|---------|
| `30 2 * * 1` | Every Monday at **2:30 AM UTC** |
| `0 */6 * * *` | Every 6 hours |

### Workflow Features

- Manual execution using `workflow_dispatch`
- Prints the cron expression that triggered the workflow
- Performs a health check using `curl`
- Fails when the website is unavailable

### Health Check

The workflow uses:

```bash
curl -o /dev/null -s -w "%{http_code}"
```

to verify whether a website responds with HTTP Status **200**.

---

## Cron Notes

### Every weekday at 9 AM IST

GitHub uses UTC.

9:00 AM IST = 3:30 AM UTC

```
30 3 * * 1-5
```

### First day of every month at midnight UTC

```
0 0 1 * *
```

### Why can scheduled workflows be delayed?

Scheduled workflows are **best effort**.

GitHub may delay execution during periods of high load, and scheduled workflows only run on the **default branch**. Inactive repositories may also have scheduled workflows automatically disabled until new repository activity occurs.

---

# 📚 Task 4 – Path & Branch Filters

## Goal

Run workflows only when required.

---

## Smart Triggers

**File**

```
.github/workflows/smart-triggers.yml
```

### Branch Filter

```
main
release/*
```

### Path Filter

```
src/**
app/**
```

The workflow executes only when files inside these directories change.

---

## Ignore Documentation Workflow

**File**

```
.github/workflows/ignore-docs.yml
```

Ignored paths:

```
*.md
docs/**
```

If only documentation files are modified, the workflow is skipped.

---

## Paths vs Paths-Ignore

| paths | paths-ignore |
|--------|--------------|
| Allow-list | Block-list |
| Runs only for specified files | Runs for everything except specified files |
| Useful for application code | Useful for documentation or non-code files |

---

# 📚 Task 5 – Workflow Chaining using `workflow_run`

## Goal

Automatically start one workflow after another finishes.

Files

```
.github/workflows/tests.yml
.github/workflows/deploy-after-tests.yml
```

### Workflow Flow

```
Push
    │
    ▼
Run Tests
    │
    ▼
workflow_run
    │
    ▼
Deploy
```

Deployment proceeds only when:

```yaml
github.event.workflow_run.conclusion == 'success'
```

If the test workflow fails, deployment is skipped and a warning is displayed.

---

## workflow_run vs workflow_call

| workflow_run | workflow_call |
|---------------|---------------|
| Triggered after another workflow finishes | Invokes another workflow directly |
| Used for workflow chaining | Used for workflow reuse |
| Event-driven | Explicit invocation |
| Example: Test → Deploy | Example: Shared Build Workflow |

---

# 📚 Task 6 – External Event Triggers (`repository_dispatch`)

## Goal

Allow external applications to trigger GitHub Actions workflows.

**File**

```
.github/workflows/external-trigger.yml
```

### Trigger

```yaml
repository_dispatch
```

Event Type

```
deploy-request
```

### Client Payload

```yaml
${{ github.event.client_payload.environment }}
```

Example payload

```json
{
  "environment": "production"
}
```

### Trigger Command

```bash
gh api repos/<owner>/<repo>/dispatches \
  -f event_type=deploy-request \
  -f client_payload='{"environment":"production"}'
```

---

## Real-world Use Cases

External systems that commonly trigger GitHub Actions include:

- Jenkins
- Slack Bots
- Monitoring Tools
- Deployment Dashboards
- Internal Web Applications
- Automation Platforms

---

# 📸 Screenshots

> Add screenshots of:

- Pull Request lifecycle workflow
- PR validation checks
- Scheduled workflow execution
- workflow_run execution
- repository_dispatch execution (optional)

---

# 📖 Key Learnings

- Learned advanced Pull Request lifecycle events.
- Implemented automated Pull Request validation.
- Understood cron scheduling in GitHub Actions.
- Learned how path filters optimize CI/CD pipelines.
- Implemented workflow chaining using `workflow_run`.
- Learned the difference between `workflow_run` and `workflow_call`.
- Triggered workflows using external events with `repository_dispatch`.
- Understood how GitHub Actions can automate real-world DevOps workflows.

---

# ✅ Conclusion

Day 47 introduced advanced event-driven automation in GitHub Actions. By combining Pull Request events, scheduled executions, workflow chaining, path filters, and external triggers, I learned how modern CI/CD pipelines automate validation, testing, deployment, and operational tasks with minimal manual intervention.

---

## 📁 Folder Structure

```
2026/
└── day-47/
    ├── day-47-advanced-triggers.md

.github/
└── workflows/
    ├── pr-lifecycle.yml
    ├── pr-checks.yml
    ├── scheduled-tasks.yml
    ├── smart-triggers.yml
    ├── ignore-docs.yml
    ├── tests.yml
    ├── deploy-after-tests.yml
    └── external-trigger.yml
```