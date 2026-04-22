# Exercise 06: Promoting Your Config to Local (Optional)

If you're switching to the **Desktop app**, **VS Code extension**, or **Terminal**, this exercise shows you how to take the config you built in the browser course and turn it into a full personal setup that works across all your projects.

You don't need to do this to finish the course. Skip it if you're staying in the browser.

---

## What You've Built vs. What Local Adds

In this browser course, you built:

```
./CLAUDE.md                 ← Project-level context
.claude/rules/              ← Domain rules (SQL style, data conventions)
.claude/agents/             ← Custom analyst agents
.claude/skills/             ← Custom slash commands
.claude/settings.json       ← Project settings
.mcp.json                   ← External tool connections
```

In the local version, these same concepts exist at the user level — applying across **all** your projects, not just this one:

```
~/.claude/CLAUDE.md         ← Your personal identity and preferences
~/.claude/rules/            ← Domain rules (available everywhere)
~/.claude/agents/           ← Agents (available everywhere)
~/.claude/skills/           ← Skills (available everywhere)
~/.claude/settings.json     ← Global settings
```

What you gain by going local (Desktop app, VS Code extension, or terminal only — none of these apply in the browser):
- **Global config** — your preferences apply to every project automatically, not just this one
- **Auto-memory** — Claude remembers things you've told it across sessions (doesn't persist in browser)
- **Local MCP servers** — you can run servers as processes on your machine (browser supports remote/HTTP only)
- **Full settings control** — hooks, additional permission modes

---

## Task 1: Install Claude Code Locally

If you haven't already, install Claude Code. Ask Claude: *"How do I install Claude Code locally? I want to use it in the terminal or Desktop app."*

Or go directly to [claude.ai/code](https://claude.ai/code) to download the Desktop app.

For the Terminal/CLI version:
```bash
curl -fsSL https://claude.ai/install.sh | bash
claude --version
```

---

## Task 2: Promote Your CLAUDE.md

Your `./CLAUDE.md` is already well-developed. You can use it as the starting point for your global config.

Ask Claude: *"Read my `./CLAUDE.md`. Help me adapt it for use as `~/.claude/CLAUDE.md` — a global config that will apply to all my projects, not just this one. What should I generalize? What should I keep?"*

Things to generalize:
- References to "this project" → update to be project-agnostic
- Project-specific tool configurations → move to a project-level CLAUDE.md in each future project

When you're ready, copy it:

```bash
cp ./CLAUDE.md ~/.claude/CLAUDE.md
```

Or ask Claude to create `~/.claude/CLAUDE.md` with the adapted content.

---

## Task 3: Promote Your Rules Files

Your `.claude/rules/` files are already in good shape. Promoting them is straightforward.

```bash
mkdir -p ~/.claude/rules
cp .claude/rules/*.md ~/.claude/rules/
```

Or ask Claude: *"Copy my `.claude/rules/` files to `~/.claude/rules/`. Do I need to change anything about the content for them to work globally?"*

Once in `~/.claude/rules/`, these rules apply to every project you open in Claude Code.

---

## Task 4: Promote Your Agents

Same pattern for agents:

```bash
mkdir -p ~/.claude/agents
cp .claude/agents/*.md ~/.claude/agents/
```

Ask Claude: *"Are there any references in my agent files that are specific to this project? If so, let's update them to work globally."*

---

## Task 5: Promote Your Skills

```bash
cp -r .claude/skills/* ~/.claude/skills/
```

Once promoted, your custom slash commands are available in every Claude Code session.

---

## Task 6: Explore What's New in the Local Version

Now that you have local Claude Code running, there are a few things worth exploring that the browser version doesn't support:

**Auto-memory:**
Ask Claude: *"What is auto-memory in Claude Code? How does it work and where does it store things?"*

Auto-memory lets Claude save things you tell it across sessions — preferences, project context, session learnings. It lives in `~/.claude/projects/*/memory/`. In the browser version, this doesn't persist. Locally, it does.

**Local MCP servers:**
Ask Claude: *"What's the difference between a remote MCP server (like in .mcp.json) and a local stdio MCP server? What can I do with local ones that I couldn't in the browser?"*

Local MCP servers run as processes on your machine. They can connect to local databases, use your local credentials, and access things that aren't publicly accessible over HTTP.

**Settings and hooks:**
Ask Claude: *"What are Claude Code hooks? Give me an example of how an analyst might use them."*

---

## Task 7: See What a Mature Local Setup Looks Like

Study `analyst-setup/` — the example config included in this course. This is what a full local setup looks like:

- `analyst-setup/CLAUDE.md` — A real-world analyst identity and preference file
- `analyst-setup/rules/` — Domain-specific rules for SQL, data conventions, and tools
- `analyst-setup/agents/` — Analyst-focused agents

Ask Claude: *"Compare my `~/.claude/CLAUDE.md` (which I just created) with `analyst-setup/CLAUDE.md`. What's in the example that I haven't included? Is any of it relevant to my role?"*

---

## Promotion Complete

You now have a full local Claude Code setup. Your config is:

- **Global** — applies to every project you open
- **Persistent** — auto-memory carries your context across sessions
- **Expandable** — you can add local MCP servers for Snowflake, dbt, Slack, and more

The local version of this course (**[github.com/thomasricketts-arch/analytics-ai-training-course](https://github.com/thomasricketts-arch/analytics-ai-training-course)**) covers these local-specific features in more depth — particularly MCP server setup using the `claude mcp add` workflow, terminal basics, and the full settings file. If you want to go deeper, open that course in Claude Code.

---

*Tasks completed:*
- [ ] Install Claude Code locally (Desktop app, VS Code, or Terminal)
- [ ] Promote `./CLAUDE.md` to `~/.claude/CLAUDE.md` (adapted for global use)
- [ ] Promote `.claude/rules/` to `~/.claude/rules/`
- [ ] Promote `.claude/agents/` to `~/.claude/agents/`
- [ ] Promote `.claude/skills/` to `~/.claude/skills/`
- [ ] Explore auto-memory, local MCP, and hooks
- [ ] Compare your config with `analyst-setup/` for gaps
