#!/bin/bash

# This script downloads the latest versions of ruff.toml and .pre-commit-config.yaml
# from the hailstone-config repository and places them in your project's root directory.
# It also runs `pre-commit install` for you.

# The URL for the raw files on GitHub.
BASE_URL="https://raw.githubusercontent.com/Hailstone-Labs/hailstone-config/main"

# Download the files.
curl -fsSL "$BASE_URL/ruff.toml" -o "ruff.toml"
curl -fsSL "$BASE_URL/.pre-commit-config.yaml" -o ".pre-commit-config.yaml"

# Install pre-commit hooks.
if ! command -v pre-commit &> /dev/null
then
    echo "pre-commit could not be found. Please install it first."
    echo "  pip install pre-commit"
    exit 1
fi
pre-commit install
