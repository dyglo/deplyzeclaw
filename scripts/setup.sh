#!/bin/bash
set -e
echo "=== Deplyze Setup ==="
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed. Please install Node.js v22.x."
    exit 1
fi
OPENCLAW_BIN=$(command -v openclaw 2>/dev/null | grep -v "/mn"t"/")
if [ -z "$OPENCLAW_BIN" ]; then
    echo "Native Linux OpenClaw not found. Installing now..."
    npm config set prefix /usr/local 2>/dev/null || npm config set prefix ~/.npm-global
    npm install -g openclaw
    OPENCLAW_BIN=$(command -v openclaw 2>/dev/null | grep -v "/mn"t"/")
    if [ -z "$OPENCLAW_BIN" ]; then
        OPENCLAW_BIN=$(npm config get prefix)/bin/openclaw
    fi
fi
if [ -z "$OPENCLAW_BIN" ] || [[ "$OPENCLAW_BIN" == /mn"t"/* ]]; then
    echo "Error: Could not find a native Linux OpenClaw binary."
    echo "WSL is still pointing to your Windows installation."
    echo "Please run: npm install -g openclaw"
    exit 1
fi
echo "Using native OpenClaw at: $OPENCLAW_BIN"
if [ -z "$GEMINI_API_KEY" ]; then
    read -p "Enter your Gemini API Key: " GEMINI_API_KEY
fi
echo "Configuring OpenClaw with Gemini..."
"$OPENCLAW_BIN" onboard --non-interactive --accept-risk --gemini-api-key "$GEMINI_API_KEY" --install-daemon --skip-channels --skip-ui --skip-health --workspace "$(pwd)/workspace"
"$OPENCLAW_BIN" security audit --fix
echo "=== Setup Complete! ==="
echo "You can now start the gateway with: $OPENCLAW_BIN gateway run"
echo "Or run in the background: nohup $OPENCLAW_BIN gateway > openclaw.log 2>&1 &"
