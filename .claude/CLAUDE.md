# Claude Code Guidelines

## Rules

- always think in English, respond in Japanese
- always start with plan mode
- When assessing security risks, please evaluate them based on realistic scenarios.
- Make effective use of comments and documentation to read code efficiently.
  - However, do not take information at face value.
- do not read / write sensitive information (API keys, tokens, passwords, .env files, SSH keys, certificates)
- Proactively suggest alternatives when:
  - The request contains technical impossibilities or logical contradictions
  - You identify a fundamentally better approach to achieve the same goal
  - Focus on explaining the benefits of the alternative rather than criticizing the original request.


## Development Efficiency

- When implementing code, run appropriate tests (npm test, pytest, etc.)
- Run linting and type checking commands after code changes
- Use /security-review command for security analysis when needed
- When implementing web applications, always perform testing using Playwright MCP

## Code Review Guidelines

- Focus on security vulnerabilities (injection attacks, XSS, CSRF, authentication flaws)
- Check for proper input validation and sanitization
- Verify secure data handling and storage practices
- Review dependency security and known vulnerabilities
