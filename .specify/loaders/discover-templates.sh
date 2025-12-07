#!/bin/bash
# discover-templates.sh - Discover and list all custom templates
# Purpose: Find all custom template files in .specify/templates/
# Usage: source .specify/loaders/discover-templates.sh
#        discover_templates

set -euo pipefail

discover_templates() {
  local template_dir=".specify/templates"
  local custom_templates=()
  
  if [[ ! -d "$template_dir" ]]; then
    echo "Error: Template directory not found: $template_dir" >&2
    return 1
  fi
  
  # Find all markdown files in templates directory
  while IFS= read -r template_file; do
    if [[ -f "$template_file" ]]; then
      custom_templates+=("$template_file")
    fi
  done < <(find "$template_dir" -maxdepth 1 -name "*.md" -type f 2>/dev/null)
  
  # Output discovered templates
  if [[ ${#custom_templates[@]} -gt 0 ]]; then
    for template in "${custom_templates[@]}"; do
      echo "$template"
    done
  else
    echo "Warning: No templates found in $template_dir" >&2
    return 1
  fi
}

# Auto-run if sourced directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  discover_templates "$@"
fi
