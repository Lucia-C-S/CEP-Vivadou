# Instrucciones de uso de Git
---

### 1. Create and Clone Repositories

#### Initialize Repository

```bash
git init
```

#### Clone Repository

```bash
git clone <repository-url>
```

Example:

```bash
git clone git@github.com:user/project.git
```

#### Add Remote

```bash
git remote add origin <repository-url>
```

#### View Remotes

```bash
git remote -v
```

---

### 2. Basic Workflow

#### Check Status

```bash
git status
```

#### Add All Changes

```bash
git add .
```

#### Add Specific File

```bash
git add filename.ext
```

#### Commit Changes

```bash
git commit -m "Commit message"
```

#### Commit All Tracked Files

```bash
git commit -am "Commit message"
```

#### Push Changes

```bash
git push
```

#### Pull Latest Changes

```bash
git pull
```

#### Fetch Remote Changes

```bash
git fetch
```

---

### 3. Branch Management

#### List Local Branches

```bash
git branch
```

#### List All Branches

```bash
git branch -a
```

#### Create New Branch

```bash
git branch branch-name
```

#### Create and Switch Branch

```bash
git checkout -b branch-name
```

or (recommended)

```bash
git switch -c branch-name
```

#### Switch Branch

```bash
git checkout branch-name
```

or

```bash
git switch branch-name
```

#### Rename Current Branch

```bash
git branch -m new-branch-name
```

#### Delete Local Branch

```bash
git branch -d branch-name
```

#### Force Delete Branch

```bash
git branch -D branch-name
```

#### Push New Branch

```bash
git push -u origin branch-name
```

---

### 4. Synchronizing Branches

#### Update Current Branch

```bash
git pull origin main
```

#### Merge Branch Into Current Branch

```bash
git merge branch-name
```

#### Rebase Current Branch

```bash
git rebase main
```

#### Abort Rebase

```bash
git rebase --abort
```

#### Continue Rebase

```bash
git rebase --continue
```

---

### 5. Viewing History

#### Show Commit History

```bash
git log
```

#### Compact History

```bash
git log --oneline
```

#### Graph View

```bash
git log --oneline --graph --all
```

#### Show Specific Commit

```bash
git show <commit-hash>
```

---

### 6. Undo Changes

#### Discard Unstaged Changes

```bash
git restore .
```

#### Restore Specific File

```bash
git restore filename.ext
```

#### Unstage Files

```bash
git restore --staged .
```

#### Undo Last Commit (Keep Changes)

```bash
git reset --soft HEAD~1
```

#### Undo Last Commit (Delete Changes)

```bash
git reset --hard HEAD~1
```

#### Reset to Specific Commit

```bash
git reset --hard <commit-hash>
```

---

### 7. Stash Commands

#### Save Current Work

```bash
git stash
```

#### Save With Message

```bash
git stash push -m "work in progress"
```

#### List Stashes

```bash
git stash list
```

#### Apply Latest Stash

```bash
git stash apply
```

#### Apply and Remove Stash

```bash
git stash pop
```

#### Remove Stash

```bash
git stash drop
```

---

### 8. Remote Repository Management

#### Show Remote Information

```bash
git remote show origin
```

#### Change Remote URL

```bash
git remote set-url origin <new-url>
```

#### Remove Remote

```bash
git remote remove origin
```

---

### 9. Tags

#### Create Tag

```bash
git tag v1.0.0
```

#### List Tags

```bash
git tag
```

#### Push Tag

```bash
git push origin v1.0.0
```

#### Push All Tags

```bash
git push --tags
```

---

### 10. Useful Inspection Commands

#### Show Differences

```bash
git diff
```

#### Show Staged Differences

```bash
git diff --staged
```

#### Show Current Branch

```bash
git branch --show-current
```

#### Show Tracking Branch

```bash
git status -sb
```

---

### 11. Common Daily Workflow

```bash
# Update local repository
git pull

# Create feature branch
git switch -c feature/new-feature

# Work on files...

# Stage changes
git add .

# Commit changes
git commit -m "Add new feature"

# Push branch
git push -u origin feature/new-feature

# Switch back to main
git switch main

# Update main
git pull

# Return to feature branch
git switch feature/new-feature
```

---

### 14. Emergency Commands

#### Abort Merge

```bash
git merge --abort
```

#### Abort Rebase

```bash
git rebase --abort
```

#### View Reflog (Recovery Tool)

```bash
git reflog
```

#### Recover Lost Commit

```bash
git checkout <commit-hash>
```

or

```bash
git reset --hard <commit-hash>
```

---

### Most Important Commands

```bash
git status
git add .
git commit -m "message"
git pull
git push
git switch branch-name
git switch -c new-branch
git branch
git merge branch-name
git rebase main
git stash
git log --oneline --graph --all
```

These commands cover about 95% of day-to-day Git usage.
