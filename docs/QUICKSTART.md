# 🚀 Quickstart Guide

This guide will help you set up OpenClaw with Gemini in under 5 minutes.

## Prerequisites

- **Node.js**: v22.x (Recommended)
- **NPM**: Latest version
- **Gemini API Key**: Obtain one from [Google AI Studio](https://aistudio.google.com/)

## Installation

### 1. Install OpenClaw CLI
```bash
npm install -g openclaw
```

### 2. Initialize and Configure Gemini
Run the onboarding wizard in non-interactive mode to quickly set up your Gemini API:

```bash
openclaw onboard \
  --non-interactive \
  --accept-risk \
  --gemini-api-key "YOUR_GEMINI_API_KEY" \
  --skip-daemon \
  --skip-channels \
  --skip-ui \
  --workspace ./openclaw-workspace
```

### 3. Verify Configuration
Check if Gemini is correctly listed as the primary model:

```bash
openclaw models list
```

### 4. Start the Gateway
Run the OpenClaw gateway in the background:

```bash
nohup openclaw gateway > openclaw.log 2>&1 &
```

## Next Steps

- **Manage Agents**: Use `openclaw agents` to list or switch workspaces.
- **Add Channels**: Connect Telegram or Discord via `openclaw channels add`.
- **Check Health**: Run `openclaw doctor` to ensure everything is configured correctly.

For more detailed usage, see the [Usage Guide](./USAGE_GUIDE.md).
