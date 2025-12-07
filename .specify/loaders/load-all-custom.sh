#!/bin/bash
# load-all-custom.sh - Load and validate all custom files
# Purpose: Discover and validate all custom template, policy, and prompt files
# Usage: source .specify/loaders/load-all-custom.sh
#        load_all_custom

set -euo pipefail

LOADER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

load_all_custom() {
  echo "🔍 Discovering custom files..."
  
  local templates=0
  local policies=0
  local prompts=0
  local errors=0
  
  # Load templates
  echo ""
  echo "📋 Custom Templates:"
  if bash "$LOADER_DIR/discover-templates.sh" 2>/dev/null | while read -r template; do
    if [[ -f "$template" ]]; then
      echo "  ✓ $template"
      ((templates++))
    fi
  done; then
    true
  else
    ((errors++))
  fi
  
  # Load policies
  echo ""
  echo "🧪 Custom Testing Policies:"
  if bash "$LOADER_DIR/discover-policies.sh" 2>/dev/null | while read -r policy; do
    if [[ -f "$policy" ]]; then
      echo "  ✓ $policy"
      ((policies++))
    fi
  done; then
    true
  else
    ((errors++))
  fi
  
  # Load prompts
  echo ""
  echo "🤖 Custom Agent Prompts:"
  if bash "$LOADER_DIR/discover-prompts.sh" 2>/dev/null | while read -r prompt; do
    if [[ -f "$prompt" ]]; then
      echo "  ✓ $prompt"
      ((prompts++))
    fi
  done; then
    true
  else
    ((errors++))
  fi
  
  echo ""
  echo "📊 Summary:"
  echo "  Templates: $templates"
  echo "  Policies: $policies"
  echo "  Prompts: $prompts"
  echo "  Errors: $errors"
  
  return 0
}

# Auto-run if sourced directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  load_all_custom "$@"
fi
