# Day 26 – GitHub CLI (Real DevOps Workflow from Terminal)

## 🚀 What I Did Today

Today was a shift from using GitHub in the browser to controlling everything directly from the terminal using the GitHub CLI (`gh`).

I:

* Installed and authenticated GitHub CLI
* Created a repository without opening GitHub
* Made commits and pushed changes
* Created and managed issues
* Created, reviewed, and merged a pull request — all from terminal

This felt less like “learning commands” and more like **actually working like a developer in a team environment**.

---

## 🧠 Key Concepts I Understood

### 🔹 What is an Issue?

An issue is basically a **tracked task, bug, or feature request**.

Instead of remembering problems in your head, you log them as issues.

👉 Realization:

> Issues are the starting point of real development workflows.

---

### 🔹 What is a Pull Request (PR)?

A PR is a way of saying:

> “I’ve made changes — please review and merge them.”

It connects:

* Code changes
* Team collaboration
* Review process

👉 Realization:

> PRs are not just about merging code, they are about communication.

---

### 🔹 Full DevOps Flow (What I Practiced)

I executed this complete cycle:

Issue → Create Branch → Make Changes → Create PR → Review → Merge

👉 This is exactly how real teams work.

---

## 💻 Commands I Used (Important Ones)

* Authentication:

  ```bash
  gh auth login
  gh auth status
  ```

* Repository:

  ```bash
  gh repo create
  gh repo view
  ```

* Issues:

  ```bash
  gh issue create
  gh issue list
  gh issue view
  ```

* Pull Requests:

  ```bash
  gh pr create --fill
  gh pr list
  gh pr view
  gh pr diff
  gh pr merge
  ```

---

## 🔥 Key Learnings (Most Important Part)

### ⚡ 1. Terminal > Browser

I realized switching to browser breaks flow.
Using `gh` keeps everything fast and uninterrupted.

---

### 🔁 2. Real Workflow Matters More Than Commands

Commands are easy.
Understanding the **flow (Issue → PR → Merge)** is what actually matters.

---

### 🤖 3. Automation Potential

Since everything works via CLI:

* It can be scripted
* It can be automated
* It can be integrated into CI/CD

---

### 🧩 4. DevOps is About Efficiency

Today showed me:

> DevOps is not just tools — it’s about reducing friction in development.

---

### 🧹 5. Clean Git Practices

Using:

* Branches
* PRs
* Squash merge

Made the workflow structured and clean.

---

## ⚠️ Challenges I Faced

* Authentication initially failed due to wrong command
* Browser didn’t open automatically in WSL
* Device code expired once

👉 Fix:

* Manually opened GitHub device login page
* Re-ran authentication quickly

---

## 💡 Final Takeaway

Before today:

> I was using GitHub.

After today:

> I can control GitHub.

And that’s a big difference.

---

## 🚀 What’s Next

* Explore GitHub Actions deeply
* Automate PR checks
* Use `gh` inside scripts

---

## 🏁 Conclusion

Today was one of the most practical days so far.

This wasn’t just learning —
it felt like stepping into a real developer/DevOps workflow.
