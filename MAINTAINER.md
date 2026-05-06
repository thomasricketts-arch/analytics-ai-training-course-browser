# Maintainer Guide — AI Analysts Training Course (Browser)

This document covers everything needed to maintain and hand off this course. The Desktop version has a parallel `MAINTAINER.md` in its own repo.

---

## Course Overview

A self-guided Claude Code course for HCP analytics teams. Learners work through five exercises using Claude Code itself as their teacher — no slides required. The Browser version targets claude.ai/code and requires no installation.

**Audience:** HCP analysts comfortable with SQL and Python, new to Claude Code.
**Estimated time to complete:** 3–5 hours across five exercises, or one exercise per week.

---

## Two Courses, Two Repos

| Version | Audience | GitHub Repo |
|---|---|---|
| **Browser** (this repo) | Learners using claude.ai/code — no install required | [github.com/thomasricketts-arch/analytics-ai-training-course-browser](https://github.com/thomasricketts-arch/analytics-ai-training-course-browser) |
| **Desktop** | Learners using the Desktop app, VS Code extension, or terminal | [github.com/thomasricketts-arch/analytics-ai-training-course](https://github.com/thomasricketts-arch/analytics-ai-training-course) |

The two courses share the same exercise structure and content philosophy. Changes to exercises should usually be applied to both unless the change is version-specific (e.g. browser uses mode dropdown, desktop uses Shift+Tab; browser config lives in `.claude/`, desktop config lives in `~/.claude/`).

---

## Feedback Collection

| Resource | Link | Access |
|---|---|---|
| **Feedback form (public)** | https://forms.gle/Jq9qcZQmU8L2rcSX7 | Anyone with the link |
| **Feedback form (edit)** | https://docs.google.com/forms/d/1EMW4svHM-PEgds5ve81V0nRZnofILt7u9P0SElbZlDo/edit | Course maintainer only |
| **Response sheet** | https://docs.google.com/spreadsheets/d/1fxKVelm1AEab74UkssBuTTajMyX12SFrCqgfiM8_WrY/edit | Course maintainer only |

The form collects: course version, 1–5 rating, open-ended suggestions. Responses land automatically in the Sheet. Check it periodically — after any cohort completes the course is a natural time.

---

## File Structure

```
AI Training Course — Browser/
  CLAUDE.md                    # Makes Claude the course teacher — edit with care
  README.md                    # Learner-facing course guide (also the module content)
  MAINTAINER.md                # This file
  .claude/                     # Project-scoped config (built by learners during the course)
    rules/
    agents/
    skills/
  sandbox/
    exercises/                 # The six exercises (five core + one optional) — primary place to make updates
    sample-data/               # Sample SQL and CSV used in exercises
    templates/                 # Starter files learners copy and customize
  analyst-setup/               # Reference config — a local-style setup shown as a preview
  resources/
    cheatsheet.md              # Quick reference — update when Claude Code changes
    eval-checklist.md          # QA checklist used in Exercise 05
```

---

## How to Update the Course

### Updating an exercise
Edit the relevant file in `sandbox/exercises/`. Each exercise is self-contained markdown. Check whether the same change applies to the Desktop version and update that repo too.

The browser version has six exercises (five core + Exercise 06, which is optional and covers promoting config to a local setup). The Desktop version has five.

### Updating the cheatsheet
`resources/cheatsheet.md` is the quick reference learners consult during the course. Update it when:
- Claude Code releases a significant new feature
- A command, shortcut, or UI element changes (especially mode switching — browser uses a dropdown, not Shift+Tab)
- Learners frequently ask something not covered there

The CLAUDE.md instructs Claude to suggest cheatsheet updates when it learns something new from official docs. Act on the ones that are accurate.

### Updating the README
`README.md` doubles as the module content (the structured course curriculum). Update it when exercises change substantially or when Claude Code's core behavior shifts enough to make existing explanations inaccurate.

### Keeping both versions in sync
After any substantive update to this repo, check whether the Desktop repo needs the same change. Preserve browser-specific differences when syncing:
- Config paths: `.claude/` (browser) vs `~/.claude/` (desktop)
- Mode switching: mode dropdown (browser) vs Shift+Tab (desktop)
- Auto-memory: doesn't persist in browser sessions
- MCP: remote HTTP/SSE only in browser; local stdio servers require desktop

---

## When Claude Code Releases Updates

Claude Code releases frequently. Most releases don't require course updates, but watch for:

- Changes to how modes work or how they're accessed in the browser UI
- Changes to slash commands learners use (`/model`, `/compact`, `/clear`)
- New config file formats or locations
- Changes to `.mcp.json` format or remote MCP behavior

Release notes are at [claude.ai/code](https://claude.ai/code). The cheatsheet is the first place to update; exercise content only needs updating if the change affects a task learners actually do.

---

## Ownership

**Original author:** Thomas Ricketts (thomas.ricketts@housecallpro.com)
**Team:** AI Graduate Solutions / Analytics
