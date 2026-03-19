#!/usr/bin/env bash
set -euo pipefail
umask 077

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE_DIR="${OPENCLAW_WORKSPACE_DIR:-$ROOT_DIR/workspace}"
OPENCLAW_PORT="${OPENCLAW_PORT:-18789}"
OPENCLAW_MODEL="${OPENCLAW_MODEL:-google/gemini-3-pro-preview}"
OPENCLAW_ENV_FILE="$HOME/.openclaw/.env"
OPENCLAW_SERVICE_FILE="$HOME/.config/systemd/user/openclaw-gateway.service"

export PATH="$HOME/.local/bin:$PATH"
case " ${NODE_OPTIONS:-} " in
  *" --dns-result-order=ipv4first "* ) ;;
  *) export NODE_OPTIONS="${NODE_OPTIONS:-}${NODE_OPTIONS:+ }--dns-result-order=ipv4first" ;;
esac
case " ${NODE_OPTIONS:-} " in
  *" --no-network-family-autoselection "* ) ;;
  *) export NODE_OPTIONS="${NODE_OPTIONS:-}${NODE_OPTIONS:+ }--no-network-family-autoselection" ;;
esac

info() {
  printf '%s\n' "$*"
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

require_linux() {
  case "$(uname -s)" in
    Linux) ;;
    *)
      die "Run this setup from WSL2 or Linux. Native Windows shells are not supported."
      ;;
  esac
}

require_node_22() {
  command -v node >/dev/null 2>&1 || die "Node.js v22+ is required."

  local node_version node_major
  node_version="$(node -p 'process.versions.node.split("-")[0]')"
  node_major="${node_version%%.*}"

  if [[ ! "$node_major" =~ ^[0-9]+$ ]] || (( node_major < 22 )); then
    die "Node.js v22+ is required. Found: ${node_version}"
  fi
}

