# Exercise 02: Build Your CLAUDE.md

You've seen Claude Code navigate files and summarize data. Now you're going to configure it to actually know who you are and how you work.

`CLAUDE.md` is the most high-leverage file in your Claude Code setup. It's where you tell Claude your role, your stack, your preferences, and your standards. Everything you'd otherwise have to re-explain in every session — you write it once here.

This exercise walks you through understanding an existing config, building your own, and testing whether it works.

---

## Task 1: Understand What CLAUDE.md Does

Ask Claude: *"Read the project's `CLAUDE.md` file and explain what it does in plain English. What kind of information does it contain, and why would that be useful?"*

After Claude answers, ask a follow-up: *"If I didn't have a CLAUDE.md, what would Claude Code not know about me that it knows now?"*

**Concept:** CLAUDE.md is loaded automatically at the start of every session. It's not a conversation — it's a persistent briefing. Claude reads it before you type your first message. Think of it as the difference between briefing a contractor once vs. explaining your standards from scratch every time you call them.

In the browser version, there are two levels of config:
- **Project-level** (`./CLAUDE.md`) — your preferences for this project. **This is what you're building in this exercise** — and it works fully in the browser.
- **User-level** (`~/.claude/CLAUDE.md`) — personal preferences that apply everywhere, across all projects. This requires the Desktop app, VS Code extension, or Terminal. See Exercise 06 if you want to set that up later.

---

## Task 2: Study a Real Analyst Config

Ask Claude: *"Read `analyst-setup/CLAUDE.md` and walk me through each section. What is the purpose of each one? What would be missing if any section were removed?"*

Pay attention to:
- How the "About Me" section is written — it's short, factual, and role-specific
- How "Workflow Preferences" is a list of behaviors, not just descriptions
- How "Things to Never Do" creates a hard boundary, not a soft suggestion

**Note:** The `analyst-setup/CLAUDE.md` is an example of a *local* config — it's written for someone using the Desktop app or Terminal. The concepts are identical; the only difference is file location. When you build yours, it'll live at `./CLAUDE.md` in this project instead of `~/.claude/CLAUDE.md`.

**Concept:** A good CLAUDE.md isn't a wall of text — it's a structured briefing. The sections Claude reads first (About Me, Workflow Preferences) shape every interaction.

---

## Task 3: Study Rules Files

Ask Claude: *"Read the files in `analyst-setup/rules/` and explain what each one does. How are rules files different from the main CLAUDE.md?"*

Then ask: *"If I wanted to add a new SQL style preference, would I put it in CLAUDE.md or a rules file? Why?"*

**Concept:** Rules files are domain-specific instruction files. They keep your main CLAUDE.md clean and focused. Think of CLAUDE.md as your general preferences and rules files as your style guides — one per domain (SQL, n8n, Python, etc.).

In the browser version, rules files live in `.claude/rules/` inside this project:

| File | Purpose |
|------|---------|
| `./CLAUDE.md` | Who you are, how you work, what you want |
| `.claude/rules/sql-style.md` | SQL formatting and Snowflake conventions |
| `.claude/rules/data-conventions.md` | Metric definitions and validation rules |

You can have as many rules files as you need. Claude reads all of them automatically at the start of every session.

---

## Task 4: Create Your Own CLAUDE.md

Ask Claude: *"Read `sandbox/templates/starter-claude.md` and show me the template."*

Then: *"Help me fill it out for my role. I'm an analyst at Housecall Pro. Walk me through each section and ask me what to put in it."*

Work through it section by section. Be honest — if you're not sure what to put somewhere, write a placeholder. You can update it later. The point is to have something that reflects your actual role, not a generic template.

When you're done, ask Claude to write it to `./CLAUDE.md` in the project root (it may already exist from when you opened this course — ask Claude to update it with your personal context as a new section at the bottom, or replace the existing content).

**Concept:** This is the most important thing you'll do in this course. A CLAUDE.md that reflects your actual context will make every future interaction more useful. A generic one won't.

**Browser note:** Your CLAUDE.md lives at `./CLAUDE.md` — in this project folder. It's scoped to this project. When you open this project in a future browser session, Claude will read it automatically.

---

## Task 5: Create Your First Rules File

Ask Claude: *"Read `sandbox/templates/starter-rules.md` and show me the template."*

Then: *"Help me create a SQL style rules file at `.claude/rules/sql-style.md`. Walk me through the sections and fill in anything you already know about my stack (Snowflake, dbt, Omni)."*

At minimum, make sure your rules file covers:
- SQL keyword casing (`SELECT`, `FROM`, `WHERE` in UPPERCASE)
- CTE preference over nested subqueries
- One clause per line for complex queries
- How you want NULL handling called out
- Any Snowflake-specific functions you use regularly

**Concept:** Rules files are where you encode domain expertise. You've been writing SQL for a while — you already have preferences. A rules file just makes them explicit so Claude applies them consistently without being asked.

---

## Task 6: Test Your Config

Ask Claude: *"Please re-read my `./CLAUDE.md` and `.claude/rules/` folder. Then tell me: what do you know about my preferences and how I work?"*

Check:
- Does it reflect what you wrote in your CLAUDE.md?
- Does it mention your SQL style rules?
- Did anything get lost or misread?

If something's wrong, ask Claude to read the file back to you and identify the issue. Edit and fix it.

**Browser note:** Unlike the local version, you don't need to restart a session to test your config — just ask Claude to re-read the file. The next session will also load it automatically.

**Concept:** Your config is only useful if it's being read. Testing it is how you confirm the feedback loop is actually closed.

---

## Task 7: The Settings File

Ask Claude: *"What is the Claude Code settings file? What can I configure there that I can't configure in CLAUDE.md?"*

Then ask: *"What does `defaultMode: plan` do and why might an analyst want to use it?"*

In the browser version, project settings live at `.claude/settings.json`. A useful starting point:

```json
{
  "defaultMode": "plan"
}
```

This puts Claude Code into "plan first" mode — it proposes what it's going to do before doing it. For analysts who want to stay in control of what gets written or changed, this is a safe default.

Ask Claude to create `.claude/settings.json` with this setting if you want it.

**Concept:** CLAUDE.md is about context. Settings.json is about behavior. You need both. Start with `defaultMode: plan` and relax it once you trust the tool.

---

## Eval Moment

Your CLAUDE.md reflects who you are today. But your role, stack, and preferences will change.

Ask yourself:
- What would trigger you to update your CLAUDE.md? (New tool, new team, new project type?)
- Is there anything in the template you skipped because you weren't sure? Go back and fill it in.
- Three months from now, what will probably be wrong in what you wrote today?

The best CLAUDE.md setups are treated like living documentation — updated after notable sessions, not left to go stale.

---

## Done? → Move on to Exercise 03: `sandbox/exercises/03-skills-and-agents.md`

---

*Tasks completed:*
- [ ] Understand what CLAUDE.md does and why it matters
- [ ] Study the analyst-setup CLAUDE.md section by section
- [ ] Understand rules files vs. CLAUDE.md
- [ ] Create your own CLAUDE.md at `./CLAUDE.md`
- [ ] Create your first rules file at `.claude/rules/sql-style.md`
- [ ] Test your config by asking Claude to re-read it
- [ ] Understand the settings.json file and defaultMode: plan
- [ ] Eval moment: when should you update your config?
