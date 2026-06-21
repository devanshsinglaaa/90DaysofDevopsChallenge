# Day 28 – Revision Day (Day 1 to Day 27)

## 🚀 What I Did Today

Today was a revision day, and honestly it was one of the most important days so far.

Instead of learning something new, I:

* Reviewed all topics from Day 1 to Day 27
* Checked my understanding using a self-assessment
* Identified weak areas
* Revisited a few important concepts
* Tried to explain concepts in simple terms

This day made me realize how much I’ve actually learned — and where I still need improvement.

---

## 🧠 Self-Assessment Summary

### ✅ Comfortable With

* Basic Linux commands and file operations
* Git workflow (init, commit, push, branch, merge)
* GitHub usage and GitHub CLI
* Writing basic shell scripts
* Running Docker containers
* Understanding DevOps fundamentals

---

### ⚠️ Need More Practice

* LVM (volume management concepts)
* Networking (subnets, deeper DNS understanding)
* Advanced shell scripting (error handling, traps)
* Git advanced concepts (rebase, cherry-pick clarity)

---

### ❌ Not Fully Confident Yet

* Explaining networking deeply
* Writing complex shell scripts from scratch
* Handling edge cases in Git workflows

---

## 🔁 Topics I Revisited

### 🔹 1. Git Reset vs Revert

* `git reset` → changes history (dangerous if misused)
* `git revert` → creates new commit to undo changes

👉 Re-learned:

> Always prefer `revert` in shared repositories

---

### 🔹 2. File Permissions (chmod)

* `chmod 755 file`

  * Owner → read, write, execute
  * Group → read, execute
  * Others → read, execute

👉 Re-learned:

> Permissions control who can access and modify files

---

### 🔹 3. Crontab Scheduling

```bash
0 3 * * * /path/to/script.sh
```

👉 Means:

* Runs every day at 3 AM

---

## ⚡ Quick-Fire Answers

1. `chmod 755 script.sh`
   → Owner full access, others read + execute

2. Process vs Service
   → Process = running program
   → Service = background system process

3. Process using port 8080

   ```bash
   lsof -i :8080
   ```

4. `set -euo pipefail`
   → Stops script on errors, undefined variables, pipe failures

5. `git reset --hard` vs `git revert`
   → Reset deletes history
   → Revert safely undoes

6. Branching strategy
   → GitHub Flow (simple and practical)

7. `git stash`
   → Temporarily saves uncommitted changes

8. Run script daily at 3 AM

   ```bash
   0 3 * * *
   ```

9. `git fetch` vs `git pull`
   → Fetch = download changes
   → Pull = fetch + merge

10. LVM
    → Flexible disk management (resize, extend volumes)

---

## 🧩 Teach It Back (Explaining Simply)

### 🔹 What is Git Branching?

Git branching is like creating a copy of your work to try something new without affecting the original code.

You can:

* Work on features separately
* Test changes safely
* Merge when ready

👉 It helps teams work on multiple things at the same time without conflicts.

---

## 🧹 Work Organization

* Ensured all previous days are pushed to GitHub
* Verified repositories are structured properly
* Checked GitHub profile improvements from Day 27

---

## 💡 Key Realizations

### ⚡ 1. I’ve learned a lot more than I thought

27 days covered a huge amount of content

---

### 🔁 2. Revision is necessary

Without revision, concepts fade quickly

---

### 🎯 3. Weak areas are normal

Not knowing everything is part of the process

---

### 🧠 4. Teaching exposes gaps

Explaining something shows if I really understand it

---

## 🏁 Final Takeaway

Before today:

> I was just moving forward

After today:

> I paused, reflected, and strengthened my foundation

---

## 🚀 What’s Next

* Focus on weak areas while continuing the journey
* Practice more hands-on
* Keep building consistency

---

## 🧾 Conclusion

Day 28 reminded me:

> Learning is not just about moving forward —
> it’s about looking back and improving.
