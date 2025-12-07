# Validation Report: spec-kit-savage

**Date**: 2025-12-07
**Status**: ✓ Complete

## Repository Setup

- [x] Fork created: https://github.com/djh00t/spec-kit
- [x] Upstream remote configured
- [x] All custom files migrated
- [x] Loader scripts implemented
- [x] Documentation added
- [x] GitHub Actions workflows configured

## Custom Files Inventory

### Templates (`.specify/templates/`)

- [x] `version-update-guide.md` — Guide for versioning governance files

### Testing Policies (`.specify/memory/testing/`)

- [x] `python.md` — Python testing standards
- [x] `rust.md` — Rust testing standards
- [x] `javascript_typescript.md` — JS/TS testing standards

**Version Table Check**:
```
All testing policies include semantic versioning table with:
- Version: 1.0.0
- Ratified: 2025-12-07
- Last Amended: 2025-12-07
- Amended By: David Hooton
```

### Agent Prompts (`.github/prompts/`)

- [x] `speckit.version.update.copilot.md` — Copilot version-update command
- [x] `speckit.version.update.roo.md` — Roo version-update command
- [x] `speckit.version.update.codex.md` — Codex version-update command

### Loader Scripts (`.specify/loaders/`)

- [x] `discover-templates.sh` — Discover custom templates
- [x] `discover-policies.sh` — Discover testing policies
- [x] `discover-prompts.sh` — Discover agent prompts
- [x] `load-all-custom.sh` — Load and validate all custom files
- [x] `README.md` — Loader documentation

## Documentation

- [x] `SAVAGE.md` — Overview and quick start guide
- [x] `docs/SYNCING.md` — Upstream sync workflow
- [x] `CONTRIBUTING.md` — Contributing guidelines

## GitHub Actions Workflows

- [x] `.github/workflows/validate-custom.yml` — Validate on push/PR
- [x] `.github/workflows/sync-upstream.yml` — Weekly sync with upstream
- [x] `.github/workflows/discover-issues.yml` — Monitor upstream issues

## Validation Results

### File Discovery

✓ **Templates**: 1 custom file discovered
✓ **Testing Policies**: 3 language-specific policies discovered
✓ **Agent Prompts**: 3 version-update prompts discovered
✓ **Loader Scripts**: 4 discovery scripts operational

### Markdown Linting

✓ All custom files pass markdown linting requirements
✓ Version tables properly formatted
✓ No syntax errors detected

### Upstream Compatibility

✓ Custom files don't overwrite spec-kit provided files
✓ Loader scripts discover both custom and spec-kit files
✓ Sync workflow can merge upstream changes safely
✓ Custom files preserved during sync operations

### Naming Convention

✓ Custom files use consistent naming:
  - Templates: `version-update-guide.md`
  - Policies: `{language}.md` (e.g., `python.md`)
  - Prompts: `speckit.{command}.{agent}.md`

## Usage Instructions

### Quick Start

```bash
# Clone spec-kit-savage
git clone https://github.com/djh00t/spec-kit.git spec-kit-savage
cd spec-kit-savage

# Discover custom files
bash .specify/loaders/load-all-custom.sh

# View quick start guide
cat SAVAGE.md
```

### Loader Scripts

```bash
# Find all templates
bash .specify/loaders/discover-templates.sh

# Find all testing policies
bash .specify/loaders/discover-policies.sh

# Find all agent prompts
bash .specify/loaders/discover-prompts.sh copilot

# Load and validate everything
bash .specify/loaders/load-all-custom.sh
```

### Sync with Upstream

```bash
# Set up upstream remote
git remote add upstream https://github.com/github/spec-kit.git
git fetch upstream main

# Merge upstream changes
git merge upstream/main

# Validate custom files still present
bash .specify/loaders/load-all-custom.sh
```

## Testing Validation

### Test Case 1: Loader Discovery

✓ All 4 loader scripts operational
✓ Each script discovers its respective files
✓ Scripts return correct exit codes (0 on success, 1 on error)
✓ No external dependencies required beyond bash

### Test Case 2: File Consistency

✓ Version tables present in all governance files
✓ Markdown syntax valid across all files
✓ All paths correctly relative to repository root
✓ No duplicate files or naming conflicts

### Test Case 3: Upstream Compatibility

✓ Custom files placed in non-conflicting locations
✓ No spec-kit files modified or overwritten
✓ Sync workflow can process upstream changes
✓ Loader scripts function after sync operations

## Next Steps

1. **Use in arby project**: Copy custom files to arby repository
2. **Monitor upstream**: GitHub Actions workflow checks weekly
3. **Contribute back**: Propose improvements to official spec-kit if beneficial
4. **Maintain customizations**: Use loader scripts to verify files remain discoverable

## Support References

- **Quick Start**: [SAVAGE.md](SAVAGE.md)
- **Syncing Guide**: [docs/SYNCING.md](docs/SYNCING.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Loader Scripts**: [.specify/loaders/README.md](.specify/loaders/README.md)
- **Version Updates**: [.specify/templates/version-update-guide.md](.specify/templates/version-update-guide.md)

---

**Conclusion**: spec-kit-savage is fully configured with all custom files discoverable, documented, and compatible with upstream spec-kit. Ready for deployment.
