## Workflow Orchestration

### 1. Plan Mode Default

- Enter plan mode for any NON trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately - don't keep pushing.
- Use plan mode for verification steps, not just building.
- Write detailed specs upfront to reduce ambiguety.

### 2. Subagent Strategy

- Use subagents liberally to keep the main context clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute via subagents.
- One task per subagent for focused execution.

### 3. Self Improvement Loop

- After any correction from the user, update tasks/lessons.md with the pattern.
- Write rules for yourself that prevent the same mistake.
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project.

### 4. Verification Before Done

- Never mark a task as completed without proving it works.
- Diff behavior between main and your changes when relevant.
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, verify correctness.
- Ask to the user for the definition of correctness if is not clear.

### 5. Autonomous Bug Fixing

- When given a bug report, just fix it. Don't ask for hand holding.
- Point at logs, errors, failing tests - then resolve them.
- Zero context switching required from the user.

### 6. Task Management

**Plan First** Write plan to tasks/todo.md.
**Verify Plan** Check in before starting implementation
**Track Progress** Mark items complete as you go
**Explain Changes** High-level summary at each step
**Document Results** Add review sections to tasks/todo.md
**Capture Lessons** Update `tasks/lessons.md` after corrections

### 7. Core Principles

**Simplicity First** Make every change as simple as possible.
**No Laziness** Find root causes. No temporary fixes. Senior Developer standards.
**Minimal Impact** Changes should only change what's necessary. Avoid introducing bugs.
