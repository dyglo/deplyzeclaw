# 🛡 Security Best Practices

Deplyze (OpenClaw with Gemini) handles sensitive data and API keys. This guide outlines how to keep your deployment secure.

## 🔐 API Key Management

- **Never Commit Secrets**: Do not add your API keys to the repository.
- **Use Environment Variables**: Pass keys via CLI flags or set them in your environment.
- **Restricted Scopes**: Use API keys with the minimum necessary permissions.

## 📁 File Permissions

OpenClaw stores configuration and credentials in `~/.openclaw`. Ensure these files are restricted:

```bash
# Secure the config directory
chmod 700 ~/.openclaw
# Secure individual config files
chmod 600 ~/.openclaw/openclaw.json
```

## 🔒 Gateway Security

- **Authentication**: The gateway uses token-based authentication. Keep your token secret.
- **Loopback Bind**: By default, the gateway binds to `127.0.0.1`. Do not expose it publicly without a secure tunnel (e.g., Tailscale or a VPN).
- **Reverse Proxy**: If using a reverse proxy, configure `trustedProxies` in your config.

## 🛠 Security Audit

Run the built-in security auditor regularly:

```bash
openclaw security audit --deep
```

To automatically apply safe security fixes:

```bash
openclaw security audit --fix
```

## 🔄 Updates

Keep OpenClaw updated to receive the latest security patches:

```bash
openclaw update
```
