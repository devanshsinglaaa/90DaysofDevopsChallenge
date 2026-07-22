# Day 41 - GitHub Actions: Triggers & Matrix Builds

## Note : YML files -> .github\workflows -> manual.yml, pr-check.yml, matrix.yml.

## 🎯 Objective

Learn different GitHub Actions triggers and understand how to run workflows in multiple environments using **Matrix Builds**.

---

# 📚 Topics Covered

- Pull Request Trigger
- Schedule (Cron) Trigger
- Manual Trigger (`workflow_dispatch`)
- Workflow Inputs
- Matrix Builds
- Multiple Matrix Variables
- Exclude
- Fail Fast

---
## Images :

![shell_script](../images/day41_01.png)

![shell_script](../images/day41_02.png)

---

# 1️⃣ Pull Request Trigger

A Pull Request trigger executes the workflow whenever a pull request is created, synchronized (new commits pushed), or reopened.

```yaml
name: PR Check

on:
  pull_request:
    branches:
      - master

jobs:
  pr-check:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Print PR Information
        run: |
          echo "Source Branch: ${{ github.head_ref }}"
          echo "Target Branch: ${{ github.base_ref }}"
```

### Useful Variables

| Variable | Description |
|----------|-------------|
| `github.head_ref` | Source branch of the Pull Request |
| `github.base_ref` | Target branch |
| `github.ref_name` | Current Git reference |

---

# 2️⃣ Schedule Trigger (Cron)

Run workflows automatically at a specified time.

Example:

```yaml
name: Nightly Workflow

on:
  schedule:
    - cron: "0 0 * * *"

jobs:
  scheduled-job:
    runs-on: ubuntu-latest

    steps:
      - run: echo "Running scheduled workflow..."
```

### Cron Format

```
* * * * *
│ │ │ │ │
│ │ │ │ └── Day of Week (0-7)
│ │ │ └──── Month
│ │ └────── Day of Month
│ └──────── Hour
└────────── Minute
```

Example:

```
0 0 * * *
```

Runs every day at **12:00 AM UTC**.

---

# 3️⃣ Manual Trigger

Sometimes we don't want workflows to run automatically.

Instead, we manually click **Run Workflow**.

```yaml
on:
  workflow_dispatch:
```

GitHub provides a **Run workflow** button inside the Actions tab.

---

# 4️⃣ Workflow Inputs

Manual workflows can ask users for input before execution.

Example:

```yaml
name: Manual Input Environment

on:
  workflow_dispatch:
    inputs:
      environment:
        description: Select deployment environment
        required: true
        default: staging

jobs:
  take-input:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Print Environment
        run: |
          echo "Selected Environment: ${{ inputs.environment }}"
```

### Workflow Execution

```
Click Run Workflow
        │
        ▼
GitHub shows input form
        │
        ▼
User enters value
        │
        ▼
Workflow starts
        │
        ▼
Input is available as:
${{ inputs.environment }}
```

---

# 5️⃣ Matrix Builds

Without Matrix:

```
Job 1
Job 2
Job 3
```

Lots of duplicated YAML.

With Matrix:

```yaml
strategy:
  matrix:
    go_version:
      - "1.22"
      - "1.23"
      - "1.24"
```

GitHub automatically creates three jobs.

```
Job 1 → Go 1.22

Job 2 → Go 1.23

Job 3 → Go 1.24
```

---

# Matrix Build Example

```yaml
name: Go Linter

on:
  workflow_dispatch:

jobs:
  lint:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        go_version:
          - "1.22"
          - "1.23"
          - "1.24"

    steps:
      - uses: actions/checkout@v4

      - name: Setup Go
        uses: actions/setup-go@v6
        with:
          go-version: ${{ matrix.go_version }}

      - name: Run Tests
        run: go test ./...
```

---

# Access Matrix Values

Matrix variables are accessed using:

```yaml
${{ matrix.go_version }}
```

Just like:

```
${{ github.ref_name }}

${{ inputs.environment }}

${{ matrix.go_version }}
```

---

# 6️⃣ Multiple Matrix Variables

A matrix can contain multiple dimensions.

