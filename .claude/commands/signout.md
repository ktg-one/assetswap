---
name: signout
description: End-of-session memory dump. Appends to session-log.json and writes last-signout.json for next session boot.
---

# /signout — Session End Memory Dump

## 1. Append Current Signout to Log, Then Overwrite Last

Read `$MEMORY_DIR/session-log.json`. If it doesn't exist, create it as `{ "sessions": [] }`.

Append the current `last-signout.json` content (if it exists) to the `sessions` array.

Then overwrite `$MEMORY_DIR/last-signout.json` with this session's data:

```json
{
  "session_date": "YYYY-MM-DD",
  "session_time": "HH:MM AWST",
  "project": "project-name",
  "summary": "One-line summary of what was done",
  "next_steps": ["What to do next session"],
  "skills_used": ["list of skills invoked"],
  "unresolved": ["Any open issues or bugs"]
}
```

Result: `last-signout.json` = latest session only. `session-log.json` = all previous sessions in one file.

## 2. File-Based Memory (PRIMARY)

Write to `$MEMORY_DIR/MEMORY.md` and individual `.md` files.

## 3. Self-Improving Agent

Update `~/.claude/skills/self-improving-agent/memory/` if skills were used.

## 4. mem0

`mcp__mem0__add-memory` for key decisions/preferences.

## 5. What to Save

Decisions and WHY. Patterns. User corrections. Project context. Skill outcomes.

## 6. What NOT to Save

Code patterns from codebase. Git history. Ephemeral details. Anything in CLAUDE.md.
