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

Then open the file yourself. Is Claude's explanation accurate? What did it get right? What did it miss or simplify?

This is different from asking Claude in chat mode — Claude Code is reading the *actual file in your project*, not a copy you pasted in.

**Concept:** The `Read` tool lets Claude see any file. Always verify the explanation against the file itself.

---

## Task 3: Understand the Data

Ask Claude: *"Read `sandbox/sample-data/sample_output.csv` and tell me: which vertical had the highest growth last month? Which had the lowest? Are there any numbers that look suspicious?"*

After Claude answers:
- Check one of the numbers yourself. Is the math right?
- Did Claude flag the Landscaping growth numbers? They're unusually high — a good analyst would question them.

**Concept:** Claude can summarize data, but you still need to interpret it critically. High MoM growth could be real, seasonal, or a data error. Claude doesn't know which — you do.

---

## Task 4: Search the Project

Ask Claude: *"Find all files in this project that contain the word 'eval' or 'verify'."*

Then ask: *"Find all `.md` files in the `resources/` folder and list what each one covers."*

**Concept:** `Grep` searches file *contents*. `Glob` searches file *names and paths*. These two tools together let Claude navigate large projects quickly.

---

## Task 5: Have Claude Write Something

Ask Claude: *"Create a file called `sandbox/my-analysis-notes.md`. In it, write a brief summary of what the sample query does, what the output shows, and one thing you'd want to investigate further."*

After Claude creates it, ask: *"Read `sandbox/my-analysis-notes.md` back to me."*

Check:
- Is the summary accurate?
- Is "one thing to investigate" a real insight, or a generic filler answer?
- Would you edit this before sharing with a stakeholder?

**Concept:** Claude can draft content quickly, but the output is a starting point — not a final product. Your judgment about what's accurate and what's useful is irreplaceable.

---

## Task 6: Edit a File

Ask Claude: *"Edit `sandbox/my-analysis-notes.md` to add a section at the bottom called 'Open Questions' with three bullet points based on the data."*

Then review what it added. Are the questions genuinely interesting, or are they generic? Edit the file yourself if needed.

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

---

## Before Moving On: Eval Moment

You've seen Claude read, summarize, and draft content. Before moving to Exercise 02, ask yourself:

- In Task 3, did Claude correctly identify the most notable pattern in the data?
- In Task 5, would you trust the summary without reading the source files yourself?
- What would Claude have gotten wrong if you hadn't checked?

The answer to that last question is worth writing down. It's the beginning of knowing when to trust Claude and when to verify.

See `resources/eval-checklist.md` for a full checklist you can use anytime.

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
