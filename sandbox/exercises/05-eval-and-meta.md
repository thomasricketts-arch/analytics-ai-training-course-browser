# Exercise 05: Eval Mindset and the Coaching Loop

You've built your config, explored agents and skills, and connected external tools. This final core exercise pulls everything together around a question that matters more than any individual feature: *when do you trust Claude, and how do you get better at knowing the difference?*

This is the coaching loop — the feedback cycle between you, your config, and Claude's output. The analysts who get the most value from Claude Code are the ones who maintain this loop deliberately.

---

## Task 1: Self-Audit Your Config

Ask Claude: *"Read my `./CLAUDE.md` and my `.claude/rules/` directory. Audit them honestly — what's working, what's incomplete, and what's missing that would make you more useful to me?"*

Then follow up with: *"What would you add to my config based on what you've learned about how I work during this course?"*

Take notes on what it says. Some of it will be generic. Some of it might be genuinely useful. Anything that resonates — add it to your config now.

**Browser note:** In the browser version, auto-memory doesn't persist between sessions. This makes your `./CLAUDE.md` more important, not less — it's the only thing that carries your context from one session to the next. A gap in your CLAUDE.md is a gap that resets every time you start a new session.

**Concept:** Your CLAUDE.md accumulates value over time, but only if you update it. The self-audit is a way to surface gaps you couldn't see when you were writing it from scratch.

---

## Task 2: The Coaching Loop on a Real Task

Do actual analyst work inside this Claude Code session. Options:
- Ask Claude to review a SQL query you've written recently
- Ask it to draft a short narrative summary of a dataset you know well
- Ask it to explain a query to a non-technical stakeholder

After the output, ask Claude: *"What went well in that? What's something you produced that I should verify before using? What did you assume that I should confirm?"*

Then ask yourself:
- What would I have caught in that output without Claude?
- What did Claude catch that I would have missed?
- What should I add to my `./CLAUDE.md` based on this session?

Write down anything worth adding. The coaching loop closes when you actually update your config — not just when you notice a gap.

**Concept:** The coaching loop has four steps: (1) give Claude a task, (2) evaluate the output critically, (3) identify what would have made the output better, (4) encode that into your config. Most people stop at step 2. The ones who close the loop at step 4 build an increasingly calibrated tool over time.

---

## Task 3: Eval in Practice

Ask Claude: *"Read `resources/eval-checklist.md` and walk me through it."*

Now go back to the task from Exercise 01 — or pick a similar task: reading `sandbox/sample-data/sample_query.sql` and summarizing `sandbox/sample-data/sample_output.csv`.

This time, apply the eval checklist systematically. Work through every checkbox. Don't skip the ones that seem obvious.

After going through it, ask: *"How many items on this checklist did I not check when I first did this in Exercise 01?"*

The answer is usually most of them. That's not a failure — it's a calibration. The checklist exists because the instinct to accept plausible-sounding output without verifying it is strong, and it has a cost.

**Concept:** Eval is a habit, not a feature. The checklist is a scaffold for building that habit until it becomes automatic.

---

## Task 4: Design a Dream Agent

Think about your team's most repetitive, high-friction analytical task.

Ask Claude: *"Based on what you know about my role, what would be the most valuable agent I could build for my workflow? Describe what it would do, what inputs it would need, and what output it would produce."*

When you have a concept, use `/prompt-engineer` to write the system prompt. Give it a rough description of what the agent should do, and ask it to produce a focused, opinionated system prompt with a defined output format.

Then write a draft design:
- The problem it solves
- The inputs it needs
- The output format
- The rules it should follow
- What "good" output looks like vs. "needs revision"

Ask Claude to save this to `sandbox/my-dream-agent.md`.

**Concept:** Good ideas deserve documentation. A draft design that you revisit in a month is more useful than a vague idea you forget.

---

## Task 5: Your Next 3 Moves

Ask Claude: *"Based on everything we've covered in this course — my config, the agents I've looked at, the tools I've used — what are the 3 most impactful next steps for my workflow? Be specific. Not 'learn more about MCP' — tell me what to actually do next week."*

Push back on any generic answers. Ask for specifics: which exact file to create, which exact workflow to try, which exact task to apply Claude Code to first.

Write your 3 moves somewhere you'll actually see them.

**Concept:** Learning a tool doesn't compound without application. The exercises gave you the concepts. The next 3 moves are where it becomes a workflow.

---

## Task 6: Update Your CLAUDE.md

Ask Claude: *"Read my current `./CLAUDE.md`. Based on this course, what's now stale or incomplete? Help me update it."*

Things that commonly need updating after a course like this:
- Skills you now have available
- Agents you've built and what they do
- MCP servers you've connected (or plan to connect)
- Preferences that turned out to be wrong or incomplete
- New rules you want applied to your SQL or narrative writing

Don't rush this. A well-maintained `./CLAUDE.md` after this course is more valuable than any individual exercise.

**Browser reminder:** This `./CLAUDE.md` is your primary persistence mechanism — auto-memory doesn't carry over between sessions. Treat it like a living document.

**Concept:** This is the most important step in the course. Everything else is setup. Your CLAUDE.md is the artifact that makes Claude Code permanently more useful to you — but only if it reflects reality.

---

## Task 7: Pay It Forward

Take 5 minutes and explain to a colleague — in plain English — what CLAUDE.md is and why it matters. No jargon. No hype.

A useful framing: *"You know how you'd brief a new analyst on how we work before they start a project? CLAUDE.md is that briefing, but for Claude. You write it once and it applies to every session."*

---

## Final Reflection

The feedback loop never ends. Your CLAUDE.md a year from now should look completely different from today's. That's not a problem. That's the point.

The analysts who get the most value from Claude Code aren't the ones who learned the most features. They're the ones who stayed honest about when Claude got it wrong and updated their config accordingly.

---

## Course Complete (Core Modules)

You've covered:
- Basic Claude Code interaction and tool use (Ex 01)
- Building and testing a project-level CLAUDE.md config (Ex 02)
- Skills, agents, and encoding your own workflows (Ex 03)
- MCP, external tools, and security judgment (Ex 04)
- Eval mindset and the coaching loop (Ex 05)

**Optional next step:** Work through `sandbox/exercises/06-promoting-to-local.md` if you ever want to use the Desktop app, VS Code extension, or Terminal — that exercise shows you how to promote your project config to a full personal setup.

---

*Tasks completed:*
- [ ] Self-audit your CLAUDE.md and rules files
- [ ] Run the coaching loop on a real analyst task
- [ ] Apply the full eval checklist to sample data analysis
- [ ] Design a dream agent for your team's most repetitive task
- [ ] Get your next 3 moves from Claude and write them down
- [ ] Update your CLAUDE.md based on this course
- [ ] Explain CLAUDE.md to a colleague in 5 minutes
