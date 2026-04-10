#!/bin/bash
# Session End Hook — HARD BLOCK + PLAN MODE SWITCH
# Agent cannot stop. Gets switched to plan mode. Must complete handoff.

INPUT=$(cat)

# Second pass — agent already did the handoff tasks, let it stop
if [ "$(echo "$INPUT" | jq -r '.stop_hook_active')" = "true" ]; then
  exit 0
fi

# First pass — block stop, switch to plan mode
cat <<'EOF'
{"hookSpecificOutput":{"hookEventName":"Stop","decision":{"behavior":"block"}},"updatedPermissions":[{"type":"setMode","mode":"plan","destination":"session"}]}
EOF

echo "HARD STOP. You are now in PLAN MODE. You cannot execute.
Before you can finish you MUST:
1. Search mem0 — log everything you did today tagged [YYYY-MM-DD]
2. Plan your git commit — what changed and why
3. Plan your progress.md update — completed, next, blockers
4. Check — is the codebase clean and runnable?
Complete all four. Then you may stop." >&2

exit 2
