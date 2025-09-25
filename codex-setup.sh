#!/usr/bin/env bash
# Codex Configuration Script (portable version without mapfile)
# Works on macOS (Bash 3.2) and Linux

set -euo pipefail

# Configuration
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
CONFIG_DIR="./configs"
PROMPTS_DIR="./prompts"
CONFIG_LINK="$CODEX_HOME/config.toml"
PROMPTS_DEST="$CODEX_HOME/prompts"

# Ensure required directories exist
mkdir -p "$CODEX_HOME"
mkdir -p "$PROMPTS_DEST"

# Basic checks for project directories
if [ ! -d "$CONFIG_DIR" ]; then
  echo "ERROR: $CONFIG_DIR not found."
  exit 1
fi
if [ ! -d "$PROMPTS_DIR" ]; then
  echo "ERROR: $PROMPTS_DIR not found."
  exit 1
fi

# Helper: portable absolute path
abspath() {
  local target="$1"
  if [ -d "$target" ]; then
    (cd "$target" && pwd)
  else
    local dir
    dir="$(cd "$(dirname "$target")" && pwd)"
    echo "$dir/$(basename "$target")"
  fi
}

echo "==============================="
echo " Codex Configuration Script"
echo " CODEX_HOME: $CODEX_HOME"
echo "==============================="
echo
echo "Enter 1 to set up Codex CLI configuration"
echo "Enter 2 to set up Prompts"
printf "Your choice (1/2): "
read -r main_choice

case "$main_choice" in
  1)
    echo
    echo "== Set up Codex CLI configuration =="
    configs=$(ls -1 "$CONFIG_DIR" 2>/dev/null || true)

    if [ -z "$configs" ]; then
      echo "No files found in $CONFIG_DIR."
      exit 1
    fi

    echo "Available configs:"
    echo "$configs" | sed 's/^/  - /'
    echo
    printf "Type the FIRST TWO CHARACTERS that match the desired configuration file: "
    read -r prefix
    prefix=$(echo "$prefix" | cut -c1-2)

    matches=$(echo "$configs" | grep -i "^$prefix" || true)

    if [ -z "$matches" ]; then
      echo "No config file matches '$prefix'."
      exit 1
    fi

    count=$(echo "$matches" | wc -l | tr -d ' ')
    if [ "$count" -gt 1 ]; then
      echo "Multiple matches:"
      echo "$matches" | sed 's/^/  - /'
      printf "Type the full file name: "
      read -r selected
    else
      selected="$matches"
    fi

    selected_path=$(abspath "$CONFIG_DIR/$selected")

    echo "Updating symlink: $CONFIG_LINK -> $selected_path"
    if [ -L "$CONFIG_LINK" ]; then
      rm -f "$CONFIG_LINK"
    elif [ -e "$CONFIG_LINK" ]; then
      ts=$(date +%Y%m%d-%H%M%S)
      mv "$CONFIG_LINK" "$CONFIG_LINK.bak.$ts"
      echo "Backed up old config to $CONFIG_LINK.bak.$ts"
    fi
    ln -s "$selected_path" "$CONFIG_LINK"
    echo "Done."
    ;;

  2)
    echo
    echo "== Set up Prompts =="
    prompts=$(ls -1 "$PROMPTS_DIR"/*.md 2>/dev/null | sed -e 's#.*/##' -e 's#\.md$##' || true)

    if [ -z "$prompts" ]; then
      echo "No .md prompts found in $PROMPTS_DIR."
      exit 1
    fi

    echo "Available prompts:"
    echo "$prompts" | sed 's/^/  - /'
    echo
    printf "Type the prompt name: "
    read -r prompt_name

    src_md="$PROMPTS_DIR/$prompt_name.md"
    if [ ! -f "$src_md" ]; then
      echo "Prompt '$prompt_name' not found."
      exit 1
    fi

    cp -f "$src_md" "$PROMPTS_DEST/"
    echo "Copied $src_md -> $PROMPTS_DEST/"
    ;;

  *)
    echo "Invalid choice. Run again and choose 1 or 2."
    exit 1
    ;;
esac
