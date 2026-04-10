#!/bin/bash
# prompt-skill-check.sh
# Fires on: UserPromptSubmit
# Purpose: Before Claude processes any prompt, inject a reminder to check skills
#
# UserPromptSubmit supports additionalContext - text injected into Claude's 
# context alongside the user's message. This is the ONLY pre-execution hook
# that can inject instructions Claude actually sees.
#
# Install in settings.json:
# {
#   "hooks": {
#     "UserPromptSubmit": [
#       {
#         "matcher": "",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "bash C:/Users/kevin/.claude/hooks/prompt-skill-check.sh"
#           }
#         ]
#       }
#     ]
#   }
# }

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // "."')

# Check for skills directory
SKILLS_DIR=""
if [ -d "$CWD/skills" ]; then
  SKILLS_DIR="$CWD/skills"
elif [ -d "$CWD/.claude/skills" ]; then
  SKILLS_DIR="$CWD/.claude/skills"
fi

# Check for memo
MEMO=""
if [ -f "$CWD/.claude/rules/memo.md" ]; then
  MEMO=$(cat "$CWD/.claude/rules/memo.md" 2>/dev/null | head -20)
fi

# Build context injection
CONTEXT=""

if [ -n "$SKILLS_DIR" ]; then
  SKILL_LIST=$(ls "$SKILLS_DIR"/*.md 2>/dev/null | xargs -I {} basename {} .md 2>/dev/null | tr '\n' ', ')
  if [ -n "$SKILL_LIST" ]; then
    CONTEXT="BEFORE EXECUTING: Check if a skill applies to this task. Available: ${SKILL_LIST%. }. Read the SKILL.md before writing code."
  fi
fi

if [ -n "$MEMO" ]; then
  CONTEXT="${CONTEXT} MEMO: ${MEMO}"
fi

# If nothing to inject, exit clean
if [ -z "$CONTEXT" ]; then
  exit 0
fi

# Escape for JSON
CONTEXT_ESCAPED=$(echo "$CONTEXT" | jq -Rs '.')

cat << EOF
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": ${CONTEXT_ESCAPED}
  }
}
EOF

exit 0
