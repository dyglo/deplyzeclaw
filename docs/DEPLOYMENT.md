# Deployment Plan

Deplyze should roll out in two phases:

1. Pilot on the current Linux/WSL2 machine.
2. Expand to external access only after the pilot is stable.

## Phase 1: Pilot

Use the current machine as the deployment target.

Keep these constraints in place:

- Gateway bound to loopback only.
- Control UI not exposed publicly.
- One unattended job only: `scripts/overnight-check.sh`.
- Daily reports stored under `workspace/reports/`.

## Success Criteria

Run the pilot for 3 to 7 nights. Promote only if:

- The gateway starts cleanly each day.
- The dashboard stays reachable on `127.0.0.1`.
- The overnight report completes without recurring failures.
- There is no repeated config drift or channel instability.

## Phase 2: External Access

Only after the pilot is stable:

- Prefer Tailscale Serve first.
- Use SSH tunneling if you want the simplest private path.
- Do not expose the Control UI directly to the public internet as the first external step.

## Rollback Path

If the pilot misbehaves:

1. Stop the gateway.
2. Disable the unattended job.
3. Review the latest report in `workspace/reports/`.
4. Revert the last repo change only if the failure is caused by the repo itself.
5. Restore `~/.openclaw` from backup only if OpenClaw state is corrupted.

## Operator Loop

Each morning:

1. Read the latest report.
2. Check for repeated warnings or failures.
3. Record the result.
4. Decide whether to keep the pilot running or promote to phase 2.