```yaml
strategy:
  matrix:
    os:
      - ubuntu-latest
      - windows-latest

    go_version:
      - "1.22"
      - "1.23"
      - "1.24"
```

Then:

```yaml
runs-on: ${{ matrix.os }}
```

GitHub automatically generates:

| OS | Go Version |
|----|------------|
| Ubuntu | 1.22 |
| Ubuntu | 1.23 |
| Ubuntu | 1.24 |
| Windows | 1.22 |
| Windows | 1.23 |
| Windows | 1.24 |

Total Jobs = **6**

---

# 7️⃣ Exclude

Sometimes one combination should not run.

```yaml
strategy:
  matrix:
    os:
      - ubuntu-latest
      - windows-latest

    go_version:
      - "1.22"
      - "1.23"
      - "1.24"

    exclude:
      - os: windows-latest
        go_version: "1.22"
```

Skipped Job:

```
Windows + Go 1.22
```

Remaining combinations still execute.

---

# 8️⃣ Fail Fast

By default:

```yaml
fail-fast: true
```

If one matrix job fails:

```
Job 1 ✅

Job 2 ❌

Job 3 Cancelled

Job 4 Cancelled

Job 5 Cancelled
```

---

Setting:

```yaml
fail-fast: false
```

Results:

```
Job 1 ✅

Job 2 ❌

Job 3 ✅

Job 4 ✅

Job 5 ✅
```

This is useful when testing multiple operating systems or language versions because you still get results from every job.

---

# Practical Go Matrix Workflow

```yaml
name: Go Linter

on:
  workflow_dispatch:

jobs:
  code-checkout-and-build:
    runs-on: ${{ matrix.os }}

    strategy:
      fail-fast: false

      matrix:
        os:
          - ubuntu-latest
          - windows-latest

        go_version:
          - "1.22"
          - "1.23"
          - "1.24"

        exclude:
          - os: windows-latest
            go_version: "1.22"

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Go
        uses: actions/setup-go@v6
        with:
          go-version: ${{ matrix.go_version }}
          cache-dependency-path: go.sum

      - name: Run Formatter
        working-directory: backend
        run: go fmt ./...

      - name: Run Vet
        working-directory: backend
        run: go vet ./...

      - name: Run Tests
        working-directory: backend
        run: go test ./...
```

---

# 📌 Key Takeaways

- `pull_request` runs workflows on Pull Requests.
- `schedule` runs workflows automatically using cron.
- `workflow_dispatch` allows manual execution.
- `inputs` collect values before the workflow starts.
- Matrix builds eliminate duplicate jobs.
- `matrix` generates multiple job combinations automatically.
- `exclude` removes unwanted combinations.
- `fail-fast: false` allows all matrix jobs to finish even if one fails.

---

# 📝 Interview Questions

### 1. What is `workflow_dispatch`?

It allows users to manually trigger a workflow from the GitHub Actions interface.

---

### 2. What are workflow inputs?

Inputs collect user-provided values before a manually triggered workflow begins.

---

### 3. How do you access input values?

```yaml
${{ inputs.environment }}
```

---

### 4. What is a Matrix Build?

A matrix build runs the same job multiple times using different combinations of variables such as operating systems, language versions, or environments.

---

### 5. Why use Matrix Builds?

- Reduce duplicate YAML
- Test across multiple environments
- Execute jobs in parallel
- Improve CI efficiency

---

### 6. What is `exclude`?

It skips specific combinations within a matrix while executing all remaining combinations.

---

### 7. What does `fail-fast` do?

- `true` (default): Stops remaining matrix jobs if one fails.
- `false`: Allows all matrix jobs to continue even if one fails.

---

# 🚀 Summary

In Day 41, I learned how to trigger GitHub Actions workflows using Pull Requests, schedules, and manual execution. I also explored workflow inputs for collecting user data before execution and mastered Matrix Builds to test applications across multiple operating systems and Go versions. Finally, I learned how to optimize matrix workflows using `exclude` and `fail-fast`, making CI pipelines more scalable and production-ready.

---
**#90DaysOfDevOps #Day41 #GitHubActions #CI #CD #MatrixBuilds #DevOps #Automation #YAML #Go**