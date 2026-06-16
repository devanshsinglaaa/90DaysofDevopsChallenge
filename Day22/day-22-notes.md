# Day 22 – Git Basics Notes

## 1. Difference between git add and git commit

- git add → moves changes to staging area
- git commit → saves changes to repository permanently

---

## 2. What is Staging Area?

Staging area is an intermediate step between working directory and repository.

It allows you to:
- control what changes go into commit
- commit selectively

---

## 3. What does git log show?

- commit history
- commit ID (hash)
- author
- date
- commit message

---

## 4. What is .git folder?

.git is the internal database of Git.

It stores:
- commits
- branches
- configurations

If deleted:
→ repository history is lost ❌

---

## 5. Working Directory vs Staging vs Repository

Working Directory:
→ where files are edited

Staging Area:
→ where changes are prepared (git add)

Repository:
→ where commits are stored (git commit)