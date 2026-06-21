# Pre-publish & post-deploy checklist

## Before building (content)
- [ ] No `<br>`, inline `style=`, `font-family`, `text-align`, `wp-block`, `aligncenter`.
- [ ] No `pinoy` / `pinoype` / `pinoype.com` anywhere.
- [ ] No old `_files/` image paths; every `![](assets/…)` resolves to a real file.
- [ ] Images are block-level with italic captions; paragraphs read as continuous prose.
- [ ] `import-manifest.json` updated for any added/restored/redacted asset.
- [ ] Any restored credential/ID image is redacted (DOB, email, IDs, address).

Quick scans (run from repo root):
```bash
cd content/engineering
grep -niE '<br|style=|font-family|text-align|wp-block|aligncenter|pinoy|_files/' <slug>.md   # expect empty
# every image path resolves:
grep -oE '!\[\]\(assets/[^)]+\)' <slug>.md | sed -E 's/!\[\]\((.*)\)/\1/' | while read p; do [ -f "$p" ] || echo "MISS $p"; done
```

## Vault mirror
- [ ] Cleaned `.md` copied to `C:/KVault Prime/Public Web/Engineering/<Display Name>.md`.
- [ ] New/changed assets copied to the vault's parallel `assets/<folder>/` (same relative paths).
- [ ] `diff -q` shows the vault `.md` is identical to the Quartz `.md`.

## Build & mirror
- [ ] `npx quartz build` succeeded.
- [ ] `scripts/mirror_to_root.sh` run — repo root now matches `public/`.
- [ ] Root post HTML references the new `index-*.css` and has the expected image count.

## Commit (push only if explicitly asked)
- [ ] `.tmp_*` scratch files NOT staged.
- [ ] `public/` staged with `git add -f`; root built files + deletions staged.
- [ ] Commit message ends with the required `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>` trailer.
- [ ] `.github/workflows/deploy.yml` NOT modified.

## Post-deploy (live)
- [ ] Each page returns `200` (poll through CDN with `?cb=$RANDOM`).
- [ ] `https://kvallespin.github.io/assets/fonts/freesans.ttf` returns `200`.
- [ ] Active deployment SHA == your commit (deployments API).
- [ ] Served HTML has no `pinoy` / `_files/` / `text-align:center|justify`.
- [ ] Image counts correct; restored/redacted images verified by re-fetching live.
- [ ] Old build's previous `index-<oldhash>.css` returns `404` (when CSS changed).
