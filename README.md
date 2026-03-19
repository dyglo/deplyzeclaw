# Deplyze 🦞

**Deplyze** is a streamlined deployment and configuration framework for **OpenClaw (formerly MoltBot)**, specifically optimized for integration with **Google Gemini API**. 

This repository provides a standardized environment for running autonomous AI agents that can manage messages, handle background tasks, and learn user preferences using the latest Gemini models.

## 🚀 Quick Start

To get up and running in minutes, follow our [Quickstart Guide](./docs/QUICKSTART.md).

```bash
# Clone the repository
git clone https://github.com/dyglo/deplyzeclaw.git
cd deplyzeclaw

# Run the setup script
./scripts/setup.sh
```

## 🛠 Features

- **Gemini-First Configuration**: Pre-configured to work seamlessly with `google/gemini-3-pro-preview`.
- **Automated Setup**: A simple script to install OpenClaw and configure Gemini.
- **Autonomous Execution**: Runs OpenClaw as a background gateway for persistent agent availability.
- **Security-Hardened**: Implements best practices for API key management and file permissions.
- **CLI-Driven**: Full control via the powerful OpenClaw CLI.

## 📂 Project Structure

- `config/`: Configuration templates for OpenClaw and agent profiles.
  - `openclaw.json.template`: A template for the OpenClaw configuration.
- `docs/`: Detailed guides and documentation.
  - [QUICKSTART.md](./docs/QUICKSTART.md): Get started in 5 minutes.
  - [USAGE_GUIDE.md](./docs/USAGE_GUIDE.md): Master the OpenClaw CLI.
  - [SECURITY.md](./docs/SECURITY.md): Best practices for keeping your agent safe.
- `scripts/`: Helper scripts for installation and maintenance.
  - `setup.sh`: The main setup script to install and configure OpenClaw.

## 🔗 References

- [Original Tutorial: MoltBot on Emergent](https://emergent.sh/tutorial/moltbot-on-emergent)
- [OpenClaw Documentation](https://docs.openclaw.ai/)

---

> "Neo is your AI assistant that actually does things — manages your messages, and works in the background so you don't have to. It remembers what matters, learns your preferences, and handles tasks autonomously while you focus on what's important."
