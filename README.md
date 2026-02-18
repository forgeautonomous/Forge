# 🔥 Forge

> Autonomous agent builder powered by Claude Code + Conway + Bankr

---

## What is Forge?

Forge adalah AI agent yang bisa:
- **Build & deploy** agent baru dari prompt
- **Launch token** di Base via Bankr
- **Install skills** dari OpenClaw library
- **Self-sustaining** — trading fees bayar hosting sendiri

---

## Real Setup (Tested)

### Requirements
- VPS Ubuntu 22.04+ (min 2 vCPU, 2GB RAM)
- Anthropic API key (console.anthropic.com)
- Bankr account (bankr.bot)
- USDC on Base (Conway wallet)
- ETH on Base (Bankr wallet, for gas)

### Install
```bash
# Node.js 20
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Tools
npm install -g @anthropic-ai/claude-code
npm install -g conway-terminal
npm install -g @bankr/cli
```

### Setup Conway
```bash
npx conway-terminal --provision
cat ~/.conway/config.json  # copy walletAddress, kirim USDC ke sana
```

### Setup Bankr
```bash
bankr login email your@email.com
bankr login email your@email.com --code XXXXXX --accept-terms --key-name "Forge" --read-write
```

### Configure
```bash
mkdir ~/forge && cd ~/forge
# Letakkan CLAUDE.md di sini
cp .env.example .env
nano .env
# Isi: ANTHROPIC_API_KEY, BANKR_API_KEY, BANKR_WALLET_ADDRESS
```

### Connect Conway ke Claude Code
```bash
claude mcp add conway -- npx conway-terminal
claude mcp list  # verify: conway ✓
```

### Run Forge
```bash
cd ~/forge
claude
```

---

## Example Prompts
```
Forge a trading agent called AlphaBot with token $ALPHA on Base

Give AlphaBot the ability to post onchain via Botchan

Add a custom skill to monitor ETH gas prices

Forge a landing page for my project, deploy live with a domain
```

---

## Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Forge's brain — agent instructions |
| `.env` | API keys (never commit this) |
| `.env.example` | Template |
| `start.sh` | Run Forge in background |
| `setup.sh` | One-shot VPS installer |

---

## Cost

| Item | Cost |
|------|------|
| VPS (Hetzner CX22) | ~$4/mo |
| Conway VM per agent | ~$0.10–0.50/hr |
| Token launch gas | ~$1–5 |
| Anthropic API | pay per use |

---

Built with 🔥 Conway + Bankr + Claude Code
