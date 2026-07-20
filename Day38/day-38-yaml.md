# 📅 Day 38 – YAML Basics for DevOps

## 🎯 Objective

Learn the fundamentals of YAML, understand its syntax, validate YAML files using `yamllint`, and explore how YAML is used in DevOps tools like Docker Compose, GitHub Actions, Kubernetes, and Ansible.

---

# 📌 What is YAML?

**YAML** stands for:

> **YAML Ain't Markup Language**

It is a **human-readable data serialization language** used to store configuration files.

Unlike XML or JSON, YAML is clean, simple, and easy to understand.

---

# 📌 Why YAML?

Most DevOps tools use YAML because it is:

- Easy to read
- Easy to write
- Supports nested data
- Supports lists
- Human friendly

Examples:

- Docker Compose
- GitHub Actions
- Kubernetes
- Ansible
- Helm Charts

---

# 📌 Key-Value Pairs

The basic structure of YAML is a key-value pair.

```yaml
name: Devansh Singla
role: DevOps Engineer
learning: true
experience_years: 1
```

---

# 📌 Data Types

YAML supports multiple data types.

```yaml
name: Devansh
age: 22
learning: true
salary: 50000.50
```

| Type | Example |
|------|---------|
| String | Devansh |
| Integer | 22 |
| Float | 50000.50 |
| Boolean | true / false |

---

# 📌 Lists

Lists are created using a hyphen (`-`).

```yaml
tools:
  - Git
  - Docker
  - Docker Compose
  - Linux
  - GitHub Actions
```

Inline lists are also supported.

```yaml
hobbies: [Snooker, Coding, Learning DevOps]
```

---

# 📌 Nested Objects

Nested objects help organize related information.

```yaml
server:
  name: SCG
  ip: xx.xx.xx.xx
  port: 5173

database:
  host: localhost
  name: production_db

  credentials:
    user: root
    password: root123
```

---

# 📌 Environment Variables

Many DevOps tools replace environment variables automatically.

```yaml
database:
  host: localhost
  name: ${USERNAME}

  credentials:
    user: ${USER}
    password: ${PASSWD}
```

YAML itself treats `${VARIABLE}` as a string. Docker Compose and GitHub Actions perform the substitution.

---

# 📌 Multi-line Strings

## Literal Block (`|`)

Preserves line breaks exactly.

```yaml
startup_script: |
  echo "Starting application..."
  docker compose up -d
  echo "Application Started"
```

Used for:

- Shell scripts
- Certificates
- Configuration blocks

---

## Folded Block (`>`)

Converts multiple lines into one long line.

```yaml
description: >
  This workflow builds,
  tests,
  and deploys the application.
```

Stored as:

```
This workflow builds, tests, and deploys the application.
```

Used for:

- Long descriptions
- Documentation
- Commit messages

---

# 📌 YAML Validation

Install yamllint

```bash
sudo apt update
sudo apt install yamllint -y
```

Check version

```bash
yamllint --version
```

Validate a file

```bash
yamllint person.yaml
yamllint server.yaml
```

If there are no syntax errors, yamllint produces no output.

---

# 📌 Document Start

YAML documents can begin with

```yaml
---
```

Example

```yaml
---
name: Devansh
role: DevOps Engineer
```

Without it, YAML is still valid, but `yamllint` shows a style warning.

---

# 📌 Common YAML Errors

## Wrong Indentation

❌ Incorrect

```yaml
tools:
  - Git
   - Docker
```

✅ Correct

```yaml
tools:
  - Git
  - Docker
```

---

## Using Tabs

YAML **does not allow tabs** for indentation.

Always use spaces.

---

## Incorrect List

❌ Wrong

```yaml
server:
  - name: SCG
  - ip: 192.168.1.10
```

✅ Correct

```yaml
server:
  name: SCG
  ip: 192.168.1.10
```

---

# 📌 YAML vs JSON

YAML

```yaml
name: Devansh
age: 22
skills:
  - Git
  - Docker
```

JSON

```json
{
  "name": "Devansh",
  "age": 22,
  "skills": ["Git", "Docker"]
}
```

YAML is easier for humans to read and write.

---

# 📌 Where YAML is Used

## Docker Compose

```yaml
services:
  frontend:
    image: nginx
```

---

## GitHub Actions

```yaml
steps:
  - name: Install Dependencies
    run: |
      npm install
      npm test
```

---

## Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
```

---

# 📌 Files Created

## person.yaml

```yaml
---
name: Devansh Singla
role: DevOps Engineer (Learning)
experience_years: 1
learning: true

tools:
  - Git
  - Docker
  - Docker Compose
  - Linux
  - GitHub Actions

hobbies: [Snooker, Coding, Learning DevOps]
```

---

## server.yaml

```yaml
---
server:
  name: SCG
  ip: xx.xx.xx.xx
  port: 5173

database:
  host: localhost
  name: ${USERNAME}

  credentials:
    user: ${USER}
    password: ${PASSWD}

startup_script_literal: |
  echo "Starting application..."
  docker compose up -d
  echo "Application Started"

startup_script_folded: >
  This script starts the application using Docker Compose
  and ensures all required services are running before
  accepting incoming requests.
```

---

# 💡 Key Takeaways

- YAML is indentation-sensitive.
- Use spaces, never tabs.
- `:` separates keys and values.
- `-` creates lists.
- Nested objects organize related data.
- `|` preserves new lines.
- `>` folds multiple lines into one.
- Validate YAML using `yamllint`.
- YAML is the foundation for many DevOps tools.

---

# 🚀 Day 38 Completed

Today I learned the fundamentals of YAML, including syntax, key-value pairs, lists, nested objects, multi-line strings, validation using `yamllint`, and common syntax errors. These concepts form the basis for working with Docker Compose, GitHub Actions, Kubernetes, and other DevOps tools.

**#90DaysOfDevOps #Day38 #YAML #DevOps #Docker #GitHubActions #Kubernetes #LearningInPublic**