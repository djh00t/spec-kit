#!/bin/bash
# discover-policies.sh - Discover and list all custom testing policies
# Purpose: Find all custom policy files in .specify/memory/testing/
# Usage: source .specify/loaders/discover-policies.sh
#        discover_policies [language]

set -euo pipefail

discover_policies() {
  local policy_dir=".specify/memory/testing"
  local language="${1:-}"
  local custom_policies=()
  
  if [[ ! -d "$policy_dir" ]]; then
    echo "Error: Policy directory not found: $policy_dir" >&2
    return 1
  fi
  
  if [[ -n "$language" ]]; then
    # Find policy for specific language
    local policy_file="$policy_dir/${language}.md"
    if [[ -f "$policy_file" ]]; then
      echo "$policy_file"
    else
      echo "Error: No policy found for language: $language" >&2
      return 1
    fi
  else
    # Find all policies
    while IFS= read -r policy_file; do
      if [[ -f "$policy_file" ]]; then
        custom_policies+=("$policy_file")
      fi
    done < <(find "$policy_dir" -maxdepth 1 -name "*.md" -type f 2>/dev/null)
    
    if [[ ${#custom_policies[@]} -gt 0 ]]; then
      for policy in "${custom_policies[@]}"; do
        echo "$policy"
      done
    else
      echo "Warning: No policies found in $policy_dir" >&2
      return 1
    fi
  fi
}

# Auto-run if sourced directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  discover_policies "$@"
fi
