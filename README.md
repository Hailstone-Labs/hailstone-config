# hailstone-config

This repository contains master configuration files for various tools used in Hailstone Labs projects. The goal is to have a centralized place for these configurations to ensure consistency across all our repositories.

## Ruff Configuration

`ruff.toml` is a master configuration file for the [Ruff](https://github.com/astral-sh/ruff) linter and formatter.

## Pre-commit Configuration

`.pre-commit-config.yaml` is a master configuration file for [pre-commit](https://pre-commit.com/). It is configured to use the `ruff.toml` file in this repository.

## Usage

To use these configuration files in your project, you can either manually copy them or use the provided setup script.

### Manual Setup

1.  Copy the `ruff.toml` file to the root of your project.
2.  Copy the `.pre-commit-config.yaml` file to the root of your project.
3.  If you don't have `pre-commit` installed, install it:
    ```bash
    pip install pre-commit
    ```
4.  Install the git hooks:
    ```bash
    pre-commit install
    ```

### Automated Setup

To automate the setup process, you can use the `setup-hailstone-config.sh` script.

1.  Download the `setup-hailstone-config.sh` script to your project's root directory.
    ```bash
    curl -fsSL https://raw.githubusercontent.com/Hailstone-Labs/hailstone-config/main/setup-hailstone-config.sh -o setup-hailstone-config.sh
    ```
2.  Make the script executable:
    ```bash
    chmod +x setup-hailstone-config.sh
    ```
3.  Run the script:
    ```bash
    ./setup-hailstone-config.sh
    ```

The script will download the latest versions of `ruff.toml` and `.pre-commit-config.yaml` from this repository and place them in your project's root directory. It will also run `pre-commit install` for you.
