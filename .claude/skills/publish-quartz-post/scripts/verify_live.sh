#!/usr/bin/env bash
# Verify the LIVE kvallespin.github.io site after a deploy.
# Usage: bash verify_live.sh [section/slug ...]
#   e.g. bash verify_live.sh engineering/unlocking-the-pe engineering/unlocking-the-apec-engineer
# Defaults to the two engineering posts if no slugs are given.
set -uo pipefail
BASE="https://kvallespin.github.io"
SLUGS=("$@")
if [ ${#SLUGS[@]} -eq 0 ]; then
  SLUGS=(engineering/unlocking-the-apec-engineer engineering/unlocking-the-pe)
fi

echo "== Pages (HTTP + forbidden-string scan) =="
for s in "${SLUGS[@]}"; do
  url="$BASE/$s"
  code=$(curl -s -o /tmp/_vl.html -w '%{http_code}' "$url?cb=$RANDOM")
  bad=$(grep -ioE 'pinoy[a-z. ]*|_files/|text-align:[^;"]*(center|justify)' /tmp/_vl.html | sort -u | tr '\n' ' ')
  imgs=$(grep -coE '<img[^>]+>' /tmp/_vl.html)
  printf "  %s  %s  imgs=%s  %s\n" "$code" "$url" "$imgs" "${bad:+[FORBIDDEN: $bad]}"
done

echo "== Fonts (expect 200) =="
for f in freesans freesansbold freesansoblique freesansboldoblique; do
  printf "  %-22s %s\n" "$f.ttf" "$(curl -s -o /dev/null -w '%{http_code}' "$BASE/assets/fonts/$f.ttf?cb=$RANDOM")"
done

echo "== Active github-pages deployment SHA =="
curl -s "https://api.github.com/repos/kvallespin/kvallespin.github.io/deployments?environment=github-pages&per_page=1" \
  | grep -oE '"sha": "[0-9a-f]+"' | head -1

echo "Tip: compare that SHA to 'git rev-parse HEAD'. For redacted images, re-fetch them live and eyeball the redaction."
