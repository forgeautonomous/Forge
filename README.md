# 🔥 Forge

### **Forge Living Agents**

> Build autonomous AI agents that launch their own tokens, trade to sustain themselves, and evolve — powered by Claude Code, Conway, and Bankr.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Node.js](https://img.shields.io/badge/Node.js-18%2B-green)](https://nodejs.org)
[![Claude Code](https://img.shields.io/badge/Claude-Code-blueviolet)](https://claude.ai/code)
[![Conway](https://img.shields.io/badge/Conway-Wallet-orange)](https://conway.xyz)
[![Bankr](https://img.shields.io/badge/Bankr-Trading-blue)](https://bankr.xyz)

---

## What is Forge?

Forge is an **autonomous agent builder** that lets anyone spin up self-sustaining AI agents in minutes — no deep blockchain knowledge, no DevOps expertise required.

You write a prompt. Forge builds the agent. The agent launches its own token, earns trading fees, and uses those fees to fund itself indefinitely.

Under the hood, Forge wires together three powerful primitives:

- **[Claude Code](https://claude.ai/code)** — the AI brain. Interprets your prompt, writes the agent's logic, installs skills, and handles reasoning.
- **[Conway](https://conway.xyz)** — the on-chain wallet layer. Manages keys, signs transactions, funds operations, and owns the agent's treasury.
- **[Bankr](https://bankr.xyz)** — the trading and token layer. Launches agent tokens, executes swaps, tracks fees, and routes revenue back to the agent.

Together, these three form a closed loop: **the agent earns what it spends**.

---

## How It Works

```
  Your Prompt
      │
      ▼
  ┌───────┐
  │ FORGE │  ← Claude Code interprets prompt, scaffolds agent logic
  └───────┘
      │
      ▼
  ┌────────┐
  │ DEPLOY │  ← Agent process starts on your VPS or local machine
  └────────┘
      │
      ▼
  ┌──────────┐
  │ TOKENIZE │  ← Bankr launches the agent's token via Conway wallet
  └──────────┘
      │
      ▼
  ┌──────┐
  │ LIVE │  ← Agent runs, trades, earns fees, sustains itself
  └──────┘
```

The whole pipeline — from prompt to live agent — takes under 5 minutes.

---

## Features

- **Natural language agent creation** — describe your agent in plain English, Forge does the rest
- **Automatic token launch** — every agent gets its own token at birth via Bankr
- **Self-sustaining economics** — agents collect trading fees and route them back to their own treasury
- **Skill installation** — agents can install capabilities on the fly (Twitter posting, price feeds, analytics, etc.)
- **Conway wallet integration** — each agent owns and controls its own on-chain wallet
- **Multi-agent orchestration** — agents can spawn sub-agents and delegate tasks
- **Live memory** — agents persist state across sessions using built-in storage
- **Composable logic** — mix and match trading, social, utility, and treasury behaviors
- **Upgrade-in-place** — update an agent's behavior by sending it a new prompt
- **Full audit trail** — every action, transaction, and decision is logged

---

## Supported Agent Types

| Type | Description | Example |
|------|-------------|---------|
| **Trading** | Monitors markets, executes swaps, manages positions | DCA bot, arbitrage agent, momentum trader |
| **Social** | Posts content, replies, grows audiences, manages communities | Twitter agent, Discord moderator, content scheduler |
| **Utility** | Performs recurring tasks, data collection, automation | Price alert bot, news summarizer, API aggregator |
| **Treasury** | Manages funds, diversifies holdings, allocates yield | Yield optimizer, portfolio rebalancer, fee collector |
| **Custom** | Anything else — you define the behavior entirely | Whatever you can describe |

---

## Setup Tutorial

### Requirements

Before you begin, make sure you have:

- A **VPS or server** (Ubuntu 22.04 recommended) with at least 2 vCPU / 4GB RAM / 20GB disk
  - DigitalOcean, Hetzner, Vultr, AWS EC2 — all work fine
  - A local machine works too if you want to run agents locally
- A **funded wallet** for Conway (you'll need a small amount of ETH or SOL depending on your chain)
- A **Bankr account** for token launches and trading
- An **Anthropic API key** or Claude Code access

---

### Step 1 — Provision Your VPS

SSH into your server and update the system:

```bash
ssh root@your-server-ip
apt update && apt upgrade -y
apt install -y git curl build-essential
```

---

### Step 2 — Install Node.js (v18+)

```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs
node --version   # should print v20.x.x
npm --version    # should print 10.x.x
```

---

### Step 3 — Install Claude Code

Claude Code is Anthropic's agentic coding CLI. Install it globally:

```bash
npm install -g @anthropic-ai/claude-code
claude --version
```

Authenticate with your Anthropic API key:

```bash
claude auth login
# Follow the prompts — paste your API key when asked
```

> **Get an API key:** Visit [console.anthropic.com](https://console.anthropic.com) → API Keys → Create Key.

---

### Step 4 — Install Conway

Conway is the wallet and on-chain transaction layer:

```bash
npm install -g @conway/cli
conway --version
```

---

### Step 5 — Install Bankr

Bankr handles token launches and trading execution:

```bash
npm install -g @bankr/cli
bankr --version
```

---

### Step 6 — Install Forge

```bash
npm install -g @forge/cli
forge --version
```

Or clone and run from source:

```bash
git clone https://github.com/your-org/forge.git
cd forge
npm install
npm link
```

---

### Step 7 — Set Up Your Conway Wallet

Create a new Conway wallet for your Forge instance:

```bash
conway wallet create --name forge-main
```

This outputs a wallet address and a recovery phrase. **Save your recovery phrase somewhere safe — it cannot be recovered.**

Fund your Conway wallet with at least:
- **0.05 ETH** (for Ethereum/Base mainnet) or
- **0.5 SOL** (for Solana)

This covers gas for agent deployments, token launches, and initial trades.

Check your balance at any time:

```bash
conway wallet balance --name forge-main
```

---

### Step 8 — Set Up Bankr

Create a Bankr account at [bankr.xyz](https://bankr.xyz) and retrieve your API key from the dashboard.

Connect Bankr to your Conway wallet:

```bash
bankr connect --wallet forge-main
bankr auth --key YOUR_BANKR_API_KEY
```

Verify the connection:

```bash
bankr status
# ✓ Connected | Wallet: forge-main | Ready to launch tokens
```

---

### Step 9 — Configure Your `.env`

In your Forge working directory, create a `.env` file:

```bash
cp .env.example .env
nano .env
```

Fill in the values:

```env
# Anthropic / Claude Code
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxxxxxxxxx

# Conway
CONWAY_WALLET_NAME=forge-main
CONWAY_WALLET_PASSWORD=your-wallet-password
CONWAY_NETWORK=base-mainnet          # or solana-mainnet, ethereum-mainnet

# Bankr
BANKR_API_KEY=your-bankr-api-key
BANKR_DEFAULT_DEX=uniswap-v3         # or raydium, aerodrome

# Forge
FORGE_AGENTS_DIR=./agents
FORGE_LOG_LEVEL=info
FORGE_AUTO_FUND_THRESHOLD=0.01       # ETH — refund agent if balance drops below this

# Optional: Twitter (for social agents)
TWITTER_API_KEY=
TWITTER_API_SECRET=
TWITTER_ACCESS_TOKEN=
TWITTER_ACCESS_SECRET=

# Optional: Telegram
TELEGRAM_BOT_TOKEN=
```

---

### Step 10 — Connect Conway to Claude Code

Tell Claude Code about your Conway wallet so agents can sign transactions:

```bash
forge connect --wallet forge-main --claude-code
```

This registers the Conway wallet as a tool available to Claude Code's agent runtime. You should see:

```
✓ Conway wallet forge-main connected to Claude Code
✓ Bankr trading layer connected
✓ Forge is ready
```

---

### Step 11 — Run Forge

Start the Forge daemon:

```bash
forge start
```

Or run in the foreground with verbose logging:

```bash
forge start --verbose
```

For production deployments, use PM2 to keep Forge running:

```bash
npm install -g pm2
pm2 start forge --name forge
pm2 save
pm2 startup
```

---

### Step 12 — Launch Your First Agent

With Forge running, open a new terminal and launch an agent:

```bash
forge launch "Create a DCA bot that buys $10 of ETH every day and posts a summary tweet"
```

Watch the output as Forge:
1. Sends your prompt to Claude Code
2. Scaffolds the agent logic
3. Creates an agent wallet via Conway
4. Launches the agent's token via Bankr
5. Starts the agent process

Your agent is now live.

---

## Example Prompts

Here are 10 real prompts you can use with `forge launch`:

**1. DCA Trading Agent**
```bash
forge launch "Create a DCA agent that buys $20 of ETH every 24 hours using trading fees earned from my token. Post a daily summary to Twitter."
```

**2. Trend Momentum Trader**
```bash
forge launch "Build a momentum trading agent that monitors the top 20 tokens by 24h volume on Base, buys when RSI is above 60 and trending up, and sells when RSI drops below 45."
```

**3. Arbitrage Hunter**
```bash
forge launch "Create an arbitrage agent that watches price differences between Uniswap and Aerodrome for ETH/USDC and WBTC/USDC pairs, executing trades when spread exceeds 0.3%."
```

**4. Community Treasury Agent**
```bash
forge launch "Build a treasury agent for my DAO. It holds funds in a Conway wallet, diversifies 60% into ETH, 30% stablecoins, 10% into top memecoins by market cap, and rebalances weekly."
```

**5. Crypto News Summarizer**
```bash
forge launch "Create a social agent that fetches the top 5 crypto news stories every 4 hours from major outlets, summarizes them in 3 bullets each, and posts to Twitter with relevant hashtags."
```

**6. Whale Watcher**
```bash
forge launch "Build an agent that monitors on-chain wallets holding over 1000 ETH, alerts me via Telegram whenever they move more than 50 ETH, and publishes a weekly whale activity report."
```

**7. Yield Optimizer**
```bash
forge launch "Create a yield optimization agent that monitors Aave, Compound, and Morpho for the best USDC lending rates, moves my funds to whichever has the highest APY, and checks for better rates every 6 hours."
```

**8. Meme Coin Scout**
```bash
forge launch "Build a scout agent that watches new token launches on Pump.fun, filters for tokens with over 100 unique holders in the first hour, and buys $5 of each qualifying token up to 10 per day."
```

**9. Discord Community Manager**
```bash
forge launch "Create a Discord agent for my NFT project that welcomes new members, answers FAQs from a knowledge base I'll provide, flags suspicious messages for moderation, and posts a daily activity summary."
```

**10. Portfolio Reporter**
```bash
forge launch "Build a reporting agent that tracks my Conway wallet's portfolio daily, calculates PnL, compares performance against ETH and BTC benchmarks, and sends a morning report to my Telegram at 8am UTC."
```

---

## File Structure

```
forge/
├── agents/                    # Live agent directories (auto-created)
│   └── agent-xyz123/
│       ├── agent.json         # Agent config and metadata
│       ├── index.js           # Agent entrypoint (generated by Claude Code)
│       ├── skills/            # Installed skill modules
│       ├── memory/            # Persistent agent memory/state
│       └── logs/              # Agent-specific logs
│
├── src/
│   ├── cli/                   # Forge CLI commands
│   │   ├── launch.js          # forge launch command
│   │   ├── status.js          # forge status command
│   │   ├── stop.js            # forge stop command
│   │   └── connect.js         # forge connect command
│   │
│   ├── core/
│   │   ├── builder.js         # Sends prompts to Claude Code, scaffolds agents
│   │   ├── deployer.js        # Starts agent processes
│   │   ├── monitor.js         # Watches agent health and restarts if needed
│   │   └── registry.js        # Tracks all running agents
│   │
│   ├── integrations/
│   │   ├── claude-code.js     # Claude Code API wrapper
│   │   ├── conway.js          # Conway wallet integration
│   │   └── bankr.js           # Bankr token/trading integration
│   │
│   └── skills/                # Built-in skill library
│       ├── twitter.js
│       ├── telegram.js
│       ├── price-feed.js
│       ├── dex-trading.js
│       └── news-fetch.js
│
├── .env                       # Your environment config (never commit this)
├── .env.example               # Template — safe to commit
├── forge.config.js            # Forge global configuration
├── package.json
└── README.md
```

---

## Cost Estimates

Running Forge has three cost components:

### Claude Code (AI)
| Usage | Estimated Monthly Cost |
|-------|----------------------|
| Light (1–2 agents, low activity) | $5 – $15 |
| Medium (3–5 agents, moderate activity) | $20 – $60 |
| Heavy (10+ agents, frequent reasoning) | $100 – $300+ |

Costs scale with how often your agents reason and act. Trading agents that check prices every minute will cost more than a daily reporting agent.

### VPS / Server
| Plan | Monthly Cost |
|------|-------------|
| Minimal (2 vCPU / 4GB, 1–3 agents) | $10 – $20 |
| Standard (4 vCPU / 8GB, 5–10 agents) | $25 – $50 |
| Large (8+ vCPU / 16GB, 10+ agents) | $60 – $120 |

DigitalOcean and Hetzner offer the best value for self-hosted deployments.

### Gas / On-chain Fees
| Action | Typical Cost (Base mainnet) |
|--------|-----------------------------|
| Agent token launch | ~$0.50 – $2.00 |
| Per trade/swap | ~$0.01 – $0.10 |
| Monthly gas (active trading agent) | $5 – $30 |

**The key insight:** agents are designed to earn their own gas and operational costs through trading fees. A healthy agent running for a few weeks should cover its own expenses.

### Rough Total
A minimal setup with one or two active agents typically costs **$20 – $50/month** out of pocket, with that cost decreasing as agents become self-sustaining.

---

## Troubleshooting

### `forge connect` fails with "wallet not found"

Make sure your Conway wallet was created and the name in `.env` matches exactly:

```bash
conway wallet list
# Verify forge-main appears in the list
```

If it doesn't exist, recreate it:

```bash
conway wallet create --name forge-main
```

---

### Agent launches but immediately stops

Check the agent logs:

```bash
forge logs agent-xyz123 --tail 50
```

Common causes:
- **Insufficient wallet balance** — fund your Conway wallet and retry
- **Bankr connection failed** — run `bankr status` to verify the connection
- **API key invalid** — double-check your `.env` values

---

### `claude: command not found` after installing Claude Code

The npm global bin directory may not be in your PATH:

```bash
export PATH="$PATH:$(npm bin -g)"
# Add this line to your ~/.bashrc or ~/.zshrc to make it permanent
```

---

### Agent token launch fails

Verify Bankr is connected and your wallet has enough balance:

```bash
bankr status
conway wallet balance --name forge-main
```

Token launches require a small initial liquidity deposit. Make sure your wallet holds at least the minimum required for your configured network.

---

### High Claude API costs

If your agent is reasoning too frequently, add a rate limit in the agent's config:

```bash
forge config agent-xyz123 --set reasoning_interval=300  # seconds
```

Or rebuild the agent with explicit frequency constraints in the prompt:

```bash
forge launch "... check prices every 5 minutes (not more frequently) ..."
```

---

### PM2 shows Forge as "errored"

Check the PM2 logs:

```bash
pm2 logs forge --lines 100
```

Most commonly caused by a missing or malformed `.env` file. Validate all required fields are present.

---

### Agent stops responding after several hours

This is usually a memory leak in a custom skill or a connectivity issue. Enable auto-restart:

```bash
forge config agent-xyz123 --set auto_restart=true --set restart_on_idle=3600
```

---

## Contributing

We'd love your help making Forge better.

### Ways to Contribute

- **Report bugs** — open an issue with reproduction steps, logs, and your environment
- **Suggest features** — describe the use case and why existing tools don't cover it
- **Submit skills** — add new capabilities to the `src/skills/` library
- **Improve docs** — fix typos, add examples, clarify setup steps
- **Share agents** — post your forge prompts and agent configs in Discussions

### Development Setup

```bash
git clone https://github.com/your-org/forge.git
cd forge
npm install
cp .env.example .env
# Fill in your .env values
npm run dev
```

### Pull Request Guidelines

1. Fork the repo and create a feature branch from `main`
2. Write tests for new functionality (`npm test`)
3. Keep PRs focused — one feature or fix per PR
4. Update relevant documentation
5. Describe what your PR does and why in the PR description

### Code Style

We use ESLint and Prettier. Run before committing:

```bash
npm run lint
npm run format
```

---

## License

MIT License — Copyright (c) 2024 Forge Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

<p align="center">
  Built with 🔥 by the Forge community<br>
  <a href="https://forge.conway.app">forge.xyz</a> · <a href="https://twitter.com/forgeagents">@forgeagents</a> 
</p>
