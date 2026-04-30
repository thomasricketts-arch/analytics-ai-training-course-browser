# Claude Code for Analysts — Browser Version

**A hands-on course for analytics teams using Claude Code in the browser.**

Learn Claude Code by using Claude Code. No slides required — this course teaches itself.

> **Using the Desktop app, VS Code extension, or Terminal instead?** There's a local version of this course at **[github.com/thomasricketts-arch/analytics-ai-training-course](https://github.com/thomasricketts-arch/analytics-ai-training-course)**. It covers user-level config (`~/.claude/`), auto-memory persistence, and local MCP server setup that the browser version doesn't support.

---

## What's Different in the Browser Version

This course teaches Claude Code as you'll use it in **claude.ai/code** — no installation required. The key difference from the local version:

| Feature | Browser (this course) | Local (other course) |
|---|---|---|
| Where config lives | `.claude/` inside this project | `~/.claude/` on your machine |
| CLAUDE.md | `./CLAUDE.md` — part of this repo | `~/.claude/CLAUDE.md` — global |
| Rules and agents | `.claude/rules/`, `.claude/agents/` | `~/.claude/rules/`, `~/.claude/agents/` |
| MCP servers | `.mcp.json` in the repo (remote only) | `claude mcp add` CLI command |
| Auto-memory | Doesn't persist between sessions | Persists across sessions |
| Built-in GitHub tools | Available | Available |
| Installation required | No | Yes |

**What this means in practice:** Everything you build in this course lives inside this project folder. Your config is version-controlled and works for anyone who opens this project in claude.ai/code. If you later switch to the Desktop app or VS Code, Exercise 06 shows you how to promote your config to a full personal setup.

---

## Getting Started

Setup takes about 5 minutes. Two steps:

