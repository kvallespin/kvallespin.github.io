#!/usr/bin/env bash
# Mirror the fresh Quartz build (public/) into the repo ROOT — which is what GitHub Pages
# actually serves for this site. Run this AFTER `npx quartz build` and BEFORE committing.
#
# Why: Pages is set to "Deploy from a branch", so the branch builder serves the committed
# build at the repo root. public/ alone is not served. See ../references/deploy.md.
#
# Safe by construction: it only replaces top-level entries that exist in public/ (the built
# site). Source dirs (content/, quartz/, .quartz/, node_modules/, .claude/, configs) are not
# in public/, so they are never touched.
#
# Usage: bash mirror_to_root.sh [repo-path]   (defaults to current dir, else the known repo)
set -euo pipefail
shopt -s nullglob

REPO="${1:-}"
if [ -z "$REPO" ]; then
  if [ -f "quartz.config.ts" ] || [ -d "public" ]; then REPO="$(pwd)"; else REPO="/c/Users/kenne/kvallespin.github.io"; fi
fi
cd "$REPO"
[ -d public ] || { echo "ERROR: no public/ in $REPO — run 'npx quartz build' first." >&2; exit 1; }

# 1) Remove stale top-level hashed build artifacts (a new build emits different hashes).
rm -f ./index-*.css ./component-*.css ./prescript-*.js ./postscript-*.js

# 2) Replace each top-level entry from public/ at the root.
for entry in public/*; do
  name="$(basename "$entry")"
  if [ -d "$entry" ]; then
    rm -rf "./$name"
    cp -r "$entry" "./$name"
  else
    cp -f "$entry" "./$name"
  fi
done

echo "Mirrored public/ -> repo root ($REPO)."
echo "Next: stage source + 'git add -f public/' + the root built files, and stage any deletions:"
echo "  git status -s | grep -E '^ D ' | grep -vE 'public/' | sed -E 's/^ D //' | while read -r f; do git add -- \"\$f\"; done"
