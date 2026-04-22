# Exercise 03: Skills and Agents

You've configured Claude to know who you are. Now you're going to see how to extend what it can do — and how to encode your own workflows so they run consistently without re-explaining them every time.

This exercise covers two closely related concepts: **skills** (slash commands you trigger manually) and **agents** (specialist sub-processes Claude can call automatically). By the end, you'll have built your own agent or skill.

---

## Before You Start: How Skills Work in the Browser

In the browser version of Claude Code, skills work differently than in the terminal or IDE. Slash commands like `/prompt-engineer` are not supported — Claude doesn't recognize them as commands here.

Instead, skills function as **reference documents**. When a skill file is in `.claude/skills/`, Claude can read it and follow its process on request. You invoke a skill by asking Claude to run it:

> *"Run the prompt-engineer skill on this prompt: [your prompt]"*

Claude reads the SKILL.md, follows its defined process, and produces output in the skill's format — manually, but consistently.

Ask Claude: *"Copy the prompt-engineer and learn-teach skills from `analyst-setup/skills/` into `.claude/skills/` so they're available in this project."*

This is a meaningful limitation worth noting: the repeatability of skills in the browser depends on you invoking them by name and Claude having their files in context. In the terminal or IDE, `/skill-name` triggers them directly with no extra prompt.

---

## Task 1: Understand the prompt-engineer Skill

Ask Claude: *"What is a skill in Claude Code? How does it differ from just asking a question?"*

Then ask Claude: *"Explain what the prompt-engineer skill does and how it works."*

Now write a rough first-draft prompt for something you actually do — a SQL review request, a data summary, a stakeholder update. Don't polish it. This is the raw material the skill needs.

Then ask:

*"Run the prompt-engineer skill on this prompt: [paste yours here]"*

Watch what it diagnoses and rewrites. Compare the output against what you wrote — what did it change, and what did it keep?

After it runs, ask: *"Run this again in explain mode — I want to understand why each change was made."*

**Why this is a useful demo skill:** The prompt-engineer skill illustrates what all skills have in common — a fixed process (analyze → diagnose → rewrite → explain), a consistent output format, and behavior that doesn't change based on how you phrase the request.

**Concept:** Skills are slash commands — you trigger them explicitly. The difference from just prompting Claude is repeatability and precision: a skill has a defined process, a defined output format, and produces consistent results regardless of how casually you invoke it.

---

## Task 2: Try the learn:teach Skill

Ask Claude: *"Explain what the learn-teach skill does and how it works."*

Then try it — pick any SQL concept you've used but never fully understood: `LAG`, `QUALIFY`, `DATE_TRUNC`, CTEs, `COALESCE`. Ask:

*"Run the learn-teach skill on: window functions"*

The skill walks you through it step by step: definition, minimal example, practical example, common mistakes, and a practice challenge.

For more depth, ask:

*"Run the learn-teach skill on CTEs with the --deep flag"*

**Concept:** Skills don't have to automate a workflow — they can also encode *how you want to be taught*. The format (definition → minimal example → practical example → mistakes → challenge) is consistent every time.

---

## Task 3: Compare Agent Approaches

Ask Claude: *"Read `analyst-setup/agents/sql-reviewer.md` and describe what it does. What problem is it solving? What makes it an agent rather than a skill?"*

Then ask: *"If we wanted to add a second agent for this team — something that complements the sql-reviewer — what would you suggest and why?"*

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
| **Triggered by** | You, manually (`/skill-name` in terminal; "run the X skill" in browser) | Claude, automatically (as a sub-process) |
| **When to use** | Recurring tasks you want to run explicitly | Specialist work Claude routes to internally |
| **Example** | `/prompt-engineer` a rough prompt | SQL reviewer called when reviewing a query |
| **Mental model** | A tool you pick up | A colleague Claude calls in |
| **Lives in (browser)** | `.claude/skills/` | `.claude/agents/` |

A skill is something *you* decide to run. An agent is something *Claude* decides to delegate to.

---

## Task 5: Build Your Own Agent

Before asking Claude anything: write one sentence describing what your agent or skill should do, and one sentence describing what it should never do. Don't overthink it — a rough answer is fine.

Then ask Claude: *"Read `sandbox/templates/starter-agent.md` and walk me through the structure."*

Now decide: should this be an **agent** (Claude delegates automatically) or a **skill** (you trigger by name)? Use what you wrote above and the framework from Task 4 as your guide.

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

## Done? → Move on to Exercise 04: `sandbox/exercises/04-mcp-and-tools.md`

---

*Tasks completed:*
- [ ] Install both skills into `.claude/skills/` (setup step)
- [ ] Understand what a skill is and how prompt-engineer works (browser invocation)
- [ ] Try the learn-teach skill
- [ ] Compare agent approaches and understand why some tools are better as agents vs. skills
- [ ] Understand the difference between skills and agents
- [ ] Decide whether your own tool should be an agent or a skill, and explain why
- [ ] Build your own agent or skill using the starter template
- [ ] Test your tool on real work
- [ ] Understand when an agent is worth building
