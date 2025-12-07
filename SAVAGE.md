# spec-kit-savage: Custom Specifications Toolkit

A highly opinionated fork of the official [spec-kit](https://github.com/github/spec-kit) with customizations for advanced governance, testing standards, and automated workflows.

## Overview

spec-kit-savage extends spec-kit with:

- **Version-tracked governance files** with semantic versioning and amendment tracking
- **Language-specific testing policies** (Python, Rust, JavaScript/TypeScript)
- **Custom agent prompts** for Copilot, Codex, and Roo with spec-kit workflows
- **Loader scripts** for automatic discovery of custom files
- **Sync compatibility** with upstream spec-kit (non-breaking customizations)

## Quick Start

### 1. Discover Custom Files

```bash
bash .specify/loaders/load-all-custom.sh
```

This lists all custom templates, testing policies, and agent prompts.

### 2. Explore Custom Content

**Version Update Guide** (template for versioning governance files):
```bash
cat .specify/templates/version-update-guide.md
```

**Testing Policies** (language-specific standards):
```bash
cat .specify/memory/testing/python.md
cat .specify/memory/testing/rust.md
cat .specify/memory/testing/javascript_typescript.md
```

**Agent Prompts** (slash commands for AI agents):
```bash
ls .github/prompts/speckit*.md
ls .codex/prompts/speckit*.md
```

### 3. Use in Your Repository

Clone spec-kit-savage as your spec-kit source:

```bash
git clone https://github.com/djh00t/spec-kit.git spec-kit-savage
cd spec-kit-savage

# List all customizations
bash .specify/loaders/load-all-custom.sh

# Copy to your project
cp -r .specify/templates/ your-project/
cp -r .specify/memory/ your-project/
cp -r .github/prompts/ your-project/
cp -r .codex/prompts/ your-project/
```

## File Structure

### Custom Files

```text
.specify/
  loaders/
    discover-templates.sh    # Find custom templates
    discover-policies.sh     # Find testing policies
    discover-prompts.sh      # Find agent prompts
    load-all-custom.sh       # Load all custom files
    README.md                # Loader documentation
  templates/
    version-update-guide.md  # Guide for versioning governance files
  memory/
    testing/
      python.md              # Python testing policy
      rust.md                # Rust testing policy
      javascript_typescript.md # JS/TS testing policy

.github/prompts/
  speckit.version.update.copilot.md
  speckit.version.update.roo.md
  speckit.version.update.codex.md

.codex/prompts/
  speckit*.md                # Codex agent prompts
```

## Customizations

### 1. Version-Tracked Governance

All custom governance files include semantic versioning tables for amendment tracking:

```markdown
| **Version** | **Ratified** | **Last Amended** | **Amended By** |
|-------------|--------------|------------------|----------------|
| 1.0.0       | 2025-12-07   | 2025-12-07       | Author         |
```

**Update versioning**:
```bash
/version-update constitution.md --verify
```

See [version-update-guide.md](.specify/templates/version-update-guide.md) for details.

### 2. Language-Specific Testing Policies

Custom policies define mandatory testing standards:

- **Python**: pytest, pytest-bdd, pytest-cov (≥80% coverage)
- **Rust**: cargo test/nextest, cucumber-rs, cargo llvm-cov (≥80% coverage)
- **JavaScript/TypeScript**: Vitest/Jest, Cucumber.js, Vitest/Jest coverage (≥80% coverage)

Policies include:
- Test runner requirements
- BDD framework configuration
- Coverage enforcement
- Directory layout standards
- Regression testing requirements

**Use in your project**:
```bash
cp .specify/memory/testing/*.md your-project/.specify/memory/testing/
```

### 3. Custom Agent Prompts

Slash command prompts for AI agents:

- **Copilot**: `/version-update` for versioning governance files
- **Roo**: `/version-update` with terminal execution support
- **Codex**: `/version-update` with implementation details

**Reference in your project**:
```bash
cp .github/prompts/speckit.version.update.*.md your-project/.github/prompts/
cp .codex/prompts/speckit*.md your-project/.codex/prompts/
```

## Syncing with Upstream

### Non-Breaking Customizations

spec-kit-savage maintains full compatibility with upstream spec-kit:

1. **Custom files don't overwrite spec-kit files**: All custom files have distinct names or locations
2. **Loader scripts discover both**: Custom files are discovered alongside spec-kit provided files
3. **Easy syncing**: Pull upstream changes without losing customizations

### Sync Workflow

**1. Add upstream as a remote**:
```bash
git remote add upstream https://github.com/github/spec-kit.git
```

**2. Fetch upstream changes**:
```bash
git fetch upstream main
```

**3. Merge upstream into your branch**:
```bash
git merge upstream/main
```

**4. Resolve conflicts (if any)**:
- Custom files in separate locations shouldn't conflict
- If conflicts occur, review and keep both versions

**5. Validate custom files still discoverable**:
```bash
bash .specify/loaders/load-all-custom.sh
```

## Contributing

### Adding New Customizations

**1. Create custom file in appropriate location**:
- Templates: `.specify/templates/custom-name.md`
- Policies: `.specify/memory/testing/custom-language.md`
- Prompts: `.github/prompts/speckit.custom.agent.md`

**2. For governance files, add version table**:
```markdown
| **Version** | **Ratified** | **Last Amended** | **Amended By** |
|-------------|--------------|------------------|----------------|
| 1.0.0       | 2025-12-07   | 2025-12-07       | Your Name      |
```

**3. Update version table when amending**:
```bash
/version-update your-file.md --verify
```

**4. Commit with proper message format**:
```bash
git commit -m "Refs: TASK-### Add custom [name] for [reason]"
```

### Proposing Changes to Upstream

If you have improvements that benefit the official spec-kit:

1. Create PR against [github/spec-kit](https://github.com/github/spec-kit)
2. Reference this repo if the change originated here
3. Keep change non-breaking for maximum compatibility

## Governance

### Amendment Process

For governance files (constitution, testing policies):

1. **Draft**: Make changes, update Last Amended and Amended By
2. **Review**: Circulate to team members
3. **Ratify**: Once approved, set Version and Ratified date
4. **Document**: Use loader scripts to validate changes
5. **Announce**: Update AGENTS.md and notify team

See [version-update-guide.md](.specify/templates/version-update-guide.md) for detailed workflow.

## Reference

- **Official spec-kit**: https://github.com/github/spec-kit
- **Loader scripts**: `.specify/loaders/README.md`
- **Version update guide**: `.specify/templates/version-update-guide.md`
- **Testing policies**: `.specify/memory/testing/`
- **Agent prompts**: `.github/prompts/` and `.codex/prompts/`

## License

Inherits license from upstream spec-kit. See LICENSE file.

## Support

For issues or questions:

1. Check loader scripts: `bash .specify/loaders/load-all-custom.sh`
2. Review version-update-guide: `.specify/templates/version-update-guide.md`
3. Consult testing policies: `.specify/memory/testing/`
4. Open issue on this repo or upstream

---

**Last Updated**: 2025-12-07
**Maintained by**: djh00t
