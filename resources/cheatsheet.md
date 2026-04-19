# Claude Code Cheatsheet for Analysts — Browser Edition

Keep this open during your first few sessions.

---

## Starting a Session

Open [claude.ai/code](https://claude.ai/code) and connect this course folder. No terminal commands needed.

| Action | How to do it |
|--------|-------------|
| End the session | Type `/exit` |
| Toggle plan mode | Type `/plan` |
| Compress long context | Type `/compact` |
| Start fresh context | Type `/clear` |
| Check token usage | Type `/status` or `/context` |
| See all slash commands | Type `/help` |

---

## Modes

| Mode | How to enter | Use when |
|------|-------------|----------|
| **Default** | Starting state | Most day-to-day work |
| **Plan mode** | Type `/plan` or press Shift+Tab | Starting any non-trivial task — see the approach before changes happen |
| **Accept-edits mode** | Press Shift+Tab (cycle) | You trust the workflow, want fewer approval prompts |
| **Bypass-permissions mode** | Press Shift+Tab (cycle) | Advanced / disposable environments only — avoid in work repos |

> **Browser note:** Shift+Tab cycling works within the browser terminal interface. If a shortcut doesn't respond, use slash commands directly.

---

## Models

Use `/model <name>` to switch mid-session:

| Model | Best for |
|-------|----------|
| `sonnet` | Default. Fast, capable, handles most analyst work. |
| `opus` | Deep reasoning, complex analysis, difficult problems. |
| `opusplan` | **Non-obvious but powerful:** Opus for plan mode, Sonnet for execution. High-quality planning without full Opus cost. |

`/fast` — Opus with accelerated output (~2.5x speed, ~6x cost). Use only when speed is genuinely critical. Check `/insights` after to review spend.

---

## Token Usage and Cost

High-cost patterns to watch for:

| Pattern | Why it's expensive |
|---------|-------------------|
| MCP calls with large responses | Snowflake queries, Confluence pages, Jira lists return a lot of text |
| Pasting large files or logs | Full file stays in context until `/clear` or `/compact` |
| Long sessions without `/compact` | Context grows every turn |
| `opus` or `/fast` for simple questions | Paying Opus pricing for Sonnet-level work |

**Efficiency habits:** Scope MCP queries (`LIMIT 50`, specific columns). Use `/compact` mid-session. Default to `sonnet`. Use `opusplan` for complex planning.

---

## Config Hierarchy (Browser Version)

Claude reads these files at the start of every session, in order:

| File | What it controls |
|------|-----------------|
| `./CLAUDE.md` | Your identity, preferences, and workflow — applies to this project |
| `.claude/rules/*.md` | Domain rules: SQL style, data conventions |
| `.claude/agents/*.md` | Specialist sub-processes Claude can call automatically |
| `.claude/skills/*/SKILL.md` | Slash commands you invoke manually |
| `.mcp.json` | External tool connections (remote HTTP servers only) |

**Key difference from local Claude Code:** In the browser, your config lives inside this project folder — not in `~/.claude/` on your machine. It's version-controlled and available to any session that opens this repo.

---

## Skills vs. Agents

|  | Skills | Agents |
|--|--------|--------|
| **Triggered by** | You, manually (`/skill-name`) | Claude, automatically as a sub-process |
| **Lives in** | `.claude/skills/` | `.claude/agents/` |
| **Best for** | Repeatable workflows you initiate | Specialist standards applied without thinking |

**Build a skill when:** You run the same workflow repeatedly and want consistent output every time. If you find yourself explaining the same process across sessions, it's a skill candidate.

**Build an agent when:** You want a specialist that Claude routes to automatically. The agent has a narrow scope, clear standards, and a defined output format.

**The threshold for either:** If you've explained the same thing to Claude more than three times, encode it.

---

## Course Skills

Two skills ship with this course in `analyst-setup/skills/`. Install them to use in this project:

```
Ask Claude: "Copy the prompt-engineer and learn-teach skills from
analyst-setup/skills/ into .claude/skills/"
```

| Skill | What it does |
|-------|-------------|
| `/prompt-engineer` | Analyzes, diagnoses, and rewrites prompts for any AI model. |
| `/learn:teach [concept]` | Teaches any SQL or data concept step by step. Add `--deep` for more detail. |

---

## MCP in the Browser Version

MCP servers are configured in `.mcp.json` in the project root.

**Only remote HTTP/SSE servers work in the browser** — local stdio servers can't be reached from Anthropic's cloud infrastructure.

```json
{
  "mcpServers": {
    "server-name": {
      "type": "http",
      "url": "https://your-server.example.com"
    }
  }
}
```

**Built-in GitHub tools** are available without any MCP setup — Claude can read issues, PRs, diffs, and post comments.

---

## Using /prompt-engineer for Complex Projects

For large projects — building agents, writing skills, designing n8n workflows — use AI to write and refine your prompts rather than drafting them by hand.

```
/prompt-engineer
[paste your rough prompt or description]
```

Add `explain mode` to learn why each change was made:
```
/prompt-engineer
[prompt] — explain mode
```

### When to use advanced techniques

| Technique | When to use it |
|-----------|---------------|
| **Zero-shot** | Task is clear, output format is standard. Always start here. |
| **One-shot** | The style or structure isn't obvious from instructions alone — add one example to anchor it. |
| **Few-shot / golden examples** | Output consistency is critical; format is complex; the model keeps drifting. Use 2–5 hand-crafted pairs. |
| **Prompt chaining** | Task has distinct phases requiring different reasoning. Split into one prompt per phase. |

**Rule of thumb:** Start zero-shot. Escalate to examples only when output quality is insufficient.

---

## Common Analyst Prompts

**Understand existing SQL**
```
Read [file] and explain what this query does in plain English.
Walk through the logic step by step, flag any potential performance issues,
and note anything I should verify before using the results.
```

**Review a query**
```
Review this SQL for correctness, performance, and style.
Check join logic, date filters, NULL handling, and whether the
aggregation matches my intent. Flag anything to verify before I run it.
[paste query]
```

**Draft a stakeholder summary**
```
Here are my findings: [paste data or key numbers].
Write a 3-sentence summary for a non-technical stakeholder.
Lead with the most important finding. Flag anything that needs a caveat.
```

**Build an agent system prompt**
```
I want to build an agent that [describe what it does].
Draft a focused, opinionated system prompt with a defined output format.
Then run /prompt-engineer on it and suggest any improvements.
```

**Learn a SQL concept**
```
/learn:teach window functions
/learn:teach --deep CTEs
/learn:teach QUALIFY
```

---

## Browser-Specific Reminders

- **Auto-memory doesn't persist** between sessions — your `./CLAUDE.md` is your only persistent context. Update it regularly.
- **After editing your CLAUDE.md**, tell Claude: "Re-read my `./CLAUDE.md`" — it won't pick up changes automatically mid-session.
- **Config is project-scoped** — it applies here and only here. See Exercise 07 to promote it to a global local setup.
- **MCP servers:** Only remote HTTP/SSE servers work in browser sessions. Check [Approved MCPs](https://housecall.atlassian.net/wiki/spaces/AOP/pages/3391291429/Approved+MCPs) before adding any.

---

## Eval Quick Reference

Before trusting Claude's output on anything that matters:

| Check | Why it matters |
|-------|---------------|
| Run the SQL — does it execute? | Syntax errors are immediate |
| Check the row count | Wrong joins inflate or drop rows silently |
| Verify table/column names against schema | Claude can hallucinate names that sound plausible |
| Spot-check one number manually | Math errors are common and silent |
| Check date filters explicitly | Date logic is a frequent source of wrong results |
| Ask: "What would make this wrong?" | Forces critical thinking before accepting the output |

Full checklist: `resources/eval-checklist.md`

---

## Where to Go for More

1. **[Official Claude Code docs](https://docs.claude.com/docs/claude-code)** — canonical, always current
2. **HCP internal pages:**
   - [Approved MCPs](https://housecall.atlassian.net/wiki/spaces/AOP/pages/3391291429/Approved+MCPs)
   - [MCP Security](https://housecall.atlassian.net/wiki/spaces/TE/pages/3492741217/MCP+Security)
   - [Getting Started with Claude Code](https://housecall.atlassian.net/wiki/spaces/PM/pages/3905683625/Getting+Started+with+Claude+Code)
   - [Claude Code Architecture Guide](https://housecall.atlassian.net/wiki/spaces/ENG/pages/3823861787/Claude+Code+Architecture+Guide+Building+Blocks+Rules+Skills+and+Commands)
3. **[Florian's guide](https://cc.bruniaux.com/guide/)** — excellent supplementary reading; not org-approved as an MCP, but useful as a reference

---

## How to Keep This Cheatsheet Useful

Ask Claude to update this file when you learn something new. If Claude answers a question about modes, models, or commands that isn't covered here, say: "Add that to my cheatsheet." The cheatsheet is meant to grow with you.
