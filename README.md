Goose as SRE Agent
===============

This project configures [**block/goose**](https://github.com/block/goose) to act as an autonomous **Site Reliability Engineering (SRE)** agent.

### What is SRE?

**Site Reliability Engineering** applies software engineering principles to operations tasks. SREs are responsible for the availability, latency, performance, efficiency, change management, monitoring, emergency response, and capacity planning of services.

### Why an AI SRE Agent?

This configuration empowers Goose to handle complex operational workflows:
*   **Incident Investigation**: Automatically query logs and metrics to diagnose issues.
*   **Infrastructure Auditing**: Analyze AWS resources against Well-Architected frameworks.
*   **Toil Reduction**: Execute repetitive maintenance tasks reliably.

### Environment Configuration

This project uses **Nix** to create a reproducible, isolated development environment. This approach is critical because it (For a deeper dive into why this approach is valuable, check out this article: [Why I love using Nix for all my projects](https://dev.to/nietzscheson/why-i-love-using-nix-for-all-my-projects-3147).):

*   **Isolates dependencies**: Tools like `awscli` and `goose` are installed locally, keeping your global system clean.
*   **Localizes Configuration**: AWS credentials and configs are scoped to this project (using `.aws/config`), preventing accidental usage of wrong profiles.
*   **Standardizes Workflows**: Every developer runs the exact same versions of tools and configurations.

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

This will set up `awscli2`, and `goose-cli`, and configure your environment variables.

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
