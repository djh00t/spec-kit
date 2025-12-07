# Syncing with Upstream spec-kit

## Overview

spec-kit-savage is a fork of [github/spec-kit](https://github.com/github/spec-kit) with custom governance, testing policies, and agent prompts. This document explains how to maintain sync with upstream while preserving customizations.

## Principles

1. **Non-breaking customizations**: Custom files don't overwrite spec-kit files
2. **Easy discovery**: Loader scripts find both custom and spec-kit files
3. **Regular syncing**: Pull upstream changes without losing work
4. **Clear separation**: Custom files in distinct locations or with distinct names

## File Organization

### Spec-kit Provided (Don't Customize)

```text
.specify/templates/
  plan-template.md
  spec-template.md
  tasks-template.md
  checklist-template.md
  agent-file-template.md
  makefile.md

.specify/memory/
  constitution.md        (can amend, use version table)
```

### Spec-kit-Savage Customizations

```text
.specify/
  loaders/               (custom discovery scripts)
  templates/
    version-update-guide.md  (custom template)
  memory/
    testing/             (custom language policies)
      python.md
      rust.md
      javascript_typescript.md

.github/prompts/
  speckit.version.update.*.md (custom prompts)

.codex/prompts/
  speckit*.md            (custom prompts)
```

## Syncing Workflow

### Step 1: Set Up Upstream Remote

```bash
cd spec-kit-savage
git remote add upstream https://github.com/github/spec-kit.git
git fetch upstream main
```

### Step 2: Create Sync Branch

```bash
git checkout -b sync/upstream-main
git merge --no-ff upstream/main
```

### Step 3: Resolve Conflicts

If conflicts occur, they're likely in:
- `.specify/templates/` (safe to resolve - custom additions)
- `.github/prompts/` (safe to resolve - custom additions)
- `.codex/prompts/` (safe to resolve - custom additions)

**Strategy**:
- Keep custom files you created
- Accept upstream changes for spec-kit files
- Merge changes if both have updates

```bash
# Accept upstream version of spec-kit file
git checkout --theirs .specify/templates/spec-template.md

# Keep custom file
git checkout --ours .specify/templates/version-update-guide.md

# Mark as resolved
git add resolved-file.md
```

### Step 4: Validate Custom Files

```bash
# Ensure all custom files still discoverable
bash .specify/loaders/load-all-custom.sh

# Check for any missing loaders
ls .specify/loaders/

# Verify custom templates
ls .specify/templates/version-update-guide.md
```

### Step 5: Test and Merge

```bash
# Run tests if applicable
make test 2>/dev/null || echo "No tests configured"

# Verify markdown linting
markdownlint .specify/templates/version-update-guide.md .specify/memory/testing/*.md

# Merge to main
git checkout main
git merge sync/upstream-main
```

### Step 6: Push Updates

```bash
git push origin main
```

## Conflict Resolution Examples

### Example 1: Conflict in .specify/templates/

```bash
# Upstream added new spec-template.md version
# We have custom version-update-guide.md

# Keep both
git checkout --theirs .specify/templates/spec-template.md
git add .specify/templates/spec-template.md

# Custom file has no upstream conflict, keep ours
git add .specify/templates/version-update-guide.md
```

### Example 2: Conflict in .specify/memory/constitution.md

```bash
# Both upstream and us amended constitution.md
# This requires careful merge

# Option A: Merge manually
vim .specify/memory/constitution.md
# Review changes, combine if necessary
git add .specify/memory/constitution.md

# Option B: Use merge tool
git mergetool .specify/memory/constitution.md
```

### Example 3: No Conflicts

```bash
# Most likely scenario - custom files don't conflict
git merge upstream/main
# Auto-merge successful
```

## Automated Syncing (Optional)

### GitHub Actions Workflow

Create `.github/workflows/sync-upstream.yml`:

```yaml
name: Sync with Upstream spec-kit

on:
  schedule:
    - cron: '0 0 * * 0'  # Weekly on Sunday
  workflow_dispatch:     # Manual trigger

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Configure git
        run: |
          git config user.email "action@github.com"
          git config user.name "GitHub Action"

      - name: Add upstream remote
        run: |
          git remote add upstream https://github.com/github/spec-kit.git
          git fetch upstream main

      - name: Merge upstream
        run: |
          git merge upstream/main -m "Sync with upstream spec-kit"
        continue-on-error: true

      - name: Validate custom files
        run: |
          bash .specify/loaders/load-all-custom.sh

      - name: Create Pull Request
        uses: peter-evans/create-pull-request@v4
        with:
          commit-message: "Sync with upstream spec-kit"
          title: "Sync: upstream spec-kit updates"
          body: "Automated sync with github/spec-kit main branch"
          branch: sync/upstream-automated
```

## Maintaining Version Tables

When syncing, check if upstream updated `constitution.md`:

```bash
# Before merge, check what changed
git diff upstream/main:.specify/memory/constitution.md .specify/memory/constitution.md

# If both have updates, manually resolve:
# 1. Keep all changes from both sides
# 2. Update version table accordingly
# 3. Increment version if necessary
```

## Best Practices

1. **Sync regularly** (weekly or bi-weekly)
2. **Test after sync** - run `bash .specify/loaders/load-all-custom.sh`
3. **Review conflicts carefully** - understand what changed
4. **Document breaking changes** - if upstream has breaking changes, update docs
5. **Keep custom files separate** - don't modify spec-kit provided files
6. **Update version tables** - when amending governance files

## Troubleshooting

### Problem: Merge conflicts in many files

**Solution**: Upstream may have breaking changes. Review carefully:

```bash
# See what changed upstream
git log upstream/main --oneline -n 20

# Abort merge if too complex
git merge --abort

# Create issue to plan careful merge
```

### Problem: Custom files disappeared after merge

**Solution**: Verify they're still discoverable:

```bash
bash .specify/loaders/load-all-custom.sh
```

If missing, restore from Git:

```bash
git log --follow -p .specify/templates/version-update-guide.md
git checkout <commit-hash> -- .specify/templates/version-update-guide.md
```

### Problem: Loader scripts not working

**Solution**: Ensure scripts are executable:

```bash
chmod +x .specify/loaders/*.sh
bash .specify/loaders/load-all-custom.sh
```

## Reference

- [spec-kit upstream](https://github.com/github/spec-kit)
- [Loader scripts](docs/LOADERS.md)
- [Version update guide](.specify/templates/version-update-guide.md)
