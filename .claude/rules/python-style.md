# Python Rules

## Style
- snake_case for variables and functions, PascalCase for classes
- Prefer readable code over clever code
- Keep functions focused — one clear purpose per function

## API Calls
- Use `requests` for synchronous calls, `httpx` for async (prefer httpx.AsyncClient for async workflows)
- Always set timeouts on requests — never leave them open-ended
- Handle HTTP errors explicitly: check status codes, don't assume success

## Error Handling
- Always use try/except — catch specific exceptions, not bare `except:`
- Log errors with enough context to debug: what failed, what the input was

## Credentials
- All API keys and secrets via `.env` files using `python-dotenv`
- Never hardcode credentials anywhere in the code
- `.env` files never get committed — always in `.gitignore`

## Structure
- One script = one clear purpose
- Environment setup at the top (load dotenv, configure logging)
- Keep business logic separate from API call logic where possible
