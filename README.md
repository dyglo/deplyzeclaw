# DeplyzeClaw 🦞

Deplyze is a local-first OpenClaw bootstrap for WSL2/Linux, tuned for Gemini and the browser Control UI.

It sets up a loopback Gateway, keeps the dashboard private by default, and leaves the gateway start step explicit so you can publish it later on your own terms.

## Quick Start

```bash
export GEMINI_API_KEY="your-gemini-key"
./scripts/setup.sh
openclaw gateway start
openclaw dashboard
```

## Defaults

- Model: `google/gemini-3-pro-preview`
- Gateway: loopback on port `18789`
- Workspace: `./workspace`
- Tool profile: `coding`
- Web search: Gemini grounding with the same `GEMINI_API_KEY`

## What You Get

- A native Linux OpenClaw CLI
- Non-interactive onboarding with Gemini auth
- A daemon install for background availability
- A dashboard-ready local setup without auto-starting the gateway
- A safe autonomy playbook and a first overnight health-check job

## Next Steps

1. Start the gateway when you are ready: `openclaw gateway start`
2. Open the dashboard after the gateway is running: `openclaw dashboard`
3. If you later want remote access, use Tailscale Serve or an SSH tunnel instead of exposing the Control UI directly
4. Run the first unattended health check when you want a safe “sleep while it works” job: `scripts/overnight-check.sh`

## References

- [Emergent tutorial](https://emergent.sh/tutorial/moltbot-on-emergent)
- [OpenClaw documentation](https://docs.openclaw.ai/)
- [Autonomy playbook](docs/AUTONOMY.md)
