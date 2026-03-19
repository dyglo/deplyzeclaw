# DeplyzeClaw 🦞

**DeplyzeClaw** is a streamlined deployment and configuration framework for **OpenClaw (formerly MoltBot)**, specifically optimized for integration with **Google Gemini API**. 

This repository provides a standardized environment for running autonomous AI agents that can manage messages, handle background tasks, and learn user preferences using the latest Gemini models.

## 🚀 Quick Start

To get up and running in minutes, follow our [Quickstart Guide](./docs/QUICKSTART.md).

```bash
# Clone and initialize
git clone https://github.com/dyglo/deplyzeclaw.git
cd deplyzeclaw
# Follow the instructions in QUICKSTART.md to configure your Gemini API
```

## 🛠 Features

- **Gemini-First Configuration**: Pre-configured to work seamlessly with `google/gemini-3-pro-preview`.
- **Autonomous Execution**: Runs OpenClaw as a background gateway for persistent agent availability.
- **Security-Hardened**: Implements best practices for API key management and file permissions.
- **CLI-Driven**: Full control via the powerful OpenClaw CLI.

## 📂 Project Structure

- `config/`: Configuration templates for OpenClaw and agent profiles.
- `docs/`: Detailed guides and documentation.
  - [QUICKSTART.md](./docs/QUICKSTART.md): Get started in 5 minutes.
  - [USAGE_GUIDE.md](./docs/USAGE_GUIDE.md): Master the OpenClaw CLI.
  - [SECURITY.md](./docs/SECURITY.md): Best practices for keeping your agent safe.
- `scripts/`: Helper scripts for installation and maintenance.

## 🔗 References

- [Original Tutorial: MoltBot on Emergent](https://emergent.sh/tutorial/moltbot-on-emergent)
- [OpenClaw Documentation](https://docs.openclaw.ai/)

---

> "Neo is your AI assistant that actually does things — manages your messages, and works in the background so you don't have to. It remembers what matters, learns your preferences, and handles tasks autonomously while you focus on what's important."
