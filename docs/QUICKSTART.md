# 🚀 Quickstart Guide (WSL2 / Linux)

This guide will help you set up Deplyze (OpenClaw with Gemini) in under 5 minutes on WSL2 Ubuntu or any Linux distribution.

## Prerequisites

- **WSL2 Enabled** (if on Windows)
- **Ubuntu Distribution** installed (e.g., Ubuntu 22.04 LTS)
- **Node.js**: v22.x (Recommended)
- **NPM**: Latest version
- **Git**: For cloning the repository.

## Installation

### 1. Open Your Project in WSL2

In VS Code, use the **WSL extension** to connect to your Ubuntu distribution. Then, clone the Deplyze repository:

```bash
git clone https://github.com/dyglo/deplyzeclaw.git
cd deplyzeclaw
```

### 2. Run the Setup Script

This script will install the OpenClaw CLI, prompt you for your Gemini API Key, and configure OpenClaw to use Gemini as its primary model. It also installs the OpenClaw daemon for better background support.

```bash
./scripts/setup.sh
```

When prompted, enter your Gemini API Key. You can obtain one from [Google AI Studio](https://aistudio.google.com/).

### 3. Start the Gateway

Once the setup is complete, you can start the OpenClaw gateway in the background:

```bash
nohup openclaw gateway > openclaw.log 2>&1 &
```

### 4. Verify Configuration

Check if Gemini is correctly listed as the primary model and the gateway is running:

```bash
openclaw models list
openclaw status
```

## Next Steps

- **Manage Agents**: Use `openclaw agents` to list or switch workspaces.
- **Add Channels**: Connect Telegram or Discord via `openclaw channels add`.
- **Check Health**: Run `openclaw doctor` to ensure everything is configured correctly.

For more detailed usage, see the [Usage Guide](./USAGE_GUIDE.md).
