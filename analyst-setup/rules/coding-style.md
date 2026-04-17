# Coding Style

<!-- 
This is a rules file — it covers a specific domain (coding style) 
in depth, without cluttering the main CLAUDE.md.

Rules files live in ~/.claude/rules/ and are loaded alongside CLAUDE.md
at the start of every session.
-->

## Naming Conventions

- **Variables and functions**: snake_case (`user_name`, `get_user_by_id`)
- **Classes**: PascalCase (`UserProfile`, `DataProcessor`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRIES`, `API_BASE_URL`)
- **Files**: snake_case (`data_processor.py`, `api_client.py`)

## Comments

Prefer self-documenting code over excessive comments:

```python
# WRONG: Restating what the code already says
# Add 1 to count
count = count + 1

# CORRECT: Explaining why, not what
# Offset by 1 because the API uses 1-based indexing
count = count + 1
```

Only comment when the *reason* behind the code isn't obvious. If a function needs a paragraph of comments to explain what it does, consider renaming it or breaking it up instead.

## Functions

Break code into functions — but only when it earns its keep:

```python
# Good reason to extract: reused in multiple places
def format_customer_name(first, last):
    return f"{last}, {first}"

# Good reason to extract: complex logic with a clear name
def is_eligible_for_discount(customer):
    return customer.total_orders > 10 and customer.account_age_days > 90

# Not worth extracting: used once, simple enough to read inline
```

Rules of thumb:
- If you're copy-pasting code, make it a function
- If a block has a clear single purpose, it can be a function
- Functions should do one thing — if you struggle to name it, it probably does too much

## Error Handling

Always handle errors explicitly. Never let them fail silently:

```python
try:
    result = risky_operation()
    return result
except SpecificError as e:
    print(f"Operation failed: {e}")
    raise ValueError("User-friendly error message") from e
```

Catch specific exceptions when you can (not bare `except:`).

## SQL Style

- Keywords in UPPERCASE: `SELECT`, `FROM`, `WHERE`, `JOIN`, `GROUP BY`
- Everything else in lowercase: column names, table names, aliases
- One clause per line for complex queries:

```sql
SELECT name, id, created_at
FROM customers
WHERE id > 100
  AND status = 'active'
ORDER BY created_at DESC
```

## Code Quality Checklist

Before marking work complete:
- [ ] Names are descriptive — no `x`, `temp`, `data` without context
- [ ] Functions do one thing
- [ ] No copy-pasted code blocks
- [ ] Errors handled explicitly
- [ ] Comments explain *why*, not *what*
- [ ] No hardcoded values (use constants or environment variables)
