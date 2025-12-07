# Custom File Loaders

Loader scripts for discovering and managing custom spec-kit-savage files.

## Overview

These bash scripts automatically discover and validate all custom templates, policies, and prompts in the spec-kit-savage fork.

## Usage

### Discover All Templates

```bash
bash .specify/loaders/discover-templates.sh
```

Lists all custom markdown templates in `.specify/templates/`.

### Discover All Testing Policies

```bash
bash .specify/loaders/discover-policies.sh
```

Lists all custom testing policies in `.specify/memory/testing/`.

Discover policy for a specific language:

```bash
bash .specify/loaders/discover-policies.sh python
bash .specify/loaders/discover-policies.sh rust
bash .specify/loaders/discover-policies.sh javascript_typescript
```

### Discover All Agent Prompts

```bash
bash .specify/loaders/discover-prompts.sh
```

Lists all custom agent prompts in `.github/prompts/` and `.codex/prompts/`.

Discover prompts for a specific agent:

```bash
bash .specify/loaders/discover-prompts.sh copilot
bash .specify/loaders/discover-prompts.sh roo
bash .specify/loaders/discover-prompts.sh codex
```

### Load and Validate All Custom Files

```bash
bash .specify/loaders/load-all-custom.sh
```

Discovery all custom files and displays a summary report.

## File Organization

Custom files are stored alongside spec-kit provided files:

- **Templates**: `.specify/templates/*.md`
- **Testing Policies**: `.specify/memory/testing/*.md`
- **GitHub Prompts**: `.github/prompts/speckit*.md`
- **Codex Prompts**: `.codex/prompts/speckit*.md`

## Integration with Makefile

Add loader commands to your `Makefile`:

```makefile
.PHONY: list-templates
list-templates:
	@bash .specify/loaders/discover-templates.sh

.PHONY: list-policies
list-policies:
	@bash .specify/loaders/discover-policies.sh

.PHONY: list-prompts
list-prompts:
	@bash .specify/loaders/discover-prompts.sh

.PHONY: list-custom
list-custom:
	@bash .specify/loaders/load-all-custom.sh
```

## Syncing with Upstream

Loader scripts automatically discover all custom files, allowing you to:

1. Keep custom and spec-kit provided files in the same locations
2. Pull upstream updates without overwriting custom files
3. Validate custom files remain discoverable after sync

## Exit Codes

- `0`: Success - files discovered
- `1`: Error - directory not found or no files found

## Notes

- Scripts use `.md` extension to identify markdown files
- All scripts are idempotent and can be run multiple times
- Scripts output file paths (one per line) for easy parsing
- Used by CI/CD pipelines for validation and automation
