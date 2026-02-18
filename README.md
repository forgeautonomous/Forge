cat > /root/forge/README.md << 'EOF'
# 🔥 Forge

> Autonomous agent builder powered by Claude Code + Conway + Bankr

---

## What is Forge?

Forge is an AI agent that can:
- **Build & deploy** new agents from a single prompt
- **Launch tokens** on Base via Bankr
- **Install skills** from the OpenClaw library
- **Self-sustaining** — trading fees pay for hosting automatically

---

## How It Works
```
You type a prompt
      ↓
Forge generates agent code
      ↓
Forge deploys to Conway Cloud VM
      ↓
Forge launches token on Base via Bankr
      ↓
Trading fees → agent wallet → pays Conway VM
      ↓
Agent installs skills, gains new capabilities ✅
```

---

## Requirements

- VPS Ubuntu 22.04+ (min 2 vCPU, 2GB RAM)
- Anthropic API key — console.anthropic.com
- Bankr account — bankr.bot
- USDC on Base (for Conway VM costs)
- ETH on Base (for Bankr gas fees)

---

## Setup

### 1. Install dependencies
```bash
# Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# CLI tools
npm install -g @anthropic-ai/claude-code
npm install -g conway-terminal
npm install -g @bankr/cli
```

### 2. Setup Conway wallet
```bash
npx conway-terminal --provision
cat ~/.conway/config.json  # copy walletAddress
# Send USDC on Base to that address
```

### 3. Setup Bankr
```bash
# Step 1 — send OTP
bankr login email your@email.com

# Step 2 — verify and create API key
bankr login email your@email.com \
  --code XXXXXX \
  --accept-terms \
  --key-name "Forge" \
  --read-write

# Verify
bankr whoami
```

### 4. Configure environment
```bash
mkdir ~/forge && cd ~/forge
cp .env.example .env
nano .env
```
```env
ANTHROPIC_API_KEY=sk-ant-...
BANKR_API_KEY=bk_...
BANKR_WALLET_ADDRESS=0x...
```

### 5. Connect Conway to Claude Code
```bash
claude mcp add conway -- npx conway-terminal
claude mcp list  # should show: conway ✓
```

### 6. Place CLAUDE.md

Download `CLAUDE.md` from this repo and place it in `~/forge/`.

### 7. Run Forge
```bash
cd ~/forge
claude
```

---

## Example Prompts
```
Forge a trading agent called AlphaBot with token $ALPHA on Base

Give AlphaBot the ability to post onchain via Botchan

Add a custom skill to AlphaBot that monitors ETH gas prices

Forge a landing page for my project and deploy it live with a domain

Forge a treasury agent called VaultBot that manages fee distribution
```

---

## File Structure
```
~/forge/
├── CLAUDE.md       ← Forge's brain (agent instructions)
├── .env            ← Your API keys (never commit this)
├── .env.example    ← Template (safe to commit)
├── start.sh        ← Run Forge in background screen session
└── setup.sh        ← One-shot VPS installer
```

---

## Agent Lifecycle
```
BORN      → Deployed on Conway Cloud VM
TOKENIZED → Token live on Base via Bankr
SKILLED   → OpenClaw skills installed
FUNDED    → Fee income covers hosting costs
EVOLVING  → New skills added on demand
```

---

## Available Skills (Bankr OpenClaw)

| Skill | Capability |
|-------|------------|
| `bankr` | Trading, swaps, DeFi, portfolio |
| `botchan` | Onchain messaging on Base |
| `erc-8004` | Agent identity NFT |
| `polymarket` | Prediction market bets |
| `ens-primary-name` | ENS reverse resolution |
| Custom | Forge generates from your description |

Full library: github.com/BankrBot/openclaw-skills

---

## Cost Estimate

| Item | Cost |
|------|------|
| VPS (Hetzner CX22) | ~$4/mo |
| Conway VM per agent | ~$0.10–0.50/hr |
| Conway domain | ~$1–15/yr |
| Token launch gas | ~$1–5 |
| Anthropic API | pay per token |

---

## Troubleshooting

**Conway not in `claude mcp list`**
```bash
claude mcp remove conway 2>/dev/null
claude mcp add conway -- npx conway-terminal
```

**Bankr insufficient ETH for gas**
```bash
bankr prompt "What is my ETH balance on Base?"
# Send more ETH to your Bankr wallet
```

**Credit balance too low**
- Top up at platform.claude.com/settings/billing

---

## References

- [Conway Docs](https://docs.conway.tech)
- [Bankr Docs](https://docs.bankr.bot)
- [OpenClaw Skills](https://github.com/BankrBot/openclaw-skills)
- [Claude Code](https://docs.anthropic.com/claude-code)
- [Base Network](https://base.org)

---

Built with 🔥 by [forgeautonomous](https://github.com/forgeautonomous)
EOF
