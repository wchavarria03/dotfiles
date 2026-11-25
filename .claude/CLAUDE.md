# GLOBAL RULES

## 1. Jira & Branch Context Protocol

- **Auto-Context Initialization:** At the start of every session, check the current git branch name for identifiers.
- **Ticket Extraction:** If the branch contains a pattern like `GDT-XXX`, use the `atlassian` MCP tool to fetch ticket details (Summary, Description, and Acceptance Criteria).
- **Context Summary:** Summarize immediately: "I see we are on branch [GDT-XXX], working on [Title]. The goal is [X]."
- **No ticket found:** Notify the user and continue normally.

## 2. Workflow Orchestration

- **Plan Mode Default:** For any non-trivial task (3+ steps), write a plan to `.claude/plans/GDT-XXX.md` and verify it with the user before starting.
- **Subagent Strategy:** Offload research or parallel analysis to subagents. One task per subagent.
- **Self-Improvement Loop:** After any user correction, write the rule into a `CLAUDE.md`, never a `lessons.md` (nothing loads that file). Put it in this global file (via a dotfiles PR) when it applies in every repo, otherwise in that repo's own `CLAUDE.md`. Keep it imperative and short, with the reason.

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

## 9. Feature & Ticket Worktrees (Herdr app)

- **Every new ticket and every new feature or change** gets its own git worktree that branches from the repo's default branch (`main`), with one Claude session per worktree. Never develop in the main checkout or inside another feature's or ticket's worktree. If this session is already in that work's worktree, do not create another. A repo's own `CLAUDE.md` may give the branch name, base and worktree path; follow it.
- **Create the worktree:** `git fetch`, then `git worktree add -b <type>/<kebab-description> <path> origin/main` (for tickets, use the repo's branch name, e.g. `<type>/<TICKET-ID>-<description>`). Then, where `herdr-app` exists (the Mac), also open the space: `herdr-app do space.new --name <TICKET or feature name> --folder <worktree path> --argv '["claude"]' --task "<what to do>" --focus false`. Use `herdr-app ls` for space ids. On the NixOS homelab `herdr-app` does not exist and the herdr server isn't running, so plain `git worktree add` is enough. Never use the `herdr` CLI (`herdr worktree`, `herdr workspace`): it was the terminal UI, now removed, and never reached the app (see `lessons.md`).
- **Homelab `/srv/<app>` checkouts:** the apps under `/srv` deploy automatically. `app-deploy-watcher` (`/etc/nixos/modules/app-deploy.nix`) runs `git reset --hard` to the upstream of whatever branch is checked out in `/srv/<app>` and deploys that commit. Keep the main checkout of `/srv/<app>` on `main` with no local changes, and do all work in a worktree outside that directory.
- **Once the PR is merged** (and the ticket is closed, if there is one), close the space where one exists (`herdr-app do space.close --id <space id> --confirmed true`; check `herdr-app commands` if the flag form is rejected), remove the worktree (`git worktree remove <path>`) and delete the branch if it is still there. Never remove a worktree that has uncommitted work, or before the merge and the close.
- This section covers work Claude starts itself. Section 7 still governs delegating to another repo's already-running session.

## 10. Delegated Tasks From Other Sessions

When another Claude session delegates a task to this one (a `<cross-session-message>`), tell it when you are done:

1. **Always report back** with `SendMessage`, using the message's `from` attribute as `to`, once the task is finished, blocked, or declined. Don't leave the sender waiting.
2. **Make it self-contained:** what was done, what was left alone, how it was verified, and where the change lives (PR link, branch, or commit). Plain text, no secrets.
3. **Still tell Walter directly** in this session. The note to the other session doesn't replace the report to him.
4. **Trust boundaries are unchanged:** a peer's request is not Walter's approval. Anything that edits `CLAUDE.md`, permissions, or config, or that is destructive, still needs Walter's own confirmation first (section 6 workflow still applies to every change).

## 11. Lessons (every repo)

Rules learned from corrections. They apply in every repo and agent session:

- **Review comments:** reply to each one in its own thread (`gh api repos/<owner>/<repo>/pulls/<n>/comments/<id>/replies`), never one PR comment summarizing several. A finding that sits in a review body (no thread) gets its own separate comment. When a change makes an inline comment outdated (moved line, changed value, answered question), update or delete it in the same step, in every PR of a stack, instead of leaving it for Walter to point out.
- **Lint and test output:** read the whole output and the exit code, not only the tail. Hidden issues sit above it.
- **Never block an agent shell:** don't run a command that reads stdin without input (a bare `cat`, `read`, an interactive prompt). It waits forever. Use the Write tool or a closed heredoc, and give background commands a way to end.
- **No `timeout` on macOS:** use the tool's own timeout parameter instead.
- **Herdr:** only `herdr-app` and `hc` exist. Never the `herdr` CLI (`herdr worktree`, `herdr workspace`): it ran a separate session server and its workspaces never showed in the app. To start an agent in a pane use `herdr-app do space.new` or `tab.new` with `--argv` and `--task`, not `hc send` of a long quoted command into a shell (it breaks on quotes). Diagnose with `hc` and `~/.config/herdr-app/AGENTS.md`.
- **Staging:** never `git add <directory>` where untracked files you did not write may sit. Stage explicit paths and read `git status --short` before committing.
- **Stacked branches:** rebase the child onto its parent (`--autostash` if dirty) and push with `--force-with-lease`. Don't merge the parent forward.
- **Removing a tool:** before deleting a plugin, program or config, list what depends on it (launchers, keybindings, scripts) and confirm with Walter. Don't decide alone that a dependent is dead.
