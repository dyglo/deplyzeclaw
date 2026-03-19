# Quickstart

This guide sets up OpenClaw with Gemini on WSL2 or Linux and opens the browser Control UI on `localhost`.

## Prerequisites

- WSL2 Ubuntu or another Linux distribution
- Node.js 22 or newer
- `npm`
- A Gemini API key from Google AI Studio

## 1. Export Your Gemini Key

```bash
export GEMINI_API_KEY="your-gemini-api-key"
```

If you prefer a shell profile or secret manager, make sure the key is available in the environment before setup starts.

## 2. Run Setup

```bash
./scripts/setup.sh
```

The setup script:

- refuses native Windows shells and Windows-mounted OpenClaw binaries
- installs OpenClaw locally if it is missing
- onboards a loopback Gateway with Gemini auth
- configures the workspace, model defaults, and Gemini web grounding
- writes the Gemini key into `~/.openclaw/.env` with restrictive permissions for the daemon
- installs the daemon without starting the gateway

## 3. Start the Gateway

```bash
openclaw gateway start
```

## 4. Open the Control UI

```bash
openclaw dashboard
```

The dashboard should open at `http://127.0.0.1:18789/`.

## 5. Verify the Setup

```bash
openclaw status
openclaw gateway status --no-probe
openclaw config get agents.defaults.model.primary
openclaw config get tools.web.search.provider
```

## 6. Run the First Unattended Job

Use the safe overnight check as the first “sleep while it works” task:

```bash
scripts/overnight-check.sh
```

It writes a report to `workspace/reports/` and does not mutate the gateway or channel state.

## Publishing Later

If you want remote access later, keep the Gateway bound to loopback and use a secure tunnel such as Tailscale Serve or SSH port forwarding. Do not expose the Control UI directly to the public internet.

## Reference

- [Emergent tutorial](https://emergent.sh/tutorial/moltbot-on-emergent)
