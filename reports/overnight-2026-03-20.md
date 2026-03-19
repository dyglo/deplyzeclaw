# Overnight Deplyze Check

- Date: 2026-03-20 00:26:40 EAT
- Repo: /mnt/d/agentic/deplyzeclaw

This report is read-only. It does not mutate config, channels, or the gateway.

## Git Status

```text

```

## Git Branch

```text
main
```

## OpenClaw Status

```text
OpenClaw status

Overview
┌─────────────────┬────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Item            │ Value                                                                                              │
├─────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Dashboard       │ http://127.0.0.1:18789/                                                                            │
│ OS              │ linux 6.6.87.2-microsoft-standard-WSL2 (x64) · node 22.22.1                                        │
│ Tailscale       │ off                                                                                                │
│ Channel         │ stable (default)                                                                                   │
│ Update          │ pnpm · npm latest unknown                                                                          │
│ Gateway         │ local · ws://127.0.0.1:18789 (local loopback) · unreachable (missing scope: operator.read)         │
│ Gateway service │ systemd installed · enabled · running (pid 7177, state active)                                     │
│ Node service    │ systemd not installed                                                                              │
│ Agents          │ 1 · 1 bootstrap file present · sessions 1 · default main active 45m ago                            │
│ Memory          │ 0 files · 0 chunks · dirty · sources memory · plugin memory-core · vector ready · fts ready ·      │
│                 │ cache on (0)                                                                                       │
│ Probes          │ skipped (use --deep)                                                                               │
│ Events          │ none                                                                                               │
│ Heartbeat       │ 30m (main)                                                                                         │
│ Sessions        │ 1 active · default gemini-3-pro-preview (1000k ctx) · ~/.openclaw/agents/main/sessions/sessions.   │
│                 │ json                                                                                               │
└─────────────────┴────────────────────────────────────────────────────────────────────────────────────────────────────┘

Security audit
Summary: 1 critical · 1 warn · 1 info
  CRITICAL Credentials dir is writable by others
    /home/tafar/.openclaw/credentials mode=775; another user could drop/modify credential files.
    Fix: chmod 700 /home/tafar/.openclaw/credentials
  WARN Reverse proxy headers are not trusted
    gateway.bind is loopback and gateway.trustedProxies is empty. If you expose the Control UI through a reverse proxy, configure trusted proxies so local-client c…
    Fix: Set gateway.trustedProxies to your proxy IPs or keep the Control UI local-only.
Full report: openclaw security audit
Deep probe: openclaw security audit --deep

Channels
┌──────────┬─────────┬────────┬────────────────────────────────────────────────────────────────────────────────────────┐
│ Channel  │ Enabled │ State  │ Detail                                                                                 │
├──────────┼─────────┼────────┼────────────────────────────────────────────────────────────────────────────────────────┤
│ WhatsApp │ ON      │ OK     │ linked · +256785735108 · auth 44m ago · accounts 1                                     │
└──────────┴─────────┴────────┴────────────────────────────────────────────────────────────────────────────────────────┘

Sessions
┌───────────────────────────────────────────┬────────┬─────────┬──────────────────────┬────────────────────────────────┐
│ Key                                       │ Kind   │ Age     │ Model                │ Tokens                         │
├───────────────────────────────────────────┼────────┼─────────┼──────────────────────┼────────────────────────────────┤
│ agent:main:main                           │ direct │ 45m ago │ gemini-3-pro-preview │ 46k/1000k (5%) · 🗄️ 45% cached │
└───────────────────────────────────────────┴────────┴─────────┴──────────────────────┴────────────────────────────────┘

FAQ: https://docs.openclaw.ai/faq
Troubleshooting: https://docs.openclaw.ai/troubleshooting

Next steps:
  Need to share?      openclaw status --all
  Need to debug live? openclaw logs --follow
  Fix reachability first: openclaw gateway probe
```

## Gateway Status

```text
│
◇  Doctor warnings ────────────────────────────────────────────────────────╮
│                                                                          │
│  - channels.whatsapp.groupPolicy is "allowlist" but groupAllowFrom (and  │
│    allowFrom) is empty — all group messages will be silently dropped.    │
│    Add sender IDs to channels.whatsapp.groupAllowFrom or                 │
│    channels.whatsapp.allowFrom, or set groupPolicy to "open".            │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────╯
Service: systemd (enabled)
File logs: /tmp/openclaw/openclaw-2026-03-20.log
Command: /home/tafar/.local/node/node-v22.22.1-linux-x64/bin/node /home/tafar/.local/lib/node_modules/openclaw/dist/index.js gateway --port 18789
Service file: ~/.config/systemd/user/openclaw-gateway.service
Service env: OPENCLAW_GATEWAY_PORT=18789

Config (cli): ~/.openclaw/openclaw.json
Config (service): ~/.openclaw/openclaw.json

Gateway: bind=loopback (127.0.0.1), port=18789 (service args)
Probe target: ws://127.0.0.1:18789
Dashboard: http://127.0.0.1:18789/
Probe note: Loopback-only gateway; only local clients can connect.

Runtime: running (pid 7177, state active, sub running, last exit 0, reason 0)
RPC probe: ok

Listening: 127.0.0.1:18789
Troubles: run openclaw status
Troubleshooting: https://docs.openclaw.ai/troubleshooting
```

## Channel Probe

```text
│
◇  Doctor warnings ────────────────────────────────────────────────────────╮
│                                                                          │
│  - channels.whatsapp.groupPolicy is "allowlist" but groupAllowFrom (and  │
│    allowFrom) is empty — all group messages will be silently dropped.    │
│    Add sender IDs to channels.whatsapp.groupAllowFrom or                 │
│    channels.whatsapp.allowFrom, or set groupPolicy to "open".            │
│                                                                          │
├──────────────────────────────────────────────────────────────────────────╯
Checking channel status (probe)…
Gateway reachable.
- WhatsApp default: enabled, configured, linked, stopped, disconnected, dm:pairing, error:{"error":{"data":{"code":"ETIMEDOUT"},"isBoom":true,"isServer":false,"output":{"statusCode":408,"payload":{"statusCode":408,"error":"Request Time-out","message":"WebSocket Error ()"},"headers":{}}},"date":"2026-03-19T21:26:22.107Z"}

Tip: https://docs.openclaw.ai/cli#status adds gateway health probes to status output (requires a reachable gateway).
```

## Config Primary Model

```text
google/gemini-3-pro-preview
```

## Config Workspace

```text
/mnt/d/agentic/deplyzeclaw/workspace
```

## Config Gateway Bind

```text
loopback
```

## Config Gateway Port

```text
18789
```

## Config Tool Profile

```text
coding
```
