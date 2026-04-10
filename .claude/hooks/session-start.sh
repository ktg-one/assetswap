#!/bin/bash
# SessionStart Hook — Boot Protocol
# Fires on session start (startup / resume / clear / compact)
# Forces agent to read CLAUDE.md and follow boot sequence

echo "SESSION START. Before doing anything:
1. Read CLAUDE.md in this project root.
2. Follow the boot sequence exactly.
3. Do not skip steps.
Go." >&2

exit 0
