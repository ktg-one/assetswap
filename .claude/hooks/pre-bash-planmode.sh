#!/bin/bash
# Pre-Bash Hook — PLAN MODE until skill is read + delegation check
# Agent cannot execute until it has loaded context and considered delegation

GATE="${TEMP:-/tmp}/cc-bash-gate"

if [ ! -f "$GATE" ]; then
  touch "$GATE"

  cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny"},"updatedPermissions":[{"type":"setMode","mode":"plan","destination":"session"}]}
EOF

  echo "BLOCKED. You are now in PLAN MODE. You cannot execute.
1. Have you read the relevant skill? Do it now.
2. Have you checked mem0 for prior context on this task?
3. Should you DELEGATE this instead of doing it yourself?
   - gemini: research, review, analysis
   - codex: bulk/repetitive edits
   - jules: async background/CI tasks
   - GitHub Copilot: inline completions
   You are the orchestrator. Dispatch work. No duplicated effort.
After you have done these, retry." >&2

  exit 2
fi
