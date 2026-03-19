# Autonomy Playbook

Deplyze is designed to keep working while you sleep, but only inside a narrow and safe envelope.

## Default Rules

- Stay local by default.
- Inspect before modifying.
- Prefer read-only work unless the task explicitly asks for a write.
- Keep changes small, reversible, and documented.
- Never send public messages, emails, or posts without explicit approval.
- Never use destructive commands unless the task is clearly a cleanup and the impact is understood.

## What The Assistant May Do Unattended

- Check repo health and summarize drift.
- Draft docs or task lists in the workspace.
- Verify OpenClaw config, gateway, and channel status.
- Create non-destructive reports in the workspace.
- Prepare follow-up work for review.

## What Requires Approval

- Git push.
- Public exposure of the Gateway or Control UI.
- Deleting credentials or session state.
- Changing network exposure away from loopback.
- Any command that mutates state outside the repo or workspace.

## First Sleep Job

Start with a read-only health check:

```bash
scripts/overnight-check.sh
```

It should:

1. Inspect the repo status.
2. Check OpenClaw and Gateway health.
3. Record any warnings or drift.
4. Save the report under `workspace/reports/`.

## Completion Contract

- If there are no findings, reply `HEARTBEAT_OK`.
- If there are findings, return the report path and the one next action.
- If blocked, return a single concrete unblock step.

## Suggested Unattended Jobs

- Daily repo health summary.
- OpenClaw config verification.
- Dependency/version drift review.
- Doc cleanup and follow-up drafting.
- A short “what changed overnight” report.
