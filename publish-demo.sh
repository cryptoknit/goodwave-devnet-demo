#!/usr/bin/env bash
set -euo pipefail
SRC="$HOME/runwell/projects/goodwave/staking"
DST="docs/data"
mkdir -p "$DST"

# copy fresh data
cp -f "$SRC/index.json" "$DST/index.json"
cp -f "$SRC/payouts/ledger.tsv" "$DST/ledger.tsv"

# commit only if changed
if ! git diff --quiet -- "$DST/index.json" "$DST/ledger.tsv"; then
  git add "$DST/index.json" "$DST/ledger.tsv"
  git commit -m "data: $(date -u +%FT%TZ)"
  git push origin main
  echo "[pushed] $(date -u +%T) → Pages updated"
else
  echo "[no-change] $(date -u +%T)"
fi
