# n8n Workflow Conventions

<!--
This is an example of a domain-specific rules file.
When you work heavily in a specific tool, a dedicated rules file
keeps that knowledge out of your main CLAUDE.md.

Every analyst will have different domain-specific rules — yours might 
cover dbt conventions, Snowflake query patterns, or Omni model standards.
This n8n file shows the pattern; replace the content with your own domain.
-->

## Workflow Naming

- Use descriptive, action-oriented names: `Email Re-Engagement — Hightouch Trigger` not `workflow_1`
- Format: `[Purpose] — [Trigger Source]`

## Node Naming

- Name every node explicitly — never leave default names like "HTTP Request" or "Set"
- Use verb phrases: `Get Customer from Snowflake`, `Generate Email Draft via Claude`, `Route to Sales Rep`
- Explicit names make debugging and handoff dramatically easier

## Structure

- One workflow = one clear purpose. If it does two unrelated things, split it.
- Put error handling on every external call (database queries, API calls, webhook outputs)
- Use a dedicated error branch — don't let failures silently pass through

## Error Handling

- Every node that calls an external system must have an error output connected
- Log errors with enough context to debug: which node failed, what the input was, what the error was
- For prototypes, a Slack notification on failure is sufficient

## Credentials

- Never hardcode API keys or connection strings inside nodes
- Always use n8n's built-in credential store
- Name credentials clearly: `Claude — HCP Production`, `Snowflake — Analytics Read-Only`

## Testing

- Test each node individually before connecting the full workflow
- Use mock/static data before connecting live data sources
- Document what a successful test run looks like (expected output per node)

## Documentation

- Add a sticky note at the top of every workflow: purpose, trigger, data flow, owner
- Link to the relevant Confluence page or Jira ticket if one exists
