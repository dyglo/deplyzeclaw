# 📖 Usage Guide

Deplyze (OpenClaw with Gemini) is a powerful tool for managing autonomous AI agents. This guide covers common commands and workflows.

## 🛠 Core Commands

| Command | Description |
| :--- | :--- |
| `openclaw status` | Check overall health and connected channels. |
| `openclaw models list` | View available and configured LLM models. |
| `openclaw agents list` | Manage your isolated agent workspaces. |
| `openclaw channels add` | Connect a new chat platform (Telegram, Discord, etc.). |
| `openclaw doctor` | Perform health checks and apply quick fixes. |
| `openclaw logs --follow` | Monitor live gateway logs. |

## 🤖 Managing Models

To switch your default model to another Gemini variant:

```bash
openclaw models set google/gemini-1.5-flash
```

To view model authentication profiles:

```bash
openclaw models auth list
```

## 🔌 Connecting Channels

To connect a Telegram bot:

1. Run `openclaw channels add`.
2. Select **Telegram**.
3. Provide your bot token from @BotFather.

## 📁 Workspace Management

Deplyze keeps agent data, memory, and sessions in a workspace. You can switch workspaces using the `--workspace` flag or by setting the `OPENCLAW_AGENT_DIR` environment variable.

```bash
# Run a command in a specific workspace
openclaw status --workspace /path/to/my-agent
```

## 🧪 Advanced Usage

### Running as a Service
For persistent availability, it\'s recommended to run OpenClaw under a process manager like `systemd` or `pm2`.

### Gateway Token
The gateway is protected by a token. You can find your token in `~/.openclaw/openclaw.json`.
