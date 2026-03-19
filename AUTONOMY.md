# AUTONOMY.md - Deplyze Operating Rules

Use this workspace as the place where the assistant can work safely while the human is away.

## Default Mode

- Stay local by default.
- Inspect before modifying.
- Keep changes small and reversible.
- Prefer reports over silent actions.

## Safe Unattended Work

- Repo health checks.
- Doc drafting and cleanup.
- Safe config verification.
- Workspace note generation.
- Summaries of what changed and what still needs attention.

## Approval Required

- Git push.
- External posts or messages.
- Public exposure of the Gateway.
- Deleting credentials or wiping session state.
- Any destructive cleanup outside the workspace.

## First Sleep Job

Run the read-only overnight check:

```bash
scripts/overnight-check.sh
```

It writes a report to `workspace/reports/` and should be the first unattended job before more advanced automation.

## Completion Rule

If there are no findings, reply `HEARTBEAT_OK`.
If there are findings, report the path and the one next action.
