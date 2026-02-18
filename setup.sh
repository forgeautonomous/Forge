#!/bin/bash
# ============================================================
# setup.sh — Forge VPS Setup Script
# Run this once on a fresh Ubuntu 22.04 / 24.04 VPS
# Usage: bash setup.sh
# ============================================================

set -e  # exit on error

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "  ███████╗ ██████╗ ██████╗  ██████╗ ███████╗"
echo "  ██╔════╝██╔═══██╗██╔══██╗██╔════╝ ██╔════╝"
echo "  █████╗  ██║   ██║██████╔╝██║  ███╗█████╗  "
echo "  ██╔══╝  ██║   ██║██╔══██╗██║   ██║██╔══╝  "
echo "  ██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗"
echo "  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝"
echo -e "${NC}"
echo -e "${GREEN}Forge VPS Setup — Agent + Utility Builder${NC}"
echo "================================================"
echo ""

# ── 1. System update ──────────────────────────────────────
echo -e "${YELLOW}[1/8] Updating system packages...${NC}"
apt-get update -qq && apt-get upgrade -y -qq
apt-get install -y -qq curl wget git build-essential jq unzip screen

# ── 2. Node.js 20 ─────────────────────────────────────────
echo -e "${YELLOW}[2/8] Installing Node.js 20...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs
echo -e "${GREEN}✓ Node $(node -v) / npm $(npm -v)${NC}"

# ── 3. Claude Code CLI ────────────────────────────────────
echo -e "${YELLOW}[3/8] Installing Claude Code CLI...${NC}"
npm install -g @anthropic-ai/claude-code
echo -e "${GREEN}✓ Claude Code $(claude --version 2>/dev/null || echo 'installed')${NC}"

# ── 4. Conway Terminal ────────────────────────────────────
echo -e "${YELLOW}[4/8] Installing Conway Terminal...${NC}"
npm install -g conway-terminal
echo -e "${GREEN}✓ Conway Terminal installed${NC}"

# ── 5. Bankr CLI ──────────────────────────────────────────
echo -e "${YELLOW}[5/8] Installing Bankr CLI...${NC}"
npm install -g @bankr/cli
echo -e "${GREEN}✓ Bankr CLI $(bankr --version 2>/dev/null || echo 'installed')${NC}"

# ── 6. Create Forge directory ─────────────────────────────
echo -e "${YELLOW}[6/8] Creating Forge workspace...${NC}"
mkdir -p /root/forge
cp "$(dirname "$0")/../forge/CLAUDE.md" /root/forge/CLAUDE.md 2>/dev/null || true
echo -e "${GREEN}✓ /root/forge ready${NC}"

# ── 7. Create .env template ───────────────────────────────
echo -e "${YELLOW}[7/8] Creating environment template...${NC}"
cat > /root/forge/.env.example << 'EOF'
# ── Anthropic ──────────────────────────────────────────────
ANTHROPIC_API_KEY=sk-ant-...

# ── Conway ─────────────────────────────────────────────────
# Auto-generated at ~/.conway/config.json after running: npx conway-terminal
CONWAY_API_KEY=

# ── Bankr ──────────────────────────────────────────────────
# Get from bankr.bot/api or: bankr login
BANKR_API_KEY=bk_...

# ── Optional: Bankr SDK (x402 payments, no API key needed) ─
# Only needed if using @bankr/sdk directly
PRIVATE_KEY=0x...
WALLET_ADDRESS=0x...
EOF
echo -e "${GREEN}✓ .env.example created at /root/forge/.env.example${NC}"

# ── 8. Create start script ────────────────────────────────
echo -e "${YELLOW}[8/8] Creating start script...${NC}"
cat > /root/forge/start.sh << 'EOF'
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
EOF
chmod +x /root/forge/start.sh
echo -e "${GREEN}✓ start.sh created${NC}"

# ── Done ──────────────────────────────────────────────────
echo ""
echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}✅ Setup complete!${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo "NEXT STEPS:"
echo ""
echo "  1. Initialize Conway wallet:"
echo -e "     ${BLUE}npx conway-terminal${NC}"
echo "     → Note your wallet address"
echo ""
echo "  2. Setup Bankr:"
echo -e "     ${BLUE}bankr login email your@email.com${NC}"
echo -e "     ${BLUE}bankr login email your@email.com --code XXXXXX --accept-terms --key-name 'Forge' --read-write${NC}"
echo ""
echo "  3. Configure API keys:"
echo -e "     ${BLUE}cp /root/forge/.env.example /root/forge/.env${NC}"
echo -e "     ${BLUE}nano /root/forge/.env${NC}"
echo ""
echo "  4. Fund your wallets:"
echo "     • Conway wallet: USDC on Base (infra costs)"
echo "     • Bankr wallet:  ETH on Base (gas for token launch)"
echo ""
echo "  5. Start Forge:"
echo -e "     ${BLUE}cd /root/forge && claude${NC}"
echo "     or"
echo -e "     ${BLUE}bash /root/forge/start.sh${NC}"
echo ""
