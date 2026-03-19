#!/usr/bin/env bash
set -euo pipefail
umask 077

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT_DIR="$ROOT_DIR/workspace/reports"
REPORT_FILE="$REPORT_DIR/overnight-$(date +%F).md"

mkdir -p "$REPORT_DIR"

section() {
  printf '\n## %s\n\n' "$1" >> "$REPORT_FILE"
}

capture() {
  local title="$1"
  shift

  section "$title"
  printf '```text\n' >> "$REPORT_FILE"

  local output status
  set +e
  output="$("$@" 2>&1)"
  status=$?
  set -e

  printf '%s\n' "$output" >> "$REPORT_FILE"
  printf '```\n' >> "$REPORT_FILE"

  if (( status != 0 )); then
    printf '\n(exit %s)\n' "$status" >> "$REPORT_FILE"
  fi
}

with_timeout() {
  local limit="$1"
  shift

  if command -v timeout >/dev/null 2>&1; then
    timeout "$limit" "$@"
  else
    "$@"
  fi
}

{
  printf '# Overnight Deplyze Check\n\n'
  printf '%s\n' "- Date: $(date '+%F %T %Z')"
  printf '%s\n' "- Repo: $ROOT_DIR"
  printf '\n'
  printf 'This report is read-only. It does not mutate config, channels, or the gateway.\n'
} > "$REPORT_FILE"

cd "$ROOT_DIR"

capture "Git Status" git status --short
capture "Git Branch" git branch --show-current

if command -v openclaw >/dev/null 2>&1; then
  capture "OpenClaw Status" with_timeout 20s openclaw status
  capture "Gateway Status" with_timeout 20s openclaw gateway status
  capture "Channel Probe" with_timeout 20s openclaw channels status --probe
  capture "Config Primary Model" with_timeout 10s openclaw config get agents.defaults.model.primary
  capture "Config Workspace" with_timeout 10s openclaw config get agents.defaults.workspace
  capture "Config Gateway Bind" with_timeout 10s openclaw config get gateway.bind
  capture "Config Gateway Port" with_timeout 10s openclaw config get gateway.port
  capture "Config Tool Profile" with_timeout 10s openclaw config get tools.profile
else
  section "OpenClaw Status"
  printf '```text\nopenclaw CLI not found on PATH.\n```\n' >> "$REPORT_FILE"
fi

cat <<EOF
Overnight check complete.
Report: $REPORT_FILE
EOF
