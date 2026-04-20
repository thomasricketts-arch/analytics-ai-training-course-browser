# Exercise 03: Skills and Agents

You've configured Claude to know who you are. Now you're going to see how to extend what it can do — and how to encode your own workflows so they run consistently without re-explaining them every time.

This exercise covers two closely related concepts: **skills** (slash commands you trigger manually) and **agents** (specialist sub-processes Claude can call automatically). By the end, you'll have built your own agent or skill.

---

## Before You Start: Install the Skills

In the browser version, skills live in `.claude/skills/` inside this project — not on your machine. Copy them in now so the slash commands work during this exercise.

Ask Claude: *"Copy the prompt-engineer and learn-teach skills from `analyst-setup/skills/` into `.claude/skills/` so they're available in this project."*

Once copied, `/prompt-engineer` and `/learn:teach` will be available for the rest of this session.

---

## Task 1: Understand the prompt-engineer Skill

Ask Claude: *"What is a skill in Claude Code? How does it differ from just asking a question?"*

Then ask Claude: *"Read `analyst-setup/skills/prompt-engineer/SKILL.md` and explain what this skill does and how it works."*

Now try it yourself. Write a rough first-draft prompt for something you actually do — a SQL review request, a data summary, a stakeholder update. Don't polish it. Then invoke:

```
/prompt-engineer
```

Paste your rough prompt when asked. Watch what it diagnoses and rewrites.

After it runs, ask: *"Run this again in explain mode — I want to understand why each change was made."*

**Why this is a useful demo skill:** The prompt-engineer skill illustrates what all skills have in common — a fixed process (analyze → diagnose → rewrite → explain), a consistent output format, and behavior that doesn't change based on how you phrase the request.

**Concept:** Skills are slash commands — you trigger them explicitly. The difference from just prompting Claude is repeatability and precision: a skill has a defined process, a defined output format, and produces consistent results regardless of how casually you invoke it.

---

## Task 2: Try the learn:teach Skill

Ask Claude: *"Read `analyst-setup/skills/learn-teach/SKILL.md` and explain what this skill does and how it works."*

Then try it:

```
/learn:teach window functions
```

Or pick any SQL concept you've used but never fully understood — `LAG`, `QUALIFY`, `DATE_TRUNC`, CTEs, `COALESCE`. The skill walks you through it step by step: definition, minimal example, practical example, common mistakes, and a practice challenge.

Try the `--deep` flag if you want more detail:

```
/learn:teach --deep CTEs
```

If you completed the setup step at the top of this exercise, both skills are already in `.claude/skills/` and available for this session.

**Concept:** Skills don't have to automate a workflow — they can also encode *how you want to be taught*. The format (definition → minimal example → practical example → mistakes → challenge) is consistent every time.

---

## Task 3: Compare Agent Approaches

Ask Claude: *"Look at the agents in `analyst-setup/agents/` and describe what each one does. What problem is each one solving? How are their approaches different?"*

If the agents directory is empty, ask Claude: *"Describe what a `sql-reviewer` agent and a `data-validator` agent would look like for an analytics team. What would each one's system prompt focus on? What tools would each need?"*

Think about:
- What does a focused agent look like vs. a general-purpose one?
- Why would you want an agent that only does SQL review, rather than just asking Claude to review SQL?
- Why is `narrative-writer` a better skill than an agent — and why is `data-validator` a better agent than a skill?

**Concept:** Agents are specialists. A good agent has a narrow scope, a consistent format, and an opinionated point of view. "Review my SQL" is a prompt. A SQL reviewer agent knows exactly what to look for, how to structure its output, and what counts as passing vs. failing.

---

## Task 4: Understand Skills vs. Agents

Ask Claude: *"What's the difference between a skill and an agent in Claude Code? Can you give me an example of when I'd want each one?"*

The key distinction:

| | Skills | Agents |
|--|--------|--------|
| **Triggered by** | You, manually (`/skill-name`) | Claude, automatically (as a sub-process) |
| **When to use** | Recurring tasks you want to run explicitly | Specialist work Claude routes to internally |
| **Example** | `/prompt-engineer` a rough prompt | SQL reviewer called when reviewing a query |
| **Mental model** | A tool you pick up | A colleague Claude calls in |
| **Lives in (browser)** | `.claude/skills/` | `.claude/agents/` |

