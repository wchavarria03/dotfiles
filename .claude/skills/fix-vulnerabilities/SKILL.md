---
name: fix-vulnerabilities
description: Scan the current repository for known vulnerabilities with grype, summarize the findings with their fixes, and apply the safe ones. Use when the user asks to check, fix or triage vulnerabilities, Dependabot alerts, grype or security dashboard findings, or CVE and GHSA ids.
---

# Fix vulnerabilities

Scan the current folder with grype, summarize what it found and how to fix it, then apply the fixes that follow the rules below.

## Rules (never break these)

1. **Stable releases only.** Never move to an alpha, beta or release candidate (`-rc`, `-beta`, `-alpha`, `-dev`), and never to a pseudo-version of an unreleased commit (Go `v0.58.1-0.2026...`). Grype lists these next to the stable fixes; ignore them.
2. **Never downgrade** a library, language runtime, toolchain or base image to remove a finding. Only move up from the current version.
3. If the only fix is a pre-release or a downgrade, **leave the finding open** and report it as needing a Dismiss or Risk Registry request with a written reason. Do not hide it.
4. **Minimal change.** Touch only the dependency files, toolchain pins and base images the findings need. Do not refactor.
5. **Do not commit or push** until the user has run the tests and the linter and says so. Do not run the project's tests yourself if the project's memory or CLAUDE.md says the user runs them; build or compile only.

## Steps

### 1. Review the folder and find the language

- Run `git status`, `git branch --show-current`, and look at the top-level files.
- Detect the stack from manifests. A repo can have several; handle each one.

| Marker | Language | Where the fix lives |
|---|---|---|
| `go.mod` | Go | `go.mod` / `go.sum`, the `go` directive, Dockerfile builder image, CI `language-version` |
| `uv.lock` + `pyproject.toml` | Python (uv) | raise the floor in `pyproject.toml` and run `uv lock --upgrade-package <name>`; commit `uv.lock`; check with `uv lock --check` |
| `requirements*.txt`, `Pipfile` | Python (pip) | the pinned version in the file, Dockerfile base image |
| `package.json` + lockfile | Node | `package.json` and the lockfile |
| `pom.xml`, `build.gradle` | Java | the dependency version |
| `Gemfile.lock` | Ruby | `Gemfile` / lockfile |
| `Dockerfile` | any | the `FROM` image tag |

- If the user gave finding ids (CVE, GHSA, GO-xxxx) or a screenshot, keep that list to map findings back at the end.
- If the branch name has a ticket id, read the ticket for the list of findings.

### 2. Scan with grype

- Check it is installed: `which grype`. If not, tell the user to `brew install grype` and stop.
- Scan **sources, not build output**. Local virtualenvs, `node_modules` and old built binaries produce stale findings. Look first for them (`.venv`, `node_modules`, a compiled binary in the tree). Rebuild the binary, or scan a subdirectory, so the result reflects the manifests:

```bash
grype dir:<path> --only-fixed -o table          # readable
grype dir:<path> -o json                        # for grouping by package and location
```

- With the JSON, group by package, installed version and file path (`artifact.locations`). A finding whose only location is `.venv/`, `node_modules/` or a binary is not from a tracked file: say so, and rescan after rebuilding if it is a binary.
- Run it again without `--only-fixed` to list findings that have no fix at all.
- Go: `govulncheck ./...` shows which advisories are actually reachable. Use it to rank, not to skip.

### 3. Decide the fix for each finding

First look for a newer stable line, not only a patch (see "Newer stable majors and minors" below).

For each package and installed version, take the `fix.versions` list from grype and pick:

- the **highest stable** version in the list that is **at or above the installed one**, and covers all of that package's findings;
- the exact latest stable patch of the same line when the list is per minor line (for example `1.25.13`, `1.26.6`, `1.26.9`: stay on the installed minor line and take the newest patch that fixes everything).

Language-specific points:

- **Go standard library.** Findings on `stdlib` are fixed by the Go version, not by a module. Bump the `go` directive in `go.mod` (`go get go@<version>`), pin the Dockerfile builder image to that exact patch, and check the CI workflow's language version. Many findings that look like `golang.org/x/net` also appear as `stdlib`: one toolchain bump can clear both.
- **Go modules.** `go get <module>@<version>`, then `go mod tidy`. Read the `go.mod` diff and confirm nothing went down.
- **Python with uv.** Do not edit `uv.lock` by hand. Raise the dependency floor in `pyproject.toml` (or leave it if the range already allows the fix), run `uv lock --upgrade-package <name>`, and check that the lock only moved up. If the repo still has a `requirements.txt` next to `uv.lock`, it can drift: say so in the report.
- **Python with pip.** Edit the pin in the requirements file. If the package is only pinned transitively, pin it or raise the parent.
- **Base images.** Prefer a specific patch tag over a floating one when the finding is in the runtime; do not move to a lower tag.

#### Newer stable majors and minors

Grype's fix list usually names a patch on the installed line. For the **main packages** (the language runtime or toolchain, the base images, the web framework, and any dependency that carries most of the findings), also check whether a newer stable major or minor line exists, and suggest it instead of stopping at the patch:

- Go: `curl -s "https://go.dev/dl/?mode=json"` lists the stable releases (`"stable": true`). Python: the newest stable `3.x` on python.org or the image registry. Libraries: `go list -m -versions <module>`, `pip index versions <package>`, `npm view <package> versions`.
- Ignore pre-releases in every list (rule 1).
- Say what the newer line fixes beyond the patch (findings that only it clears, a longer support window) and what it risks (breaking changes, release notes, the config files below).
- A patch bump on the installed line is applied. A **major** bump (or a minor bump of the language runtime) is a recommendation: give the user the choice, with the patch fix as the fallback, and apply it only when they say so. If they already asked for the latest stable, apply it.
- Never present this as a downgrade path: the suggestion is always upward.

#### Files that may matter when the language or runtime version changes

A version bump such as Go 1.26 to 1.27 is more than `go.mod`. Check every one of these and change only what is out of step:

| File | What to check |
|---|---|
| `go.mod` (`go` directive), `pyproject.toml`, `.python-version`, `.go-version`, `.tool-versions`, `.nvmrc` | the declared language version |
| `Dockerfile` (every `FROM`) | builder and runtime image tags; pin to the exact patch where the finding is in the runtime; check the tag exists in the registry |
| `.github/workflows/*.yml` | `language-version`, `go-version`, `python-version`, `linter-version` inputs, and what the shared workflow does with them (read the called workflow, for example `setup-go` and the lint action) |
| Linter config and version (`.golangci.yml`, `linter-version`) | an old linter can refuse a module on a newer language version; use the latest stable linter and compare with the local one |
| `.cicd/deployments/*.yml` (deploy and PE config) | image tags (`latest` versus a pinned tag), runtime pins, the `command` and `args` a cronjob runs from the same build; resources are not affected by a version bump but check them |
| `Makefile`, scripts, pre-push or pre-commit hooks | hard-coded versions or tool paths |
| Local toolchain (`go version`, `asdf list`, `.tool-versions`) | the developer needs the new version installed, or auto-download enabled |
| Docs (`README`, `CLAUDE.md`) | any text that states the version |

Report which of these were checked, which changed, and which need the user (shared workflows owned by another repo, deployment config someone else owns).

### 4. Apply

- Make the edits from step 3. Use the package manager commands where they exist.
- Verify without running the user's test suite: `go build ./...`, `go vet`, `pip install --dry-run -r requirements.txt`, `npm ls`, or the equivalent compile check.
- Rebuild any binary the scan read, and rescan the same path. Confirm the findings are gone and list what remains.
- Show `git diff` of the manifests and check for any version that went down.

### 5. Report

Give the user a short summary, in this order:

1. **Fixed**: package, from version, to version, findings cleared (id and severity). Group by package.
2. **Not fixed**, each with the reason: only a pre-release or a downgrade fixes it, no fix exists yet, or the finding comes from a stale local artifact. For these, name the dashboard action (Dismiss or Risk Registry) and the text to put in it.
3. **Newer stable lines**: for each main package, the newest stable major or minor, what it adds over the patch fix, and its risks. State clearly whether it was applied or is only a recommendation.
4. **Config files checked**: the files from the table above, with what changed.
5. **Needs the user**: findings that were in the user's list but grype does not report (often the base image), a finding list that was cut off in a screenshot, CI versions that float.
6. **Verification**: what was built or checked, what the rescan shows, and what the user still has to run (tests, linter).

Keep it to the findings and their fixes. Do not paste the whole grype table.

## Pitfalls

- A stale `server/<binary>` or `.venv` makes the scan report versions the manifests no longer have. Check locations before trusting a result.
- `go get` of one module can raise several others; that is fine when they only go up.
- Grype's "fixed in" list can include the pseudo-version for a module that has no tagged fix yet. That is a "not fixed" finding under rule 1.
- Fixing to the newest patch of the old line and calling it done hides that a newer stable line exists. Always run the newer-line check for the main packages.
- A language bump that leaves CI or the linter on the old version fails in CI, not locally. Read the shared workflow the repo calls.
- Do not add the ticket number to code comments; keep it in the commit and PR.

## Moving a Python repo from pip to uv (when the user asks)

Reference: `ltvco/mcp-gsc` has the right layout (`pyproject.toml`, committed `uv.lock`, Dependabot `uv` PRs) but a weak Dockerfile and CI. Do this instead:

1. `pyproject.toml` with `requires-python` set to the version actually run; keep the old dependency versions in the first PR. Applications: `[tool.uv] package = false`, no build system. Libraries and CLIs keep the build system.
2. `uv lock`; check it resolves to the same versions as the old `requirements.txt` (`uv export --no-hashes`), then commit `uv.lock`.
3. Dockerfile: pin the uv image version, copy `pyproject.toml` **and `uv.lock`** first, run `uv sync --locked --no-dev --no-install-project`. mcp-gsc skips `uv.lock` and `--locked`, so its builds re-resolve every time.
4. One Python version everywhere: `.python-version`, `.tool-versions`, `requires-python`, Dockerfile, devcontainer, CI. mcp-gsc has four different ones.
5. Delete `requirements.txt` (or generate it with `uv export`); update README and `CLAUDE.md` to `uv sync` / `uv run`.
6. CI: `astral-sh/setup-uv`, `uv lock --check`, and a test job if the repo has tests.
7. Dependabot: add `package-ecosystem: "uv"` for the project directory.
8. Verify: `uv lock --check`, the image builds, the app starts and its health endpoint returns 200, grype on the image and `uv.lock`.
