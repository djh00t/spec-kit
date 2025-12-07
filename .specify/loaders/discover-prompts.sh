#!/bin/bash
# discover-prompts.sh - Discover and list all custom agent prompts
# Purpose: Find all custom prompt files in .github/prompts/ and .codex/prompts/
# Usage: source .specify/loaders/discover-prompts.sh
#        discover_prompts [agent]

set -euo pipefail

discover_prompts() {
  local agent="${1:-}"
  local github_prompts=".github/prompts"
  local codex_prompts=".codex/prompts"
  local custom_prompts=()
  
  if [[ -n "$agent" ]]; then
    # Find prompts for specific agent
    local agent_pattern="speckit*.${agent}.md"
    
    while IFS= read -r prompt_file; do
      if [[ -f "$prompt_file" ]]; then
        custom_prompts+=("$prompt_file")
      fi
    done < <(find "$github_prompts" "$codex_prompts" -maxdepth 1 -name "$agent_pattern" -type f 2>/dev/null)
    
    if [[ ${#custom_prompts[@]} -gt 0 ]]; then
      for prompt in "${custom_prompts[@]}"; do
        echo "$prompt"
      done
    else
      echo "Error: No prompts found for agent: $agent" >&2
      return 1
    fi
  else
    # Find all prompts
    for prompt_dir in "$github_prompts" "$codex_prompts"; do
      if [[ -d "$prompt_dir" ]]; then
        while IFS= read -r prompt_file; do
          if [[ -f "$prompt_file" ]]; then
            custom_prompts+=("$prompt_file")
          fi
        done < <(find "$prompt_dir" -maxdepth 1 -name "speckit*.md" -type f 2>/dev/null)
      fi
    done
    
    if [[ ${#custom_prompts[@]} -gt 0 ]]; then
      for prompt in "${custom_prompts[@]}"; do
        echo "$prompt"
      done
    else
      echo "Warning: No prompts found" >&2
      return 1
    fi
  fi
}

# Auto-run if sourced directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  discover_prompts "$@"
fi
