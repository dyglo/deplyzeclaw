# Security Best Practices

Deplyze is designed to keep OpenClaw private by default and to make the Gemini key flow explicit.

## API Keys

- Do not commit `GEMINI_API_KEY` or any other provider key.
- Prefer environment variables or a secret manager over plaintext files.
- If you store a local `.env` for OpenClaw, keep it out of version control.
- This setup writes `GEMINI_API_KEY` to `~/.openclaw/.env` so the daemon can reload it later without manual shell exports.

## File Permissions

OpenClaw stores state in `~/.openclaw`. Lock it down after setup:

```bash
chmod 700 ~/.openclaw
chmod 600 ~/.openclaw/openclaw.json
chmod 600 ~/.openclaw/.env 2>/dev/null || true
```

## Gateway Exposure

- Keep the Gateway bound to loopback unless you explicitly need remote access.
- Treat the Control UI as an admin surface.
- If you publish later, use Tailscale Serve or SSH tunneling instead of a public bind.

## Auditing

Run regular checks after you change config or keys:

```bash
openclaw doctor --yes
openclaw security audit --deep
```

## Updates

Keep OpenClaw current:

```bash
openclaw update
```
