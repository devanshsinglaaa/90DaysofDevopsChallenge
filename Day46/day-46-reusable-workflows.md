# 📂 Workflows & Action Created

During this day, I created the following workflows and custom action:

### 🔹 Reusable Workflow
- **File:** `.github/workflows/reusable-build.yml`
- **Purpose:** A reusable workflow that accepts inputs and secrets using the `workflow_call` trigger.

### 🔹 Caller Workflow
- **File:** `.github/workflows/call-build.yml`
- **Purpose:** Calls the reusable workflow and passes the required inputs and secrets.

### 🔹 Composite Action Demo Workflow
- **File:** `.github/workflows/composite-demo.yml`
- **Purpose:** Demonstrates how to use a custom composite action inside a workflow.

### 🔹 Custom Composite Action
- **File:** `.github/actions/setup-and-greet/action.yml`
- **Purpose:** Prints a greeting, displays the current date and runner OS, and returns an output indicating that the greeting completed successfully.

# 🚀 Day 46 – Reusable Workflows & Composite Actions

## 📌 Objective

Today I learned how to avoid repeating workflow logic by using **Reusable Workflows** and **Composite Actions** in GitHub Actions.

Reusable Workflows help reuse an entire workflow across repositories or projects, while Composite Actions help reuse a group of common steps inside a workflow.

---

# 🛠 Technologies Used

- Git
- GitHub
- GitHub Actions
- YAML

---

# 📚 Task 1 – Understanding Reusable Workflows

## What is a Reusable Workflow?

A Reusable Workflow is a GitHub Actions workflow that can be called from another workflow. Instead of writing the same CI/CD logic multiple times, one workflow can be reused across different repositories or workflows.

---

## What is `workflow_call`?

`workflow_call` is a special trigger that allows one workflow to invoke another workflow.

Example:

```yaml
on:
  workflow_call:
```

Unlike `push` or `pull_request`, a workflow using `workflow_call` does not run automatically. It only executes when another workflow calls it.

---

## Reusable Workflow vs Regular Action

| Reusable Workflow | Regular Action |
|-------------------|----------------|
| Contains one or more complete jobs | Contains one or more reusable steps |
| Uses `workflow_call` | Uses `uses:` |
| Best for complete CI/CD pipelines | Best for reusable tasks |

---

## Location

Reusable workflows must be placed inside:

```
.github/workflows/
```

---

# 📂 Task 2 – Reusable Workflow

File:

```
.github/workflows/reusable-build.yml
```

```yaml
name: Re Usable Build Workflow

on:
  workflow_call:
    inputs:
      app_name:
        description: Name of the application
        required: true
        type: string

      environment:
        description: Deployment environment
        required: true
        default: staging
        type: string

    secrets:
      docker_token:
        description: Docker Hub Token
        required: true

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print build information
        run: |
          echo "Building : ${{ inputs.app_name }}"
          echo "Environment : ${{ inputs.environment }}"

      - name: Verify Docker Token Authentication
        run: |
          if [ -n "${{ secrets.docker_token }}" ]; then
            echo "The secret docker token set : true"
          else
            echo "The secret docker token set : false"
          fi
```

---

# 📂 Task 3 – Caller Workflow

File:

```
.github/workflows/call-build.yml
```

```yaml
name: Call Build Workflow

on:
  push:
    branches:
      - main

jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml

    with:
      app_name: "my-web-app"
      environment: "production"

    secrets:
      docker_token: ${{ secrets.DOCKERHUB_TOKEN }}
```

---

# 📂 Task 4 – Workflow Outputs

The objective of this task was to generate a build version (for example, `v1.0-<short-sha>`) and return it from the reusable workflow.

While implementing this task, GitHub returned the following parser error:

```
Unrecognized named-value: 'steps'
Unexpected value '${{ steps.version.outputs.build_version }}'
```

This occurs because GitHub currently rejects the expression used for job outputs in the reusable workflow implementation attempted during the challenge.

Although the concept of reusable workflow outputs was understood, the implementation was not completed due to this parser limitation.

---

# 📂 Task 5 – Composite Action

Directory:

```
.github/actions/setup-and-greet/
```

File:

```
action.yml
```

```yaml
name: Setup and Greet

description: A composite action to greet the user and display runner information.

inputs:
  name:
    description: Name of the user
    required: true

  language:
    description: Greeting language
    required: false
    default: en

outputs:
  greeted:
    description: Greeting completed
    value: ${{ steps.greet.outputs.greeted }}

runs:
  using: composite

  steps:
    - name: Print Greeting
      id: greet
      shell: bash
      run: |
        if [ "${{ inputs.language }}" = "en" ]; then
          echo "Hello, ${{ inputs.name }}"
        elif [ "${{ inputs.language }}" = "es" ]; then
          echo "Hola, ${{ inputs.name }}"
        else
          echo "Hi, ${{ inputs.name }}"
        fi

        echo "Current Date: $(date)"
        echo "Runner OS: $RUNNER_OS"

        echo "greeted=true" >> "$GITHUB_OUTPUT"