1. **Get a Claude account** — Sign up at **[claude.ai](https://claude.ai)** if you don't have one.
2. **Open this course in claude.ai/code** — Go to **[claude.ai/code](https://claude.ai/code)**, connect this GitHub repo, and start a session in the course folder.

Once you're in a session, type:

```
What exercise should I start with?
```

Claude will read the course context and guide you from there.

> **Stuck on any step?** Once you have a Claude Code session open in the course folder, ask it directly: *"I'm having trouble getting set up — can you help me?"* Claude can walk you through it.

---

## How This Course Works

1. Open this course folder in a claude.ai/code session
2. Claude becomes your teacher — it reads the `CLAUDE.md` in this folder and knows the full course context
3. Work through exercises in `sandbox/exercises/` — ask Claude for help when you're stuck
4. Study `analyst-setup/` to see what a mature analyst config looks like (as a preview of what you'd have locally)
5. Build your own config inside `.claude/` as you go

**The meta insight:** You're learning Claude Code *inside* Claude Code. The tool you're learning is also your teacher.

**Important:** This course uses **Claude Code** on the web — a separate product from the Claude.ai chat interface. Unlike the chat, Claude Code can read, write, and search files directly in your project.

---

## Module 1: Getting Started

### 1.1 What Is Claude Code?

Claude Code is a tool that puts an AI assistant directly alongside your project files. Unlike Claude.ai in chat mode, Claude Code:

- **Reads and writes files** — it can see your entire project
- **Runs searches** — it finds files by name, searches file contents, navigates folders
- **Learns your preferences** — via config files you control
- **Connects to external tools** — via MCP servers you define

Think of it as a very capable analyst assistant that has direct access to your project folder — and whose behavior you can tune over time.

### 1.2 How the Browser Version Works

In claude.ai/code, Claude Code runs on Anthropic's infrastructure rather than your local machine. What this means:

- You don't install anything — Claude Code is already running
- Your project files are accessed via a connected GitHub repo
- Config files live inside the project (not in a hidden folder on your machine)
- Each session starts fresh — Claude reads your `./CLAUDE.md` at the start of every session

**The tradeoff:** You lose persistent auto-memory and user-level config, but you gain zero-friction setup and a config that's automatically shared with anyone who opens this project.

### 1.3 Your First Session

Once you have a session open in this course folder, try:
- "What files are in this project?"
- "Read the file `sandbox/exercises/01-hello-claude.md`"
- "What exercise should I start with?"

### 1.4 Key Concepts

- **Session**: A conversation with Claude Code — starts when you open claude.ai/code in this project
- **Context**: What Claude knows about your project (reads `./CLAUDE.md` automatically + any files you reference)
- **Tools**: Actions Claude can take (`Read`, `Write`, `Edit`, `Grep`, `Glob`)
- **Project config**: Your preferences and rules live in `.claude/` inside this folder

**Exercise:** Work through `sandbox/exercises/01-hello-claude.md`

---

## Module 2: Working with Claude — Modes and Models

### 2.1 Modes

Claude Code has four modes that control how much it acts on its own vs. pausing for your approval:

| Mode | How to enter | Use when |
|------|-------------|----------|
| **Default** | Starting state | Most day-to-day work |
| **Plan mode** | Mode dropdown (browser) · `/plan` or Shift+Tab (CLI/desktop) | Starting any non-trivial task — see the approach before changes happen |
| **Accept-edits mode** | Mode dropdown (browser) · Shift+Tab (CLI/desktop) | You trust the workflow and want fewer approval prompts |
| **Bypass-permissions mode** | CLI/desktop only | Advanced use only — disposable environments. Avoid in work repos. |

**Plan mode is the most useful one to know.** Claude proposes its full approach before making any changes. You can redirect, push back, or approve. Nothing happens until you say go.

> **Browser note:** In cloud sessions on claude.ai/code, switch modes using the **mode dropdown** next to the prompt box. `/plan` and Shift+Tab are CLI and desktop app features — they aren't available in browser sessions.

### 2.2 Models

Use `/model <name>` to switch the model mid-session:

| Model | Best for |
|-------|----------|
| `sonnet` | Default. Fast, capable, handles most analyst work. |
| `opus` | Deep reasoning, complex analysis, difficult problems. |
| `opusplan` | **Non-obvious but powerful:** Uses Opus while in plan mode, Sonnet for execution. Gets you high-quality planning without paying Opus cost on every file edit. |

Start with `sonnet`. Switch to `opus` when a task genuinely needs deeper reasoning. Use `opusplan` when you want better planning quality without the full Opus price tag.

### 2.3 `/fast` Mode — Use Sparingly

`/fast` runs Opus with accelerated output — roughly 2.5x faster, but at about 6x the cost.

- **Use when:** Time is critical and the task needs Opus-level reasoning — live debugging during an incident, demo prep with a hard deadline.
- **Don't use for:** Routine questions, exploratory sessions, or anything that can wait.
- **After a `/fast` session:** Check `/status` or `/insights` to see what was spent.

### 2.4 Token Usage and Cost Awareness

Some patterns burn through tokens (and budget) much faster than others:

| High-cost pattern | Why |
|------------------|-----|
| MCP tool calls with large responses | Snowflake queries, Confluence pages, and Jira issue lists return a lot of text. A `SELECT *` can dump thousands of rows into context. |
| Pasting large files or logs | The whole file enters context and stays until `/clear` or `/compact`. |
| Very long sessions without `/compact` | Context grows every turn. Old messages stay in the window until compacted. |
| Using `opus` or `/fast` for simple questions | Paying Opus pricing for work Sonnet handles fine. |

**Efficiency habits:**
- Scope MCP queries — add `LIMIT 50`, request specific columns, narrow date ranges.
- Use `/compact` mid-session when context feels heavy. Use `/clear` to start fully fresh.
- Default to `sonnet`. Use `opusplan` for complex planning. Reserve `opus` for genuinely hard problems.
- Save `/fast` for when speed actually matters.

**Try it:** Use the mode dropdown to switch to Plan mode before your next non-trivial request. Then try `/model opusplan` and ask Claude what model it's using and why.

---

## Module 3: Teaching Claude Who You Are

### 3.1 The Config Hierarchy

In the browser version, Claude reads configuration in layers:

```
./CLAUDE.md                   ← Your project-level context (this project only)
./.claude/rules/*.md          ← Domain rules (SQL style, data conventions, etc.)
./.claude/settings.json       ← Project settings (permissions, hooks)
```

**Key insight:** In the browser version, this project IS your config home. Everything lives here and loads automatically at the start of every session.

> If you later switch to the Desktop app, VS Code, or Terminal, you can promote these files to `~/.claude/` for global use across all projects. See Exercise 06.

### 3.2 CLAUDE.md — Your AI's Instruction Manual

This is the most important file. It tells Claude:
- Who you are and what you work on
- How you like to work (workflow preferences)
- What tools are available (Snowflake, Omni, dbt, etc.)
- What rules to follow (SQL style, data conventions)
- What to never do (guardrails)

In the browser version, your CLAUDE.md lives at `./CLAUDE.md` in the project root. Claude reads it automatically at the start of every session — even though you didn't install anything.

See `analyst-setup/CLAUDE.md` for a real analyst example (adapted for local use, but the structure is the same).

### 3.3 Rules Files

Rules live in `.claude/rules/` and cover specific domains:

```
.claude/
  rules/
    sql-style.md       ← SQL formatting, CTEs vs. subqueries, Snowflake patterns
    data-conventions.md ← Metric definitions, validation rules, SOT references
```

Rules files keep your CLAUDE.md clean and focused. Each rule file adds domain-specific expertise without cluttering the main config.

### 3.4 When to Update Your CLAUDE.md

| Trigger | Example |
|---------|---------|
| You corrected Claude's approach | "Told Claude to always use CTEs — should add that as a rule" |
| You discovered a new workflow | "Realized I should always run /plan before complex changes" |
| You finished a project | "The Data Checker project taught me to validate metric names" |
| You keep repeating yourself | Same preference in 3+ sessions = add it to the config |

In the browser version, updates to `./CLAUDE.md` take effect when Claude next reads the file — tell Claude "read my CLAUDE.md again" after making changes.

### 3.5 Building Your Own Config

Start with the templates in `sandbox/templates/`:
1. `starter-claude.md` — Skeleton CLAUDE.md with analyst-focused placeholders
2. `starter-rules.md` — Example SQL and data style rules
3. `starter-agent.md` — Example agent definition

**Exercise:** Work through `sandbox/exercises/02-build-your-claudemd.md`

---

## Module 4: Agents, Skills & Your Own Tools

### 4.1 Agents vs Skills — Know When to Use Each

Before building anything, understand the difference:

| | Skills | Agents |
|--|--------|--------|
| **Triggered by** | You, manually (`/skill-name`) | Claude, automatically (as a sub-process) |
| **Best for** | Repeatable workflows you want deliberate control over | Autonomous QA gates, second opinions, specialist delegation |
| **Mental model** | A tool you pick up | A colleague Claude calls in |
| **Lives in (browser)** | `.claude/skills/` | `.claude/agents/` |

**Use a skill when:** you have a workflow you want to trigger on demand — formatting output, explaining a concept, polishing a prompt.

**Use an agent when:** you want Claude to delegate to a specialist automatically — reviewing SQL before it runs, validating data output, domain-specific lookups.

### 4.2 What Ships With This Course

One agent ships as a working reference:

| Agent | What it does |
|-------|-------------|
| `sql-reviewer` | Reviews queries for correctness, performance, and style |

Two skills ship and are ready to use:

| Skill | What it does |
|-------|-------------|
| `/prompt-engineer` | Rewrites and improves a rough prompt |
| `/learn:teach` | Walks through any SQL concept step by step |

**Example ideas — agents and skills you could build** (not shipped; you'll build your own in Exercise 03):

| Name | Pattern | Why |
|------|---------|-----|
| `data-validator` | Agent | Runs independently after a query returns — checks row counts, null rates, and anomalies without user prompting |
| `narrative-writer` | Skill | User-triggered: you decide when to turn data into a stakeholder summary |

### 4.3 How Agents Work

An agent file has two parts:

```markdown
---
name: sql-reviewer
description: Reviews SQL queries for correctness, performance, and style
tools: ["Read", "Grep", "Glob"]
model: sonnet
---

You are an expert SQL reviewer specializing in Snowflake...
```

The YAML frontmatter configures the agent. The markdown body is its system prompt.

In the browser version, agents live in `.claude/agents/` inside the project — not in `~/.claude/agents/`. They work identically; only the location differs.

### 4.4 Skills

Skills are slash commands — user-triggered shortcuts that expand into full prompts. In the browser version, they live in `.claude/skills/` inside the project.

**Skills vs Agents:**
- **Skills** = you trigger them (`/prompt-engineer`)
- **Agents** = Claude calls them automatically based on the task type

### 4.5 Building Your Own Agent

The best agents are:
- **Focused**: One job, done well
- **Opinionated**: Clear standards, not vague instructions
- **Grounded in your actual work**: The metric definitions, table names, and conventions your team actually uses

See `sandbox/templates/starter-agent.md` for a template.

**Exercise:** Work through `sandbox/exercises/03-skills-and-agents.md`

---

## Module 5: MCP & External Tools

### 5.1 What Is MCP?

**Model Context Protocol (MCP)** is how Claude Code connects to external systems — databases, APIs, and more. Think of it as "USB ports for AI": a standard way to plug in tools.

```
Claude Code ←→ MCP Server ←→ External System
                              (Snowflake, Omni, Slack, etc.)
```

### 5.2 How MCP Works in the Browser

In the browser version, MCP servers are configured in a file called `.mcp.json` in the project root. Claude reads this file at session start and connects to the servers listed.

**Important:** Only **remote MCP servers** (HTTP/SSE) work in browser sessions. Local servers that run as processes on your machine don't work in cloud sessions.

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://my-mcp-server.example.com"
    }
  }
}
```

### 5.3 Built-in GitHub Tools

The browser version includes **built-in tools for GitHub** with no setup required. Claude can:
- Read issues and pull requests
- Fetch diffs and file contents
- Post comments
- List branches and PRs

No MCP server needed for GitHub work.

### 5.4 HCP Policy — Check Before You Add

Before adding any MCP server to `.mcp.json`, check the [Approved MCPs page](https://housecall.atlassian.net/wiki/spaces/AOP/pages/3391291429/Approved+MCPs) in Confluence. Unapproved servers haven't been evaluated for security or data handling — don't add them to a work project.

**Key risks:** tool poisoning (injected instructions), prompt injection (data manipulating Claude), and over-scoped credentials. Read the [MCP Security page](https://housecall.atlassian.net/wiki/spaces/TE/pages/3492741217/MCP+Security) for details.

**Browser limit:** Only remote HTTP/SSE servers work in browser sessions. Stdio servers (Playwright, GitLab, Jellyfish) require local Claude Code.

### 5.5 Approved Analyst Connections

| MCP Server | Connects to | Browser? | Notes |
|-----------|------------|---------|-------|
| Snowflake | Data warehouse | ✗ local only | HCP-internal via DataEng — not a GitHub install |
| Atlassian | Jira + Confluence | ✓ remote HTTP | On the approved list |
| Slack | Slack API | ✓ remote HTTP | Post results, read channels |
| GitHub | Code repos | ✓ built-in | No config needed |

> **Snowflake MCP** is built on Snowflake's Managed MCP Server and requires local Claude Code. Request access through DataEng. Read [Querying Data with AI — Omni vs Snowflake](https://housecall.atlassian.net/wiki/spaces/IOT/pages/4053925893/Querying+Data+with+AI+Omni+vs+Snowflake) before using — default to Omni for most queries.

**Exercise:** Work through `sandbox/exercises/04-mcp-and-tools.md`

---

## Module 6: Eval Mindset & The Coaching Loop

### 6.1 Why Eval Matters

Claude Code is good at: reading and explaining code, drafting SQL, navigating files, generating first drafts.

Claude Code struggles with: knowing what's anomalous in your specific data, distinguishing plausible table names from real ones, catching its own math errors.

**The rule:** Claude produces drafts. You verify them.

See `resources/eval-checklist.md` for a full checklist.

### 6.2 The Eval Habit

Build verification into your workflow — not as a separate step, but as a reflex:
- SQL output → run it and check the row count
- Summary → spot-check one number against the source
- Analysis → ask "what would make this wrong?"
- Agent output → apply the eval checklist

The goal isn't distrust — it's calibrated trust. Know what Claude is good at and where to verify.

### 6.3 The Coaching Loop

The most powerful use of Claude Code is the feedback loop:

```
1. Do real work with Claude Code
2. Notice what works and what doesn't
3. Update your ./CLAUDE.md and .claude/rules/
4. Claude Code gets better at helping you
5. Repeat
```

This is the meta-skill. Everything else is just setup.

**Note for browser users:** Auto-memory doesn't persist between sessions in the browser. This makes a strong `./CLAUDE.md` *more* important, not less — it's the only thing that carries your preferences from session to session. Update it regularly.

To run a self-audit, ask Claude:

```
"Read my ./CLAUDE.md and my rules files.
 What's working well? What's missing?
 What would you add based on our recent sessions?"
```

Claude can suggest improvements to its own instructions. Run this periodically — especially after finishing a project or learning something new.

### 6.4 What Great Looks Like

After completing this course, you should be able to:
- Start a Claude Code session and navigate any project
- Explain what CLAUDE.md, rules files, and agents do
- Build and customize your own configuration
- Use Claude Code on real analyst work (SQL review, data validation, stakeholder summaries)
- Verify Claude Code output using the eval checklist
- Teach a teammate the basics

**Exercise:** Work through `sandbox/exercises/05-eval-and-meta.md`

---

## Module 7: Promoting to Local (Optional)

If you switch to the Desktop app, VS Code extension, or Terminal later, you can promote the config you built here to a personal, global setup.

**Exercise:** Work through `sandbox/exercises/06-promoting-to-local.md`

---

## Graduation Checklist

### Must Do (Required)
- [ ] Complete Exercise 01
- [ ] Create your own `./CLAUDE.md` in this project
- [ ] Create at least one rules file in `.claude/rules/`
- [ ] Use Claude Code on a real work task
- [ ] Apply the eval checklist to at least one piece of Claude output

### Should Do (Recommended)
- [ ] Complete all 5 core exercises
- [ ] Create a custom agent in `.claude/agents/`
- [ ] Study `analyst-setup/` and understand each file
- [ ] Set up a `.mcp.json` with at least one remote MCP server
- [ ] Teach a teammate what CLAUDE.md does

### Stretch Goals
- [ ] Build an agent specific to your team's workflow
- [ ] Write a rules file that encodes a lesson from a real project
- [ ] Complete Exercise 06 to promote your config to a local setup
- [ ] Run a self-audit on your config and update it based on the results

---

## Project Structure

```
AI Training Course — Browser/
  CLAUDE.md                              # Makes Claude your teacher in this folder
  README.md                              # This file — the full course guide
  .claude/                               # Your project-scoped config (build this during the course)
    rules/                               # SQL style, data conventions
    agents/                              # Custom analyst agents
    skills/                              # Custom slash commands
  sandbox/
    exercises/
      01-hello-claude.md                 # Basic interaction and file navigation
      02-build-your-claudemd.md          # Building your project config
      03-skills-and-agents.md            # Analyst agents and skills
      04-mcp-and-tools.md                # MCP via .mcp.json and GitHub tools
      05-eval-and-meta.md                # Eval mindset and the coaching loop
      06-promoting-to-local.md           # Optional: promote config to ~/.claude/
    sample-data/
      sample_query.sql                   # Example Snowflake query for exercises
      sample_output.csv                  # Example data output for exercises
    templates/
      starter-claude.md                  # Analyst CLAUDE.md template
      starter-rules.md                   # SQL and data style rules template
      starter-agent.md                   # Agent template
  analyst-setup/                         # Reference: what a mature local config looks like
    CLAUDE.md                            # Example config (local-style, for reference)
    rules/                               # Example rules files
    agents/                              # Example agent definitions
  resources/
    eval-checklist.md                    # QA checklist for verifying Claude output
    cheatsheet.md                        # Quick command reference (browser edition)
```

---

## FAQ

**Q: I'm scared I'll break something.**
A: Claude Code asks permission before dangerous actions. When in doubt, use `/plan` mode — Claude will plan its approach and ask for your approval before doing anything.

**Q: How is this different from the Claude.ai chat interface?**
A: Claude Code can read, write, and search your actual project files. It's not a chatbot — it has direct access to your work. That's what makes it useful for analysis tasks.

**Q: What if Claude gives me wrong SQL?**
A: Always run it and check the output. Use the eval checklist in `resources/eval-checklist.md`. Verify, don't trust blindly.

**Q: My config doesn't seem to be loading.**
A: In the browser version, your `./CLAUDE.md` and `.claude/` folder must be in the project root (the folder Claude Code opened). Ask Claude: "Read my CLAUDE.md" to confirm it's finding the file.

**Q: Can I use the config I build here on other projects?**
A: In the browser version, your config is project-scoped — it only applies when you're in this project. To use it everywhere, complete Exercise 06 to promote it to a local `~/.claude/` setup on your machine.

**Q: What's the right pace?**
A: One exercise per week is sustainable. Consistency beats intensity.
