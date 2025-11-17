#!/bin/bash
# Simple reminder to check CLAUDE.md guidelines
INPUT=$(cat)

# Check if acknowledgment was already given
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)

# If no transcript path or file doesn't exist, allow the request
if [ -z "$TRANSCRIPT_PATH" ] || [ ! -f "$TRANSCRIPT_PATH" ]; then
    exit 0
fi

# Check recent messages for acknowledgment
LAST_MESSAGES=$(tail -n 10 "$TRANSCRIPT_PATH" 2>/dev/null | \
    jq -r 'select(.type == "assistant") | .message.content[]? | select(.type == "text") | .text' 2>/dev/null || echo "")

if echo "$LAST_MESSAGES" | grep -q "CLAUDE_MD_REVIEWED"; then
    exit 0
fi

cat << 'EOF'
{
  "decision": "block",
  "reason": "Please check the guidelines in CLAUDE.md before proceeding. Respond with 'CLAUDE_MD_REVIEWED' to acknowledge."
}
EOF