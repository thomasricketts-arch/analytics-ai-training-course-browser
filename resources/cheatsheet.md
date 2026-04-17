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
| See all slash commands | Type `/help` |

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

## Browser-Specific Reminders

- **Auto-memory doesn't persist** between sessions — your `./CLAUDE.md` is your only persistent context. Update it regularly.
- **After editing your CLAUDE.md**, tell Claude: "Re-read my `./CLAUDE.md`" — it won't pick up changes automatically mid-session.
- **Config is project-scoped** — it applies here and only here. See Exercise 06 to promote it to a global local setup.
