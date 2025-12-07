# Contributing to spec-kit-savage

## Overview

This document outlines how to contribute customizations and improvements to spec-kit-savage.

## Before You Start

1. **Review existing files**: Check `.specify/loaders/load-all-custom.sh` to see current customizations
2. **Understand non-breaking**: Customizations must not break sync with upstream spec-kit
3. **Check governance**: Review `.specify/memory/constitution.md` for repo policies
4. **Test locally**: Ensure your changes work in your environment

## Adding Customizations

### 1. Custom Templates

**Location**: `.specify/templates/`

**Requirements**:
- Markdown format (`.md` extension)
- Clear documentation of purpose
- No conflicts with spec-kit provided templates

**Example**:
```bash
cat > .specify/templates/custom-report-template.md << 'EOF'
# Custom Report Template

(Your template content)
EOF
```

**Validation**:
```bash
bash .specify/loaders/discover-templates.sh
```

### 2. Testing Policies

**Location**: `.specify/memory/testing/`

**Requirements**:
- Language-specific policies (e.g., `python.md`, `go.md`)
- Include version table for amendment tracking
- Define test runner, BDD framework, coverage requirements
- Specify Makefile targets

**Format**:
```markdown
# [Language] Testing Policy

| **Version** | **Ratified** | **Last Amended** | **Amended By** |
|-------------|--------------|------------------|----------------|
| 1.0.0       | 2025-12-07   | 2025-12-07       | Your Name      |

(Policy content)
```

**Validation**:
```bash
bash .specify/loaders/discover-policies.sh
```

### 3. Agent Prompts

**Location**: 
- `.github/prompts/` for GitHub Copilot and Roo
- `.codex/prompts/` for Codex

**Naming**: `speckit.[command].[agent].md`

**Requirements**:
- Agent-specific instructions
- Clear command purpose and usage
- Reference to supporting materials
- Output format specification

**Example**:
```markdown
# /version-update — GitHub Copilot

## Command Purpose

(Your command spec)
```

**Validation**:
```bash
bash .specify/loaders/discover-prompts.sh copilot
```

### 4. Governance Files

**Location**: `.specify/memory/`

**Requirements**:
- Version table at end of file (see version-update-guide.md)
- Amendment tracking
- Clear policy language
- Markdown linting compliant

**Update versioning**:
```bash
/version-update your-governance-file.md --verify
```

## Commit Workflow

### 1. Create Feature Branch

```bash
git checkout -b feat/add-custom-something
```

### 2. Make Changes

```bash
# Add your custom file(s)
mkdir -p .specify/templates
echo "(content)" > .specify/templates/custom.md
```

### 3. Validate

```bash
# Test loader scripts
bash .specify/loaders/load-all-custom.sh

# Check markdown linting
markdownlint .specify/templates/custom.md

# Verify no breaking changes
git diff
```

### 4. Commit

```bash
# Use conventional commits format
git add .specify/templates/custom.md
git commit -m "feat: Add custom-something template"
```

### 5. Push and Create PR

```bash
git push origin feat/add-custom-something
# Create PR on GitHub
```

## Amending Existing Customizations

### 1. Make Changes

```bash
vim .specify/templates/version-update-guide.md
```

### 2. Update Version Table

```bash
/version-update .specify/templates/version-update-guide.md --verify
```

### 3. Commit

```bash
git add .specify/templates/version-update-guide.md
git commit -m "Refs: TASK-### Amend version-update-guide for clarity"
```

## Testing Your Changes

### 1. Loader Scripts

```bash
# Verify your new file is discovered
bash .specify/loaders/load-all-custom.sh
```

### 2. Markdown Linting

```bash
# Check for linting errors
markdownlint .specify/templates/your-file.md
```

### 3. Integration

```bash
# If adding to arby repo, test in arby first
cp .specify/templates/your-file.md /path/to/arby/.specify/templates/
```

## Syncing with Upstream

Before creating a PR:

```bash
# Fetch upstream changes
git fetch upstream main

# Check for conflicts
git merge upstream/main

# If conflicts, resolve them
bash .specify/loaders/load-all-custom.sh

# Push updated branch
git push origin feat/your-branch
```

## Proposing Changes to Upstream

If your customization would benefit the official spec-kit:

1. **Create PR on github/spec-kit**
2. **Reference this repo** if the change originated here
3. **Keep change non-breaking** for compatibility
4. **Document thoroughly** for upstream maintainers

## Review Process

PRs will be reviewed for:

- **Compatibility**: Don't break sync with upstream
- **Quality**: Clear documentation and examples
- **Linting**: Markdown passes linting checks
- **Testing**: Loader scripts verify new files
- **Governance**: Alignment with constitution.md

## Questions?

See:
- [SAVAGE.md](SAVAGE.md) - Overview
- [SYNCING.md](docs/SYNCING.md) - Sync workflow
- [Loader scripts](.specify/loaders/README.md) - File discovery
- [Version update guide](.specify/templates/version-update-guide.md) - Versioning
