#!/bin/bash
# Start Forge agent in a persistent screen session
cd /root/forge

# Load env if exists
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
fi

# Check required env vars
if [ -z "$ANTHROPIC_API_KEY" ]; then
  echo "ERROR: ANTHROPIC_API_KEY not set in /root/forge/.env"
  exit 1
fi

# Kill existing session if running
screen -S forge -X quit 2>/dev/null || true

# Start new session
screen -S forge -dm bash -c "claude; exec bash"
echo ""
echo "✓ Forge is running in screen session 'forge'"
echo "  Attach:  screen -r forge"
echo "  Detach:  Ctrl+A then D"
echo "  Kill:    screen -S forge -X quit"
