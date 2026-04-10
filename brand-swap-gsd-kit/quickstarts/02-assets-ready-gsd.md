# Quickstart 02 — Assets Ready / GSD Execution

Use this when your logo, fonts, palette, copy, and media are available.

## Goal
Let GSD plan and execute from the manifest without drifting into redesign work.

## Steps
1. Open `.plan/SOURCE_OF_TRUTH.json` and verify the manifest paths are correct.
2. Update `docs/plans/<date>-swap-features.json` so the needed units are `ready`.
3. Confirm locked systems are defined clearly.
4. Run `gsd-new-project` or `gsd-plan-phase`.
5. Force GSD to plan only from:
   - `.plan/SOURCE_OF_TRUTH.json`
   - `swap-features.json`
   - `asset-replacement-contract.md`
6. Execute by **replacement units**, not product features.
7. After execution, run the later evaluation pass:
   - UI review
   - verification work
   - PASS / FLAG / BLOCK checks

## Stop conditions
Stop immediately if the implementation starts altering:
- GSAP or framer-motion timelines
- cursor behavior
- layout shell
- section ordering
- spacing system
- breakpoint system
