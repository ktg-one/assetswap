---
name: signout
description: End-of-session memory dump to all systems. Writes a timestamped signout marker so next session can check continuity.
---

# /signout — Session End Memory Dump

Save everything learned this session, then write a signout marker the next session can detect.

## 1. Write Signout Marker

Create/update `$MEMORY_DIR/last-signout.json`:
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

The next session should READ this file first to restore context.

## 2. File-Based Memory (PRIMARY — always loaded)

Write to `$MEMORY_DIR/MEMORY.md` and individual `.md` files:
- New feedback, project context, user preferences, or references
- Update existing memories if they've changed
- Keep MEMORY.md index under 200 lines

## 3. Self-Improving Agent (Skill Patterns)

If skills were used, update:
- `~/.claude/skills/self-improving-agent/memory/semantic/semantic-patterns.json` — add patterns with confidence
- `~/.claude/skills/self-improving-agent/memory/episodic/2026/YYYY-MM-DD-{project}.json` — log episode
- Note what worked, what failed, why

## 4. mem0

Store key decisions/preferences via MCP:
```
mcp__mem0__add-memory: key facts, decisions, user preferences
```

## 5. Local Project Memory

If working in a specific project, also save to that project's memory dir.

## What to Save
- Decisions made and WHY
- Patterns that worked or failed
- User corrections or preferences (feedback type)
- New project context
- References to external resources
- Skill usage outcomes

## What NOT to Save
- Code patterns derivable from the codebase
- Git history
- Ephemeral task details
- Anything already in CLAUDE.md
