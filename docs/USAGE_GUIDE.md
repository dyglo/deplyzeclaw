# Usage Guide

This repo is optimized for a local OpenClaw Gateway with Gemini and the browser Control UI.

## Common Commands

| Command | Purpose |
| --- | --- |
| `openclaw dashboard` | Open the Control UI for the current Gateway. |
| `openclaw status` | Check the current OpenClaw state. |
| `openclaw gateway status --no-probe` | Inspect Gateway install and service state without starting it. |
| `openclaw gateway start` | Start the Gateway explicitly when you are ready. |
| `openclaw doctor --yes` | Run health checks and safe repairs. |
| `openclaw security audit --deep` | Run the deeper security audit. |
| `openclaw logs --follow` | Follow Gateway logs while debugging. |

## Model Management

The default model is `google/gemini-3-pro-preview`.

To check it:

```bash
openclaw config get agents.defaults.model.primary
```

To change it:

```bash
openclaw config set agents.defaults.model.primary google/gemini-3-pro-preview
```

## Gemini Web Grounding

Gemini powers the web search provider too, using the same `GEMINI_API_KEY`.

To verify the provider:

```bash
openclaw config get tools.web.search.provider
```

To switch the provider or model later:

```bash
openclaw config set tools.web.search.provider gemini
openclaw config set tools.web.search.gemini.model gemini-2.5-flash
```

## Workspace Notes

The default workspace lives in `./workspace` inside this repo. Keep it local unless you intentionally want a different path.

## Autonomy and Overnight Jobs

The repo ships a read-only overnight check script:

```bash
scripts/overnight-check.sh
```

Use it as the first unattended job. It collects repo status, OpenClaw health, and config values, then writes a report to `workspace/reports/`.

For the operating rules behind unattended work, see [Autonomy Playbook](AUTONOMY.md).

## Publishing Later

If you need access from another machine, prefer Tailscale Serve or an SSH tunnel. Keep the Gateway on loopback and avoid exposing the Control UI directly.
