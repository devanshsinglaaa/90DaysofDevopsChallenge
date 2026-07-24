# 🚀 Day 44 – GitHub Actions: Secrets, Artifacts & Testing

##  Note : All workflows are added in .github/workflows.

## Images:

![shell_script](../images/day44_01.png)

![shell_script](../images/day44_02.png)

![shell_script](../images/day44_03.png)

![shell_script](../images/day44_04.png)

![shell_script](../images/day44_05.png)

![shell_script](../images/day44_06.png)

![shell_script](../images/day44_07.png)

![shell_script](../images/day44_08.png)


## 📌 Objective

On Day 44, I explored some of the most important GitHub Actions features used in real-world CI/CD pipelines. This included securely handling sensitive information, storing workflow-generated files, sharing data between jobs, and running automated tests.

---

# 🔐 GitHub Secrets

## What are GitHub Secrets?

GitHub Secrets are encrypted values used to securely store sensitive information required by workflows.

Examples include:

- Docker Hub Access Token
- AWS Access Keys
- API Keys
- Database Passwords
- SSH Keys

Instead of hardcoding credentials inside workflow files, GitHub injects these values securely during workflow execution.

---

## Creating a Secret

Navigate to:

```
Repository
    ↓
Settings
    ↓
Secrets and Variables
    ↓
Actions
    ↓
New Repository Secret
```

Example Secret:

```
DOCKERHUB_TOKEN
```

Access inside a workflow:

```yaml
${{ secrets.DOCKERHUB_TOKEN }}
```

---

# 📦 Repository Variables

Repository Variables are similar to Secrets but are **not encrypted**.

They are intended for non-sensitive configuration values.

Examples:

- Docker Username
- Environment Name
- Region
- Project Name

Access syntax:

```yaml
${{ vars.DOCKERHUB_USERNAME }}
```

---

# 🌍 Environment Variables (`env`)

GitHub expressions are evaluated before a step runs.

To use Secrets or Variables inside shell commands, they should be mapped using the `env` block.

Example:

```yaml
env:
  DOCKERHUB_USERNAME: ${{ vars.DOCKERHUB_USERNAME }}
  DOCKERHUB_TOKEN: ${{ secrets.DOCKERHUB_TOKEN }}
```

They can then be accessed inside shell scripts as:

```bash
$DOCKERHUB_USERNAME
$DOCKERHUB_TOKEN
```

---

# 🐳 Docker Login Example

```yaml
name: Docker Login Workflow

on:
  workflow_dispatch:

jobs:
  docker-login:
    runs-on: ubuntu-latest

    steps:
      - name: Docker Login
        uses: docker/login-action@v4
        with:
          username: ${{ vars.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Verify Credentials
        env:
          DOCKERHUB_USERNAME: ${{ vars.DOCKERHUB_USERNAME }}
          DOCKERHUB_TOKEN: ${{ secrets.DOCKERHUB_TOKEN }}

        run: |
          echo "Logging in as: $DOCKERHUB_USERNAME"

          if [ -n "$DOCKERHUB_TOKEN" ]; then
            echo "Docker token is available: true"
          fi
```

---

# 🔒 Secret Masking

If a workflow accidentally prints a Secret,

```yaml
echo "${{ secrets.DOCKERHUB_TOKEN }}"
```

GitHub automatically masks the value in the workflow logs.

Example:

```
***
```

This prevents accidental exposure of sensitive credentials.

---

# 📁 GitHub Artifacts

## What are Artifacts?

Artifacts are files generated during a workflow that GitHub stores after the workflow completes.

Examples include:

- Build outputs
- Test reports
- Coverage reports
- Log files
- APK/JAR files
- Compiled binaries

---

# Uploading an Artifact

```yaml
name: Upload Artifact

on:
  workflow_dispatch:

jobs:
  artifact:
    runs-on: ubuntu-latest

    steps:
      - name: Create Report
        run: |
          touch report.txt
          echo "GitHub Actions Day 44, Artifact Upload Demo" >> report.txt

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: report
          path: report.txt
```

---

## Artifact Workflow

```
Workflow Starts
      │
      ▼
Create report.txt
      │
      ▼
Upload Artifact
      │
      ▼
GitHub Artifact Storage
      │
      ▼
Available for Download
```

---

# 📥 Downloading Artifacts

Artifacts can also be shared between different jobs.

Since every GitHub Actions job runs on a **new runner**, files generated in one job are unavailable in another unless uploaded as artifacts.

Example:

```yaml
name: Upload & Download Artifact

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Create File
        run: |
          touch a.txt
          echo "This is job A's artifact file" >> a.txt

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: a-file
          path: a.txt

  verify:
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Download Artifact
        uses: actions/download-artifact@v5
        with:
          name: a-file

      - name: Display File
        run: |
          echo "Contents of a.txt:"
          cat a.txt
```

---

## Artifact Sharing Flow

```
Runner A
──────────────
Create a.txt
      │
Upload Artifact
      │
      ▼
GitHub Artifact Storage
      │
      ▼
Runner B
──────────────
Download Artifact
      │
Read a.txt
```

---

# 🧪 Running Automated Tests

One of the primary responsibilities of Continuous Integration is automatically validating code after every change.

For Go projects, tests are typically executed using:

```bash
go test ./...
```

The `./...` pattern recursively runs tests for every package inside the module.

---

## Go Testing Workflow

```yaml
name: Set up GO and Run Tests

on:
  workflow_dispatch:

jobs:
  code-checkout-setup-test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Set up Go
        uses: actions/setup-go@v5
        with:
          go-version: "1.24"

      - name: Display Go Version
        run: go version

      - name: Download Dependencies
        run: go mod download

      - name: Run Go Tests
        run: go test ./...
```

> **Note:** My current **90DaysOfDevOpsChallenge** repository contains only Markdown files and is **not** a Go project. Therefore, this workflow is a learning example. In a real Go project, a `go.mod` file and Go source files are required for the test step to execute successfully.

---

# 📚 Key Learnings

- Learned how GitHub securely stores sensitive information using **Secrets**.
- Understood the difference between **Repository Variables** and **Secrets**.
- Used **Environment Variables (`env`)** to expose Secrets inside shell scripts.
- Learned how GitHub automatically masks Secrets in workflow logs.
- Uploaded workflow-generated files using **Artifacts**.
- Downloaded Artifacts to share files between independent jobs.
- Understood that every GitHub Actions job runs on a fresh, isolated runner.
- Learned how Continuous Integration automatically validates applications by executing test suites.
- Built production-style GitHub Actions workflows using official GitHub Actions.

---

# 🎯 Conclusion

Day 44 focused on building secure, reliable, and production-ready GitHub Actions workflows. I learned how to protect sensitive credentials using GitHub Secrets, manage configuration with Repository Variables, securely expose values using environment variables, preserve generated files through Artifacts, share data across isolated jobs, and integrate automated testing into CI pipelines. These concepts form the foundation of modern Continuous Integration and Continuous Deployment (CI/CD) workflows used across professional software development.