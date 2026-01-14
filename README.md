Goose as SRE Agent
===============

block/goose as an SRE AI agent.

# Installation

1. Clone this repository:

```bash
git clone https://github.com/nietzscheson/goose-sre-agent
cd goose-sre-agent
```

2. Enter the development environment using Nix:

```bash
nix develop
```

This will set up `git`, `awscli2`, and `goose-cli`, and configure your environment variables.

# Usage

## AWS Configuration

We need to set how we can login in AWS:

```bash
aws configure sso
```

Login with the default profile:

```bash
aws sso login --profile default
```

Verify you are logged in:

```bash
aws sts get-caller-identity --profile default
```

The Nix environment sets `AWS_CONFIG_FILE` to `.aws/config` inside this repository, so your configuration will be local to this project.

## Environment Variables

The user need just their aws environment as variables in `.env`.

1. Copy the example file:

```bash
cp .env.dist .env
```

2. Edit `.env` to include your configuration.

# Project Structure

```bash
.
├── .aws/                 # Local AWS Configuration
├── .goose/               # Goose CLI Configuration
├── flake.nix             # Nix Environment Definition
└── pyproject.toml        # Project Dependencies
```
