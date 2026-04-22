# Exercise 01: Hello, Claude Code

Welcome. This is your first exercise. You're going to learn the basics of Claude Code by doing real tasks — the kind of things you might actually do at work.

**How to use this file:**
1. Open claude.ai/code with this course folder connected
2. Tell Claude: "Read the file `sandbox/exercises/01-hello-claude.md`"
3. Work through each task below — ask Claude for help if you get stuck

**The meta insight:** You're learning Claude Code *inside* Claude Code. The tool you're learning is also your teacher.

---

## Task 1: Orient Yourself

Ask Claude these questions:
- "What directory am I currently in?"
- "What files are in this project?"
- "What's in the `sandbox` folder?"

These teach you how Claude navigates your file system. It uses tools like `Glob` (find files by name) and `Grep` (search file contents) to see your project.

**Concept:** Claude Code can see your entire project — not just what you paste into it.

---

## Task 2: Read a File

Ask Claude: *"Read the file `sandbox/sample-data/sample_query.sql` and explain what it does in plain English."*

Then ask Claude: *"Show me the raw contents of `sandbox/sample-data/sample_query.sql`."* Read through it yourself. Is Claude's explanation accurate? What did it get right? What did it miss or simplify?

This is different from asking Claude in chat mode — Claude Code is reading the *actual file in your project*, not a copy you pasted in.

**Concept:** The `Read` tool lets Claude see any file. Always verify the explanation against the file itself.

---

## Task 3: Analyze Some Data

A colleague asks you to take a quick look at some business data they've pulled. Ask Claude:

*"Read `sandbox/sample-data/sample_output.csv` and summarize what's going on — what stands out, what looks healthy, and what would you want to dig into further?"*

After Claude responds, push back or follow up on something:
- If Claude flagged something that surprised you, ask it to explain
- If you disagree with its read, say so and see how it responds
- Ask a follow-up question about any number that doesn't look right

**Concept:** The real workflow isn't one prompt — it's ask, react, push back, refine. Claude Code is a thinking partner, not a vending machine.

---

## Task 4: Search the Project

Ask Claude: *"Find all files in this project that contain the word 'eval' or 'verify'."*

Then ask: *"Find all `.md` files in the `resources/` folder and list what each one covers."*

**Concept:** `Grep` searches file *contents*. `Glob` searches file *names and paths*. These two tools together let Claude navigate large projects quickly.

---

## Task 5: Have Claude Write Something

Ask Claude: *"Create a file called `sandbox/my-analysis-notes.md`. In it, write a brief summary of what the sample query does, what the output shows, and one thing you'd want to investigate further."*

After Claude creates it, click **"Created a file"** in Claude's response, then the file name to view it. Or ask: *"Read `sandbox/my-analysis-notes.md` back to me."*

Use this checklist — it applies to any document Claude generates:
- Is the summary accurate, or does it contain anything you'd need to verify?
- Is "one thing to investigate" a real insight, or a generic filler answer?
- Would you trust this without reading the source files yourself?
- What would Claude have gotten wrong if you hadn't checked?
- Would you edit this before sharing with a stakeholder?

**Concept:** Claude can draft content quickly, but the output is a starting point — not a final product. Your judgment about what's accurate and what's useful is irreplaceable.

---

## Task 6: Edit a File

Before asking Claude: jot down one or two open questions *you* have about the data — anything that felt unclear or worth digging into. They don't need to be polished.

Then ask Claude: *"Edit `sandbox/my-analysis-notes.md` to add a section at the bottom called 'Open Questions' with three bullet points based on the data."*

Compare what it added against what you wrote. Did it land on the same questions? Different ones? Better or worse?

**Concept:** The `Edit` tool modifies existing files without rewriting them. It's precise — Claude changes only what you asked it to change.

---

## Task 7: Reflect on What Claude Used

Ask Claude: *"What tools did you use to complete these tasks? Explain each one in one sentence."*

The core toolkit:
| Tool | What it does |
|------|-------------|
| `Read` | See the contents of any file |
| `Write` | Create a new file |
| `Edit` | Modify an existing file |
| `Glob` | Find files by name or pattern |
| `Grep` | Search file contents for a keyword |

These five tools are the foundation of almost everything Claude Code does.

If any tool name was unfamiliar, ask Claude to explain it: *"What does the Glob tool actually do, and when would you use it over Grep?"*

---

---

## Bonus: Explore Modes and Models

Before moving on, try a quick orientation to the two features from Module 2.

**Modes:**

Type `/plan` or press Shift+Tab to enter plan mode. Then ask Claude:

*"What mode are you currently in, and what does that mode let you do?"*

Then ask Claude to plan something simple — like "read all the files in sandbox/sample-data/ and summarize them." Notice that it proposes the plan first, then waits for your approval.

**Models:**

Type `/model opusplan` and ask Claude: *"What model are you using right now, and how will that change when I'm in vs. out of plan mode?"*

These two features — plan mode and `opusplan` — are the highest-value things to build into your workflow early.

---

## Done? → Move on to Exercise 02: `sandbox/exercises/02-build-your-claudemd.md`

---

*Tasks completed:*
- [ ] Orient yourself (file navigation)
- [ ] Read and explain a SQL query
- [ ] Analyze sample data, spot suspicious numbers
- [ ] Search the project
- [ ] Have Claude write a file
- [ ] Edit a file
- [ ] Reflect on tools used
- [ ] Eval moment: verify and critique Claude's output
- [ ] Try plan mode and `/model opusplan`
