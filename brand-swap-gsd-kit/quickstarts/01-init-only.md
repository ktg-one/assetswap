# Quickstart 01 — Init Only / No Assets Yet

Use this when the site is scaffolded but you do **not** yet have the brand pack.

## Goal
Create the truth-source artifacts and stop before implementation.

## Steps
1. Copy the workflow JSON into `.vscode/workflows/`.
2. Create `.plan/SOURCE_OF_TRUTH.json` from the template.
3. Create `docs/plans/<date>-swap-features.json` from the template.
4. Run `app-spec-agent` first.
5. Persist the output as `swap-inventory.md`.
6. Run `Init-agent` second.
7. Persist the output as `asset-replacement-contract.md`.
8. Fill `swap-features.json` with:
   - paths
   - replacement types
   - dimensions
   - constraints
   - statuses
9. Mark each swap unit as:
   - `ready`
   - `pending_asset`
   - `blocked`
10. Stop in **planning-only mode**.

## Expected result
You now know exactly what assets you need to gather for this site before GSD execution starts.
