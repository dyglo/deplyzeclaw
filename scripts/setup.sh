#!/bin/bash
set -e
echo "=== Deplyze Setup ==="
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed. Please install Node.js v22.x."
    exit 1
fi
if ! command -v openclaw &> /dev/null; then
    echo "Installing OpenClaw CLI..."
    npm install -g openclaw
fi
if [ -z "$GEMINI_API_KEY" ]; then
    read -p "Enter your Gemini API Key: " GEMINI_API_KEY
fi
echo "Configuring OpenClaw with Gemini..."
$(npm config get prefix)/bin/openclaw onboard --non-interactive --accept-risk --gemini-api-key "$GEMINI_API_KEY" --install-daemon --skip-channels --skip-ui --skip-health --workspace "$(pwd)/workspace"
$(npm config get prefix)/bin/openclaw security audit --fix
echo "=== Setup Complete! ==="
echo "You can now start the gateway with: $(npm config get prefix)/bin/openclaw gateway run"
echo "Or run in the background: nohup $(npm config get prefix)/bin/openclaw gateway > openclaw.log 2>&1 &"