A skill is something *you* decide to run. An agent is something *Claude* decides to delegate to.

---

## Task 5: Build Your Own Agent

Ask Claude: *"Read `sandbox/templates/starter-agent.md` and walk me through the structure."*

Before picking, decide: should this be an **agent** (Claude delegates automatically) or a **skill** (you trigger with `/slash-name`)? Use the framework from Module 4.1 as your guide.

Some ideas to spark your thinking:

**Better as agents** (autonomous, quality-gate logic):
- **SQL reviewer** — reviews Snowflake SQL for correctness, performance, and style *(this one ships as a reference — read `analyst-setup/agents/sql-reviewer.md`)*
- **Data validator** — checks that output meets expected row counts, null rates, and value ranges
- **Metric validator** — checks that a reported metric matches the query that produced it

**Better as skills** (user-triggered, deliberate output):
- **Narrative writer** — translates data into a written summary with appropriate caveats (`/narrative-writer`)
- **Report formatter** — takes raw numbers and drafts a structured stakeholder report (`/report-format`)
- **Query explainer** — explains a query in plain English for a non-technical audience (`/explain-query`)

Ask Claude: *"Help me build a [your choice] agent or skill using the template. Walk me through customizing the system prompt for my role at HCP."*

When you have a draft, ask Claude to save it to `.claude/agents/[name].md` (agent) or `.claude/skills/[name]/SKILL.md` (skill).

**Concept:** A good agent is focused and opinionated. The system prompt should read like a detailed brief to a skilled contractor: here's your scope, here's your output format, here's what you should flag, here's what you should never do. Vague system prompts produce vague output.

---

## Task 6: Test Your Agent

Run your agent on something real — a SQL query you've written recently, a summary you need to draft, a metric you've been working with.

After it produces output, ask yourself:
- Did the output require corrections?
- Did it follow the format you specified in the system prompt?
- Did it flag anything you would have caught yourself?
- Did it miss anything you would have caught?

If the output needed significant edits, that's a signal about the instructions — not a flaw in the tool. Go back to the system prompt and tighten it.

**Concept:** The first run of a new agent is almost always a calibration exercise. You're testing your own instructions as much as you're testing Claude. The corrections you make reveal what you implicitly knew but didn't write down.

---

## Task 7: When Is an Agent Worth Building?

Ask Claude: *"When is it worth building a custom agent vs. just prompting Claude directly? What's the threshold?"*

A useful heuristic: if you find yourself explaining the same thing to Claude more than three times — the same context, the same format, the same standards — that's a candidate for an agent. The moment you think "I always want it to do X when reviewing Y," write an agent.

What's *not* worth encoding as an agent:
- One-off tasks you'll never do again
- Tasks where the context changes completely each time
- Tasks where you want to give Claude fresh instructions

**Concept:** Agents reduce the tax on repetitive work. They're not magic — they're just instructions that persist. But the right set of agents for your workflow can meaningfully reduce the mental overhead of working with Claude Code.

---

## Eval Moment

After running your agent and seeing its output:
- What corrections did it need? (This reveals gaps in your instructions.)
- Were there things it got right that you didn't expect? (This reveals assumptions you'd made.)
- If a colleague ran this agent on the same input, would they get consistent output?

The quality of your agent is a mirror of how clearly you can articulate your own standards. If the output is inconsistent, the instructions are ambiguous.

---

## Done? → Move on to Exercise 04: `sandbox/exercises/04-mcp-and-tools.md`

---

*Tasks completed:*
- [ ] Install both skills into `.claude/skills/` (setup step)
- [ ] Understand what a skill is and how /prompt-engineer works
- [ ] Try the /learn:teach skill
- [ ] Compare agent approaches and understand why some tools are better as agents vs. skills
- [ ] Understand the difference between skills and agents
- [ ] Decide whether your own tool should be an agent or a skill, and explain why
- [ ] Build your own agent or skill using the starter template
- [ ] Test your tool on real work
- [ ] Understand when an agent is worth building
- [ ] Eval moment: what did the output reveal about your instructions?
