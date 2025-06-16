#!/bin/bash

set -e  # Exit on error

install_with_cargo() {
  TOOL=$1
  if ! command -v "$TOOL" >/dev/null 2>&1; then
    echo "Installing $TOOL via cargo..."
    cargo install "$TOOL"
  else
    echo "$TOOL is already installed. Skipping..."
  fi
}

install_with_cargo bat
install_with_cargo eza
install_with_cargo ripgrep  # 'rg' binary is provided by 'ripgrep'