resolve_openclaw() {
  local candidate real_candidate

  candidate="$(command -v openclaw 2>/dev/null || true)"
  if [[ -z "$candidate" ]]; then
    return 1
  fi

  real_candidate="$candidate"
  if command -v realpath >/dev/null 2>&1; then
    real_candidate="$(realpath "$candidate" 2>/dev/null || printf '%s' "$candidate")"
  elif command -v readlink >/dev/null 2>&1; then
    real_candidate="$(readlink -f "$candidate" 2>/dev/null || printf '%s' "$candidate")"
  fi

  case "$real_candidate" in
    /mnt/*)
      return 2
      ;;
  esac

  printf '%s\n' "$real_candidate"
}

install_openclaw() {
  command -v npm >/dev/null 2>&1 || die "npm is required to install OpenClaw when the CLI is missing."

  npm config set prefix "$HOME/.local" >/dev/null
  mkdir -p "$HOME/.local/bin"

  info "OpenClaw CLI not found. Installing the Linux build with npm..."
  npm install -g openclaw@latest --fetch-timeout=600000 --fetch-retries=5 --prefer-online
}

require_linux
require_node_22

if [[ -z "${GEMINI_API_KEY:-}" ]]; then
  die "Set GEMINI_API_KEY before running this script."
fi

export GEMINI_API_KEY
mkdir -p "$WORKSPACE_DIR"

if OPENCLAW_BIN="$(resolve_openclaw)"; then
  :
else
  resolver_status=$?
  case "$resolver_status" in
    1)
      install_openclaw
      hash -r 2>/dev/null || true
      if ! OPENCLAW_BIN="$(resolve_openclaw)"; then
        die "OpenClaw CLI is still unavailable after installation."
      fi
      ;;
    2)
      info "Found a Windows-mounted OpenClaw binary. Installing a native Linux copy instead."
      install_openclaw
      hash -r 2>/dev/null || true
      if ! OPENCLAW_BIN="$(resolve_openclaw)"; then
        die "OpenClaw CLI is still unavailable after installing the native copy."
      fi
      ;;
    *)
      die "Unable to resolve the OpenClaw CLI."
      ;;
  esac
fi

if [[ -z "${OPENCLAW_BIN:-}" ]]; then
  die "OpenClaw CLI is still unavailable after installation."
fi

info "Using OpenClaw at: $OPENCLAW_BIN"
info "Setting up local Gateway state in: $WORKSPACE_DIR"

"$OPENCLAW_BIN" onboard \
  --non-interactive \
  --mode local \
  --flow quickstart \
  --auth-choice gemini-api-key \
  --secret-input-mode ref \
  --accept-risk \
  --gemini-api-key "$GEMINI_API_KEY" \
  --gateway-port "$OPENCLAW_PORT" \
  --gateway-bind loopback \
  --install-daemon \
  --daemon-runtime node \
  --skip-channels \
  --skip-skills \
  --skip-health \
  --skip-ui \
  --workspace "$WORKSPACE_DIR"

"$OPENCLAW_BIN" config set agents.defaults.model.primary "$OPENCLAW_MODEL"
"$OPENCLAW_BIN" config set agents.defaults.workspace "$WORKSPACE_DIR"
"$OPENCLAW_BIN" config set tools.profile coding
"$OPENCLAW_BIN" config set gateway.bind loopback
"$OPENCLAW_BIN" config set gateway.port "$OPENCLAW_PORT"
"$OPENCLAW_BIN" config set gateway.auth.mode token
"$OPENCLAW_BIN" config set tools.web.search.provider gemini
"$OPENCLAW_BIN" config set tools.web.search.gemini.model gemini-2.5-flash

if [[ -d "$HOME/.openclaw" ]]; then
  chmod 700 "$HOME/.openclaw"
fi
if [[ -f "$HOME/.openclaw/openclaw.json" ]]; then
  chmod 600 "$HOME/.openclaw/openclaw.json"
fi
if [[ -f "$HOME/.openclaw/.env" ]]; then
  chmod 600 "$HOME/.openclaw/.env"
fi

mkdir -p "$(dirname "$OPENCLAW_ENV_FILE")"
if [[ -f "$OPENCLAW_ENV_FILE" ]]; then
  grep -v '^GEMINI_API_KEY=' "$OPENCLAW_ENV_FILE" > "$OPENCLAW_ENV_FILE.tmp" || true
  printf 'GEMINI_API_KEY=%s\n' "$GEMINI_API_KEY" >> "$OPENCLAW_ENV_FILE.tmp"
  mv "$OPENCLAW_ENV_FILE.tmp" "$OPENCLAW_ENV_FILE"
else
  printf 'GEMINI_API_KEY=%s\n' "$GEMINI_API_KEY" > "$OPENCLAW_ENV_FILE"
fi
chmod 600 "$OPENCLAW_ENV_FILE"

if [[ -f "$OPENCLAW_SERVICE_FILE" ]]; then
  python3 - "$OPENCLAW_SERVICE_FILE" <<'PY'
from pathlib import Path
import sys

service_file = Path(sys.argv[1])
desired_env_file = "EnvironmentFile=-%h/.openclaw/.env"

lines = service_file.read_text().splitlines()
updated = []
inserted = False

for line in lines:
    if line.startswith("Environment=GEMINI_API_KEY="):
        continue
    if line.startswith("EnvironmentFile="):
        continue
    updated.append(line)
    if not inserted and line.startswith("Environment=PATH="):
        updated.append(desired_env_file)
        inserted = True

if not inserted:
    rebuilt = []
    for line in updated:
        rebuilt.append(line)
        if not inserted and line == "[Service]":
            rebuilt.append(desired_env_file)
            inserted = True
    updated = rebuilt

service_file.write_text("\n".join(updated) + "\n")
PY
fi

"$OPENCLAW_BIN" config get agents.defaults.model.primary >/dev/null
"$OPENCLAW_BIN" config get tools.web.search.provider >/dev/null

info "=== Setup Complete ==="
info "Start the gateway manually when ready: $OPENCLAW_BIN gateway start"
info "Then open the dashboard with: $OPENCLAW_BIN dashboard"
