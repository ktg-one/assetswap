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

## Skill Usage Rule (MANDATORY)

**Output quality drops 60% when executing without skill knowledge loaded. This is proven across multiple sessions. DO NOT SKIP THIS.**

Before writing ANY code:
1. Identify which installed skills are relevant to the current task
2. Invoke them with `/skill-name` to load domain knowledge into context
3. THEN write code with that knowledge loaded

This eliminates debug cycles. Code is right the first time when skills are consulted.

**Skill categories available:**
- React/Next.js: `vercel-react-best-practices`, `vercel-composition-patterns`, `vercel-react-view-transitions`
- UI: `shadcn`, `shadcn-ui`, `tailwind-css`, `tailwindcss-accessibility`
- Animation: `gsap-plugins`, `gsap-scrolltrigger`, `framer-motion-animator`, `awwwards-animations`
- Scroll: `scroll-experience`, `scrollytelling`, `locomotive-scroll`, `implement_lenis_scroll`
- 3D: `threejs-webgl`
- WordPress: `wp-plugin-development`, `wp-block-themes`, `wp-block-development`, `wp-rest-api`, `wp-performance`, `wordpress-router`, `wp-cli`
- Generative UI: `openui`, `copilotkit`
- Quality: `implementation-debugging`, `web-performance-optimization`, `eslint-prettier-config`, `react-doctor`
- Design: `high-end-visual-design`, `design-taste-frontend`, `web-design-guidelines`, `redesign-existing-projects`
- Discovery: `/skill-lookup`, `/find-skills` — use when unsure which skill applies

## Orchestration — Available CLI Agents

Claude owns strategy and synthesis. Dispatch parallel work to these agents:

| Agent | Invoke | Use for |
|-------|--------|---------|
| **Gemini CLI** | `gemini -p "prompt"` or `consult_gemini` MCP | Research, review, web search, second opinion |
| **Codex CLI** | `codex exec "prompt"` | Bulk/repetitive edits, file transforms |
| **Jules CLI** | `/jules-cli` skill | Async background tasks, CI jobs |
| **CodeRabbit** | `/coderabbit:code-review` skill | PR review, security audit, autofix |
| **GitHub Copilot** | Via skill integration | Code suggestions, completions |

Pass explicit instructions per agent. No duplicated work.

## MCP Integration

Gateway at `.mcp/gateway-webdev.py` (FastMCP 3) mounts: figma, vercel, in-memoria, next-devtools, serena. Requires `FIGMA_API_KEY` and `VERCEL_API_KEY` in `.mcp/.env`.
