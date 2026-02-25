#!/bin/bash

# Optional : Install Rust + Cargo
# This will install the latest stable version of Rust and Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


# Rust / Cargo Path
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi
