#!/bin/bash
# Pre-Write/Edit Hook — Skill & Context Gate
# Blocks first write attempt until agent loads context

GATE="${TEMP:-/tmp}/cc-skill-gate"

if [ ! -f "$GATE" ]; then
  touch "$GATE"
  cat <<'EOF'
{"decision":"block","reason":"STOP. Before writing code:
1. Read the relevant skill from skills/ for what you are about to build.
2. Search mem0 for context from previous sessions on this task.
3. Check Context7 for library docs if working with any framework/library.
Do all three. Then retry this write."}
EOF
  exit 2
fi
