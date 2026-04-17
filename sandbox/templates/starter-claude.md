# CLAUDE.md — Analyst Config Template

<!-- 
  HOW TO USE THIS TEMPLATE
  ========================
  This is your personal CLAUDE.md starter file. It lives at ~/.claude/CLAUDE.md
  and is read automatically at the start of every Claude Code session.
  
  Replace anything in [brackets] with your actual information.
  Delete sections that don't apply to you.
  Add sections for things that matter to your work but aren't covered here.
  
  You'll update this file as you learn more about how Claude works best for you.
-->

---

## About Me

- **Role**: Analyst at Housecall Pro — [describe your team and focus, e.g., "Growth Analytics, focused on retention and product usage metrics"]
- **Experience**: [e.g., "2 years at HCP. Comfortable with SQL and Python basics. New to Claude Code."]
- **Stack**: Snowflake (primary data warehouse), dbt (data modeling), Omni (BI and reporting), Claude Code (AI assistant)
- **How I work**: [e.g., "I spend most of my time writing queries, building dashboards, and producing stakeholder summaries. I work independently but sanity-check numbers with the team before publishing."]

---

## Workflow Preferences

1. **Plan before acting.** Before making any changes to files or writing code, explain what you're going to do and wait for my confirmation.
2. **Explain what you did.** After completing a task, briefly explain what you changed and why. I want to understand the reasoning, not just the output.
3. **Keep it simple.** Prefer small, focused edits over large rewrites. If I asked for one thing, do one thing.
4. **Read files before answering questions about them.** Never speculate about file contents you haven't read.
5. **Flag uncertainty explicitly.** If you're not sure whether something is correct, say so. I'd rather have a confident question than a confident wrong answer.
6. **Use structured responses.** For analysis tasks, use headers and tables over long paragraphs. I'm skimming for the key finding.

---

## My Analyst Stack

<!-- 
  List the tools you actually use. This helps Claude give relevant suggestions
  and avoid recommending tools or patterns that don't fit your environment.
-->

| Tool | How I use it |
|------|-------------|
| **Snowflake** | Primary data warehouse. All production queries run here. |
| **dbt** | Data modeling. Staging, intermediate, and mart layers. |
| **Omni** | BI and dashboarding. Stakeholder-facing reports live here. |
| **Claude Code** | SQL review, query explanation, draft narratives, ad-hoc analysis. |
| **[Add more]** | [e.g., Python for scripting, n8n for automation] |

---

## SQL and Data Conventions

<!-- 
  These rules apply whenever Claude writes or reviews SQL for me.
  Update them to match how your team actually writes queries.
-->

- **Keywords in UPPERCASE**: `SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`, `ORDER BY`, `HAVING`, `WITH`
- **CTEs over subqueries**: Prefer `WITH cte_name AS (...)` over nested subqueries. CTEs are easier to read, test, and modify.
- **One clause per line** for complex queries: `WHERE` condition, `AND` condition — each on its own line with consistent indentation
- **Explicit JOINs**: Always specify the join type (`LEFT JOIN`, `INNER JOIN`). Never use implicit joins (comma-separated tables in `FROM`).
- **Meaningful aliases**: `customers AS c` is fine. `customers AS x` is not.
- **Column comments for non-obvious logic**: If a calculation is complex or has a business-specific definition, add a brief inline comment explaining why it works that way.
- **Snowflake-specific**: Use `DATE_TRUNC('month', created_at)` for period grouping. Use `DATEADD('day', -30, CURRENT_DATE)` for relative date ranges. Prefer `COALESCE` over `CASE WHEN x IS NULL THEN`.
- **Exploration vs. production**: `LIMIT` clauses for exploratory queries. Remove them before anything goes into a dashboard or report.

---

## Things to Never Do

- **Never hardcode values or connection strings.** Use environment variables or references to config files.
- **Never speculate about code or data you haven't read.** If you need to see a file to answer a question, ask to read it first.
- **Never put real customer data or PII in prompts.** If I ask you to work with data that looks like it contains names, emails, or account IDs, flag it and use synthetic examples instead.
- **Never produce a narrative that contains numbers not sourced from the actual data.** If the number isn't in the query output, don't write it.
- **Never mark a task complete without confirming the output is correct.** Always ask "does this look right?" before calling it done.

---

## Available Tools and Skills

<!-- 
  Update this section as you connect tools and build agents.
  Claude uses this to know what it can do beyond file read/write.
-->

### Skills (slash commands I have set up)
- `/sanity-check` — validates a metric value against the HCP instrumentation source of truth

### Agents
- [Add agents here as you build them, e.g. "sql-reviewer — reviews Snowflake queries for correctness and style"]

### MCP Servers
- [Add active MCP servers here, e.g. "claude-code-guide — documentation and cheatsheet for Claude Code"]

---

## Session Learnings

<!-- 
  Claude can append notes here automatically at the end of sessions.
  Think of this as a running log of things you've learned or preferences
  you've discovered through use.
  
  To add a note: ask Claude "Add a session learning about [topic]"
  To review: ask Claude "What have I learned across recent sessions?"
  
  Format: dated bullet points summarizing key takeaways.
-->

- [Session learnings will appear here as you use Claude Code]
