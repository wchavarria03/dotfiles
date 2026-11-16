#!/usr/bin/env bash
# hc-wait-idle <terminal> [quiet_seconds=2] [max_seconds=180]
#
# `hc wait` only auto-detects completion for true parent-child
# terminals (confirmed empirically: it times out for independent
# peer terminals even after their turn clearly finished). This works
# for ANY terminal by watching `hc events` and treating a quiet
# period (no new events) as "settled" -- the gap flagged while
# validating herdr-core for the Aegis delegation workflow.
set -uo pipefail

terminal="${1:?usage: hc-wait-idle <terminal> [quiet_seconds] [max_seconds]}"
quiet="${2:-2}"
maxwait="${3:-180}"
hc="${HC_BIN:-herdr-core}"

_watch() {
  "$hc" events --terminal "$1" --json 2>/dev/null | \
    while IFS= read -r -t "$2" _line; do :; done
}
export -f _watch
export hc

timeout "$maxwait" bash -c '_watch "$1" "$2"' _ "$terminal" "$quiet"
status=$?

if [[ $status -eq 124 ]]; then
  echo "hc-wait-idle: timed out after ${maxwait}s waiting for '$terminal' to go idle" >&2
  exit 1
fi

echo "hc-wait-idle: '$terminal' is idle"
