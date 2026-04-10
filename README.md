# KTG- Autonomous Webdev Scaffolding Harness

Autonomous site builder. Two-agent system that maps 100+ features, plans via GSD, and builds complete websites across multiple sessions. Supports Next.js, WordPress, and generative UI apps.

## Quick Start

```bash
cd brand-swap-gsd-kit
pip install -r requirements.txt  # claude-code-sdk>=0.0.25
python autonomous_agent_demo.py --project-dir ./my_project
```

## Init Phase

```bash
# 1. Clone MCP gateway (if not present)
git clone https://github.com/ktg-one/mcp-webdev .mcp/

# 2. Start FastMCP gateway
python .mcp/gateway-webdev.py

# 3. Clone design references
git clone https://github.com/VoltAgent/awesome-design-md.git ~/knowledge2026/Projects-Coding/awesome-design-md

# 4. Clone onboarding skill
cd ~/.claude/skills
git clone https://github.com/adamlyttleapps/claude-skill-app-onboarding-questoinnaire.git app-onboarding-questionnaire

# 5. Post-init (after Next.js project is scaffolded)
npx shadcn@latest add @fonttrio/editorial
```

## Execution Order

All work follows `.plan/SOURCE_OF_TRUTH.json`. Never skip phases or execute without a complete plan.

```
Phase 0: app-spec-agent → docs/plans/ir-assessment.md
Phase 1: init-agent → docs/plans/features.json (100+ features minimum)
Phase 2: /gsd:new-project → .planning/PROJECT.md
Phase 3: /gsd:map-codebase → .planning/codebase/
Phase 4-6: /gsd:add-phase → /gsd:research-phase → /gsd:plan-phase
Phase 7: /gsd:execute-phase (only after full plan exists)
Phase 8: /gsd:verify-work
```

**You can only execute when the entire plan is done.**

## Skills — Install Commands

### Core (must-have)

```bash
# Vercel / React / Next.js
npx skills add vercel-labs/agent-skills@vercel-react-best-practices -g -y
npx skills add vercel-labs/agent-skills@vercel-react-view-transitions -g -y
npx skills add vercel-labs/agent-skills@vercel-react-native-skills -g -y

# shadcn UI
npx skills add google-labs-code/stitch-skills@shadcn-ui -g -y
npx skills add shadcn-ui/ui@shadcn -g -y

# Tailwind CSS
npx skills add bobmatnyc/claude-mpm-skills@tailwind-css -g -y
npx skills add josiahsiegel/claude-plugin-marketplace@tailwindcss-accessibility -g -y
```

### Animation / Scroll

```bash
# GSAP (official GreenSock)
npx skills add greensock/gsap-skills@gsap-plugins -g -y
npx skills add bbeierle12/skill-mcp-claude@gsap-scrolltrigger -g -y

# Framer Motion
npx skills add patricio0312rev/skills@framer-motion-animator -g -y

# Scroll libraries
npx skills add sickn33/antigravity-awesome-skills@scroll-experience -g -y
npx skills add freshtechbro/claudedesignskills@locomotive-scroll -g -y
npx skills add jerrar670/surf-website@implement_lenis_scroll -g -y
npx skills add doodledood/claude-code-plugins@scrollytelling -g -y

# Awwwards-level animations
npx skills add devmartinese/awwwards-animations-skill@awwwards-animations -g -y
```

### 3D / WebGL

```bash
npx skills add freshtechbro/claudedesignskills@threejs-webgl -g -y
```

### Generative UI

```bash
npx skills add thesysdev/openui@openui -g -y
npx skills add copilotkit/skills@copilotkit -g -y
```

### WordPress

```bash
npx skills add wordpress/agent-skills@wp-plugin-development -g -y
npx skills add wordpress/agent-skills@wp-rest-api -g -y
npx skills add wordpress/agent-skills@wp-block-themes -g -y
npx skills add wordpress/agent-skills@wp-block-development -g -y
npx skills add wordpress/agent-skills@wp-performance -g -y
npx skills add wordpress/agent-skills@wordpress-router -g -y
npx skills add johnie/skills@wp-cli -g -y
```

### Quality / Debugging / Linting

```bash
npx skills add dylantarre/animation-principles@implementation-debugging -g -y
npx skills add sickn33/antigravity-awesome-skills@web-performance-optimization -g -y
npx skills add patricio0312rev/skills@eslint-prettier-config -g -y
```

### Research / Memory

```bash
npx skills add pleaseprompto/notebooklm-skill@notebooklm -g -y
```

### Tooling (pre-installed)

```bash
# These should already be present
npx skills add vercel-labs/agent-browser -g -y
npx skills add vercel/ai@ai-sdk -g -y
npx skills add vercel-labs/agent-skills@deploy-to-vercel -g -y
npx skills add vercel-labs/skills@find-skills -g -y
npx skills add charon-fan/agent-playbook@self-improving-agent -g -y
npx skills add google-labs-code/stitch-skills@stitch-loop -g -y
```

## Orchestration Agents

Claude owns strategy/synthesis. Dispatch parallel work to:

| Agent | Command | Use for |
|-------|---------|---------|
| Gemini CLI | `gemini -p "prompt"` / `consult_gemini` MCP | Research, review, web search, second opinion |
| Codex CLI | `codex exec "prompt"` | Bulk/repetitive edits, file transforms |
| Jules CLI | `/jules-cli` skill | Async background tasks, CI jobs |
| CodeRabbit | `/coderabbit:code-review` skill | PR review, security audit, autofix |
| GitHub Copilot | Via skill integration | Code suggestions, completions |

## Design References

59 top site designs cloned to `~/knowledge2026/Projects-Coding/awesome-design-md/design-md/`:
Apple, Stripe, Vercel, Linear, Figma, Framer, SpaceX, Tesla, Ferrari, Spotify, Airbnb, Notion, Supabase, Cursor, Claude, and more.

Source: https://github.com/VoltAgent/awesome-design-md.git

## MCP Gateway

`.mcp/gateway-webdev.py` (FastMCP 3) mounts:

| Server | Purpose | Env var |
|--------|---------|---------|
| figma | Design-to-code | `FIGMA_API_KEY` |
| vercel | Deploy | `VERCEL_API_KEY` |
| in-memoria | Session memory | — |
| next-devtools | Next.js devtools | — |
| serena | Code navigation | — |

## Architecture: brand-swap-gsd-kit/

| File | Role |
|------|------|
| `autonomous_agent_demo.py` | Entry point. CLI args, iteration loop, model selection |
| `agent.py` | Core session logic. Two-session pattern (init vs coding) |
| `client.py` | ClaudeSDKClient builder with 3-layer security |
| `prompts.py` | Loads prompts from `prompts/`, copies app_spec to project |
| `security.py` | Bash command allowlist (17 commands) |
| `progress.py` | Reads `feature_list.json`, counts passing tests |
