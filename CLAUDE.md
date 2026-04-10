# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Autonomous Next.js scaffolding harness. Two-agent system that builds complete web apps across multiple sessions using `brand-swap-gsd-kit/` (Python SDK wrapper) and GSD workflow orchestration.

## Execution Order (Strict)

All work follows `.plan/SOURCE_OF_TRUTH.json`. Never skip phases or execute without a complete plan.

```
Phase 0: app-spec-agent → docs/plans/ir-assessment.md
Phase 1: init-agent → docs/plans/features.json (200+ test cases)
Phase 2: /gsd:new-project → .planning/PROJECT.md
Phase 3: /gsd:map-codebase → .planning/codebase/
Phase 4-6: /gsd:add-phase → /gsd:research-phase → /gsd:plan-phase
Phase 7: /gsd:execute-phase (only after full plan exists)
Phase 8: /gsd:verify-work
```

## Running the Autonomous Agent

```bash
cd brand-swap-gsd-kit
pip install -r requirements.txt  # claude-code-sdk>=0.0.25
python autonomous_agent_demo.py --project-dir ./my_project
```

- Session 1 (initializer): generates `feature_list.json`, `init.sh`, project skeleton
- Sessions 2+: implements features from `feature_list.json`, marks `passes: true`
- Output goes to `generations/` directory
- Auto-continues with 3-second delay between iterations

## Architecture: brand-swap-gsd-kit/

| File | Role |
|------|------|
| `autonomous_agent_demo.py` | Entry point. CLI args, iteration loop, model selection |
| `agent.py` | Core session logic. Two-session pattern (init vs coding) |
| `client.py` | ClaudeSDKClient builder with 3-layer security (OS sandbox → filesystem → bash hooks) |
| `prompts.py` | Loads prompts from `prompts/`, copies app_spec to project |
| `security.py` | Bash command allowlist (17 commands). Validates pkill/chmod/init.sh |
| `progress.py` | Reads `feature_list.json`, counts passing tests |

## Security Model

`security.py` enforces defense-in-depth:
- **Allowlist:** ls, cat, head, tail, grep, cp, mkdir, npm, node, git, ps, lsof, sleep, pkill, chmod, init.sh
- **pkill** restricted to dev processes (node, npm, npx, vite, next)
- **chmod** restricted to `+x` only
- `bash_security_hook()` runs as pre-tool-use hook on every Bash call

## Key Files & Artifacts

| Path | Purpose |
|------|---------|
| `.plan/SOURCE_OF_TRUTH.json` | Execution manifest — workflow, phase sequence, locked systems |
| `prompts/app_spec.txt` | Full application specification (~700 lines) |
| `feature_list.json` (generated) | Test case source of truth, tracks pass/fail per feature |
| `.planning/` (generated) | GSD project context, codebase maps, phase plans |

## Locked Systems Policy

During feature implementation: no rewrites of core Next.js architecture, API routes, or database schemas unless explicitly planned. This prevents drift when building across sessions.

## Agents

- **app-spec-agent** (Phase 0): Maps project specs to detailed XML specification. Uses opus, max effort, 20 turns.
- **init-agent** (Phase 1): Creates feature_list.json with 200+ test cases, init.sh, project skeleton.

## MCP Integration

Gateway at `.mcp/gateway-webdev.py` (FastMCP 3) mounts: figma, vercel, in-memoria, next-devtools, serena. Requires `FIGMA_API_KEY` and `VERCEL_API_KEY` in `.mcp/.env`.
