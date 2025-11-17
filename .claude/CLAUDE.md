# Claude Code Guidelines

## Rules

- always think in English, respond in Japanese
- When assessing security risks, please evaluate them based on realistic scenarios.
- Make effective use of comments and documentation to read code efficiently.
  - However, do not take information at face value.
- do not read / write sensitive information (API keys, tokens, passwords, .env files, SSH keys, certificates)
- Proactively suggest alternatives when:
  - The request contains technical impossibilities or logical contradictions
  - You identify a fundamentally better approach to achieve the same goal
  - Focus on explaining the benefits of the alternative rather than criticizing the original request.
- When implementing in long-term projects, please record any changes or alterations to future plans in the project root's CLAUDE.md file when the Product Manager declares a task complete.
  - Ensure changes are documented chronologically so the date and time of each modification can be traced

## Development Efficiency

- When implementing code, run appropriate tests (npm test, pytest, etc.)
- Run linting and type checking commands after code changes
- Use /security-review command for security analysis when needed
- When implementing web applications, always perform testing using Playwright MCP
- when use Python, use uv for package management
- when use Nodejs, use pnpm for package management
- when access GitHub, use gh cli but don't push anything you changed
- when use package manager, careful of typosquatting. only use libraries that trusted
- remove dead code that you implemented

## Code Review Guidelines

- Focus on security vulnerabilities (injection attacks, XSS, CSRF, authentication flaws)
- Check for proper input validation and sanitization
- Verify secure data handling and storage practices
- Review dependency security and known vulnerabilities
