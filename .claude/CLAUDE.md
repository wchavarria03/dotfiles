# GLOBAL RULES

## 1. Jira & Branch Context Protocol

- **Auto-Context Initialization:** At the start of every session, check the current git branch name for identifiers.
- **Ticket Extraction:** If the branch contains a pattern like `GDT-XXX`, use the `atlassian` MCP tool to fetch ticket details (Summary, Description, and Acceptance Criteria).
- **Context Summary:** Summarize immediately: "I see we are on branch [GDT-XXX], working on [Title]. The goal is [X]."
- **No ticket found:** Notify the user and continue normally.

## 2. Workflow Orchestration

- **Plan Mode Default:** For any non-trivial task (3+ steps), write a plan to `.claude/plans/GDT-XXX.md` and verify it with the user before starting.
- **Subagent Strategy:** Offload research or parallel analysis to subagents. One task per subagent.
- **Self-Improvement Loop:** After any user correction, update `.claude/lessons.md` with the pattern to prevent repeating the same mistake.

## 3. Task Management & Verification

- **Plan First:** Always verify the plan with the user before implementation.
- **Track Progress:** Mark items complete in the active plan file as you go.
- **Verification:** Never mark a task completed without proving it works — tests, logs, or git diffs.
- **No Laziness:** Find root causes. No temporary fixes.

## 4. Tool Selection & Token Efficiency

Prefer CLI tools over MCP tools whenever both can do the same job — CLI responses are compact and filterable; MCP tools return full API payloads and require a schema-load round-trip via `ToolSearch`.

| Task | Prefer | Avoid |
|---|---|---|
| GitHub — read PR, comments, diff | `gh api <endpoint> --jq '...'` | `mcp__github__*` |
| GitHub — create/update PR, post comment | `gh api <endpoint> --method POST/PATCH` | `mcp__github__*` |
| Jira — fetch ticket, transition, comment | `mcp__atlassian__*` | (no CLI alternative) |
| Confluence — read/write pages | `mcp__atlassian__*` | (no CLI alternative) |
| Git operations | `git` via Bash | any MCP |

**Rules:**
- Always pipe `gh api` through `--jq` to return only the fields actually needed.
- MCP GitHub tools are acceptable only for operations that `gh` cannot express (e.g. complex GraphQL queries).
- Token budget saved on tooling goes toward deeper reasoning and larger context windows.

## 5. Core Principles

- **Simplicity First:** Make every change as simple as possible.
- **Minimal Impact:** Only change what is necessary. Avoid regressions.
- **Persistence:** All tracking files live in `.claude/` of the active project.

## 6. Git & PR Workflow (every repo)

Standing instruction for every repository, overriding the default "commit only when asked":

1. Never change the default branch (`main`/`master`) directly. Work on a feature branch named `<type>/<TICKET-ID>-<short-kebab-case-description>` (e.g. `feat/GDT-333-add-user-auth`). `<type>` is a conventional commit type (`feat`, `fix`, `docs`, `chore`, ...). Take the ticket ID from the current branch or the task; if there is no ticket, omit it (e.g. `docs/claude-branch-naming`).
2. After every change you make to a repo, commit it (conventional commit style, matching `git log`).
3. Push the branch and open a PR against the repo's default branch with `gh pr create`.
4. Display the PR URL for review. Never merge it.
5. Applies to any repo, including ones with no prior PR history. No need to ask first.
6. If a repo's own `CLAUDE.md` or a hook forbids this (e.g. a guard on `main`), follow the repo and say so.

## 7. Cross-Repo Work: Delegate to Herdr Sessions

When asked to do something in another repo (or the task requires touching one), the work goes through a **herdr session** for that repo:

1. **Check first:** Use `ListAgents` to see whether a herdr session/agent is already running for that repo (matching its name or working directory).
2. **If one exists:** Delegate the work to it via `SendMessage` instead of working in that repo yourself. Give it a self-contained brief (goal, ticket, acceptance criteria).
3. **If none exists:** Ask Walter to help create a herdr session for that repo (suggest he start it, e.g. with `! <command>`), then use that agent as a sub-agent / collaboration agent and delegate to it.
4. **Report only when ready:** Don't relay intermediate chatter. Once the agent finishes, report the result: the PR link for review (if code changed) or the findings (if research only).
