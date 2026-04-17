# Exercise 04: MCP and External Tools

So far, Claude Code has been working with files in this project. MCP changes that — it lets Claude connect to external systems: databases, APIs, internal tools, documentation.

In the browser version, you configure MCP servers by adding a `.mcp.json` file to this project. Claude reads it at session start. This is hands-on — by the end of this exercise, you'll have connected Claude to a real external tool.

---

## Task 1: What Is MCP?

Ask Claude: *"What is MCP? Explain it using a simple analogy — assume I know what Claude Code is but have never heard of MCP."*

The mental model that works for most people:

```
Claude Code  ←→  MCP Server  ←→  External System
```

An MCP server is an adapter. It sits between Claude and something external — a database, a GitHub repo, a BI tool — and translates Claude's requests into that system's language. Claude doesn't connect directly to Snowflake. It connects to a Snowflake MCP server, which connects to Snowflake.

Ask Claude: *"What's the difference between an MCP server and a tool that Claude already has built in?"*

**Concept:** Claude Code ships with tools like `Read`, `Write`, `Grep`, and `Glob`. These are always available. MCP extends that set — adding tools specific to external systems. The built-in tools are for your file system. MCP is for everything else.

---

## Task 2: See What's Already Active

Ask Claude: *"What MCP tools are available in this session right now?"*

If none are configured, that's a normal starting state. Ask Claude: *"What would it look like if I had an MCP server connected? What kinds of tools would show up?"*

**Browser note:** In the browser version, MCP servers are configured in `.mcp.json` inside this project. If `.mcp.json` doesn't exist yet, no external MCP tools will be available — only the built-in tools.

**Concept:** MCP tools show up in Claude Code just like built-in tools — Claude can call them during a session. The difference is they require a running MCP server. If the server isn't configured or isn't reachable, those tools aren't available.

---

## Task 3: Browser MCP — How It Works

Ask Claude: *"How do I configure MCP servers in the browser version of Claude Code? What file do I create and where?"*

In the browser version, MCP configuration lives in `.mcp.json` in the project root:

```json
{
  "mcpServers": {
    "server-name": {
      "type": "http",
      "url": "https://your-mcp-server.example.com"
    }
  }
}
```

**Important difference from local Claude Code:**
- Local version: you run `claude mcp add` in the terminal, which writes to `~/.claude.json` on your machine
- Browser version: you commit `.mcp.json` to the project — it's version-controlled and available to any claude.ai/code session that opens this repo

**Only remote MCP servers work in the browser.** Servers that run as a process on your local machine (local stdio servers) can't be reached from Anthropic's cloud infrastructure. The server must be accessible via HTTP/SSE.

**Concept:** In the browser version, your MCP config travels with the repo. Anyone who opens this project gets the same external tool connections.

---

## Task 4: Security Deep-Dive

**Read this before adding any MCP server.**

Ask Claude: *"What security questions should I ask before adding an MCP server to .mcp.json?"*

Work through these for any MCP server you're considering:

**Who made it?**
- Is the author an individual, an organization, or an unknown account?
- Can you verify their identity? (Company website, linked accounts, other known projects?)
- How old is the repo? How recently was it updated?

**What does it connect to?**
- What external systems does it access?
- Does it write data anywhere, or is it read-only?
- What happens if it has a bug — what's the blast radius?

**What permissions does it need?**
- Does it require credentials, API keys, or access tokens?
- Are those credentials scoped to the minimum necessary?
- Where are credentials stored? (In `.mcp.json`, in environment variables, or in the server's config?)

**Does the server code match the README?**
- Look at what the server actually does, not just what it claims to do
- Are there network calls that aren't mentioned in the documentation?

**Concept:** Adding an MCP server is a trust decision — you're giving Claude access to that external system. A malicious or poorly-secured MCP server could exfiltrate data. The bar for adding one should be higher than "it looked useful." Check with your team lead for anything that connects to production data.

---

## Task 5: Install the claude-code-guide MCP Server

This is a safe server to start with — it only reads from a public GitHub repo to provide Claude Code documentation. It's a practical example of how MCP adds value: Claude can search versioned, authoritative documentation rather than relying on training data.

Ask Claude: *"Help me add the claude-code-guide MCP server to `.mcp.json` in this project."*

The configuration looks like this:

```json
{
  "mcpServers": {
    "claude-code-guide": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "claude-code-ultimate-guide-mcp"]
    }
  }
}
```

**Note:** If this is a stdio-type server, it may not be available in the browser version (stdio servers run locally). Ask Claude to check whether a remote HTTP version exists, or treat this task as a configuration exercise — understanding the format — and move on to Task 6.

Once configured (or conceptually understood), ask:
- *"Search the claude-code-guide for 'plan mode' and summarize what it says."*
- *"Get the Claude Code cheatsheet from the guide."*

**Concept:** The guide MCP server illustrates the core value proposition — Claude + an authoritative external source is more trustworthy than Claude alone on specialized topics.

---

## Task 6: Built-in GitHub Tools

The browser version includes **built-in GitHub tools** with no MCP setup required.

Ask Claude: *"What GitHub tools do you have available in this session? What can you do with them?"*

These tools let Claude:
- Read issues and pull requests from connected repos
- Fetch file contents and diffs
- List branches and recent activity
- Post comments on issues or PRs

Try it: *"Look at the most recent issue in this repo (if any) and summarize it."*

**Concept:** Built-in tools are always available — no `.mcp.json` needed. For GitHub work, the browser version often has an advantage over the local version because GitHub access is pre-wired via Anthropic's infrastructure.

---

## Task 7: Your Analyst MCP Wishlist

You won't set all of these up today — some require remote servers or team lead approval. But it's worth knowing what's possible.

Ask Claude: *"What MCP servers would be most useful for an analyst on a Snowflake/dbt/Omni stack? Which of these would work in the browser version (remote HTTP) vs. requiring local setup?"*

Useful categories for analysts:
- **Snowflake MCP** — run queries, inspect schemas, check row counts without leaving Claude Code
- **Omni MCP** — pull BI data, explore topics, get live metric values
- **Slack MCP** — post formatted summaries to a channel after analysis
- **dbt MCP** — read model definitions, check lineage

For any of these you're interested in: ask your team lead which are approved for use at HCP, whether a remote HTTP version exists, and how to get access. Don't add database-connected MCP servers without checking first.

**Concept:** The most powerful MCP setups for analysts connect Claude to live data. But live data access requires the same care you'd apply to any other tool with those permissions.

---

## Eval Moment

Before adding any MCP server, ask yourself: *"What am I trusting here, and what would happen if that trust were misplaced?"*

A reasonable threshold:
- Servers from verified organizations with documented security practices: lower bar
- Servers from individuals on GitHub with no track record: higher bar
- Anything that asks for broad credentials to a production system: get a second opinion first

---

## Done? → Move on to Exercise 05: `sandbox/exercises/05-eval-and-meta.md`

---

*Tasks completed:*
- [ ] Understand what MCP is and the adapter mental model
- [ ] Check what MCP tools are active in your current session
- [ ] Understand how `.mcp.json` works in the browser version
- [ ] Work through the security questions for any MCP server
- [ ] Attempt or understand the claude-code-guide MCP server setup
- [ ] Explore the built-in GitHub tools
- [ ] Build your analyst MCP wishlist
- [ ] Eval moment: set your personal threshold for MCP server trust
