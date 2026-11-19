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
7. If `gh` isn't available on the current machine, fall back to plain `git`: don't install or improvise tooling (no `nix run`, `brew install`, etc.). Commit and `git push -u origin <branch>`, then display the compare URL (`https://github.com/<owner>/<repo>/pull/new/<branch>`, built from `git remote get-url origin`) for Walter to open the PR himself.

## 7. Cross-Repo Work: Delegate to Herdr Sessions

When asked to do something in another repo (or the task requires touching one), the work goes through a **herdr session** for that repo:

1. **Check first:** Use `ListAgents` to see whether a herdr session/agent is already running for that repo (matching its name or working directory).
2. **If one exists:** Delegate the work to it via `SendMessage` instead of working in that repo yourself. Give it a self-contained brief (goal, ticket, acceptance criteria).
3. **If none exists:** Ask Walter to help create a herdr session for that repo (he starts it; you don't launch it yourself), then use that agent as a sub-agent / collaboration agent and delegate to it.
4. **Report only when ready:** Don't relay intermediate chatter. Once the agent finishes, report the result: the PR link for review (if code changed) or the findings (if research only).
5. **Be machine-agnostic:** Walter works on both a NixOS homelab and a Mac. Don't assume OS-specific paths, package managers, or installed tools; rely on what's available in the current environment.

## 8. Capture Decisions & Research in the Notes Vault

The notes repo (`wchavarria03/notes`, plain Markdown `.md` files; Obsidian provides the bi-directional linking and graph view) is Walter's centralized memory for anything that happens in his life, work, or research. Never write there directly from another repo's session; delegate.

1. **When to capture:** Whenever a decision is made (architecture, tooling, trade-offs, "we chose X over Y because Z"), or research produces results worth keeping (findings, comparisons, commands that worked, gotchas).
2. **How:** If a herdr notes session is running (`ListAgents`), send it a self-contained summary via `SendMessage` (what, why, outcome, links such as PR/ticket). Otherwise, on the homelab use `/home/walter/notes/bin/capture "<what happened>"`. On any other machine, tell Walter it's worth a note and give him the summary to capture himself.
3. **Review via PR only:** Walter reviews the final note, not drafts. Don't relay proposals, local files, or intermediate states for approval. Have the notes agent finish the write and open the PR (never merged), and give Walter only the already-created PR link.
4. **Don't over-capture:** Skip routine edits, trivial fixes, and anything already recorded in the repo's own code or git history. Capture the *why*, not the *what*.
5. **Never include secrets** in a note.

## 9. Ticket Worktrees (Herdr app)

- **Every request to work on a new ticket** gets its own git worktree and its own Herdr app space, with one Claude session per worktree. Do not start the ticket in the main checkout or in another ticket's worktree. If this session is already in that ticket's worktree, do not create another. The repo's `CLAUDE.md` gives the branch name, base and worktree path.
- **Create the worktree** with `git worktree add -b <branch> <path> <base>`, then the space with `herdr-app do space.new --name <TICKET> --folder <worktree path> --argv '["claude"]' --task "<what to do>" --focus false`. Name the space after the ticket key (e.g. `GDT-927`). Use `herdr-app ls` for space ids. Never use the `herdr` CLI (`herdr worktree`, `herdr workspace`): it was the terminal UI, now removed, and never reached the app.
- **Once the PR is merged and the ticket is closed,** close the space (`herdr-app do space.close --id <space id> --confirmed true`; check `herdr-app commands` if the flag form is rejected), remove the worktree (`git worktree remove <path>`) and delete the branch if it is still there. Never remove a worktree that has uncommitted work, or before the merge and the close.
- This section covers ticket work Claude starts itself. Section 7 still governs delegating to another repo's already-running session.
