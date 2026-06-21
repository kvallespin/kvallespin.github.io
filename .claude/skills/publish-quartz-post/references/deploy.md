# Deploy model & pitfalls

## What actually serves the live site

GitHub Pages for this repo is configured as **"Deploy from a branch"**, so the built-in
GitHub Pages **branch builder serves the repo ROOT**. A full built copy of the Quartz site is
committed at the root: `index.html`, `404.html`, `sitemap.xml`, `index.xml`, `profile.html`,
hashed `index-*.css` / `component-*.css` / `prescript-*.js` / `postscript-*.js`, `CNAME`,
`favicon.ico`, the `-og-image.webp` files, and the built section directories
(`assets/ data-science/ design/ engineering/ finance/ projects/ reviewers/ static/ tags/`).

`public/` is just Quartz's build output directory. It is committed too, and `deploy.yml`
uploads it as a Pages artifact — but because the **branch builder** is also active and serves
the root, **the root is what visitors get**. Rebuilding `public/` without mirroring to root
changes nothing live.

→ **Always run `scripts/mirror_to_root.sh` after `npx quartz build`.** It deletes the orphaned
top-level hashed build files and replaces each top-level built file/dir at the root with the
fresh one from `public/`. Source dirs (`content/`, `quartz/`, `.quartz/`, `node_modules/`,
`.claude/`, configs) are not in `public/`, so they're never touched.

## The dual-deploy race

Both pipelines create deployments to the `github-pages` environment with
`concurrency: group=pages, cancel-in-progress=false`:
- **GitHub Actions** (`deploy.yml`) — deploys the `public/` artifact.
- **GitHub Pages branch app** ("pages build and deployment") — deploys the root.

A stale queued run can finish *last* and publish an older commit, so a deploy can appear to
"go backwards." This is why mirroring to root matters: once the root contains your content, it
doesn't matter which pipeline wins — both serve your changes. After pushing, confirm the active
deployment SHA equals your commit:
```bash
curl -s "https://api.github.com/repos/kvallespin/kvallespin.github.io/deployments?environment=github-pages&per_page=1" | grep -E '"sha"'
```

**Permanent fix (owner action, GitHub UI):** Settings → Pages → Source = **"GitHub Actions"**.
That disables the branch builder so only `deploy.yml` (the `public/` artifact) serves the site,
and the root copy + mirroring step become unnecessary. Until the owner does this, keep mirroring.
Do **not** try to fix it by editing `.github/workflows/deploy.yml` — that's off-limits.

## Fonts (FreeSans) are case-sensitive

`quartz/styles/custom.scss` declares FreeSans via `@font-face` and forces it via `:root`
(`--bodyFont/--headerFont/--codeFont`) plus a big `font-family: "FreeSans" … !important` rule
covering `article` and friends. The font files on disk and in git are **lowercase**:
`/assets/fonts/freesans.ttf`, `freesansbold.ttf`, `freesansoblique.ttf`, `freesansboldoblique.ttf`.
GitHub Pages (Linux) is case-sensitive, so the `@font-face` `url(...)` values **must be lowercase**.
If they're capitalized (`FreeSans.ttf`), the font 404s and the site falls back to Arial/system —
which looks like a "serif/system font" bug. Verify after deploy:
```bash
curl -s -o /dev/null -w '%{http_code}\n' "https://kvallespin.github.io/assets/fonts/freesans.ttf"   # expect 200
```
Never embed fonts as base64 or inside SVG — the @font-face + lowercase files are the supported path.

## Red / colored inline notes

Raw HTML passes through Quartz, so colored text works with an inline span, e.g.
`<span style="color: red">Originally posted on June 18, 2019.</span>`. Quartz normalizes the
output to `style="color:red;"`, so verify with a grep for `color:red`. (This is the one
sanctioned use of an inline style — it's intentional content, not leftover blog cruft.)

## CDN caching

Served pages carry `Cache-Control: max-age=600`. A fresh deploy normally purges, but edges can
lag. When verifying, append a cache-buster (`?cb=$RANDOM`) and poll. If the CSS hash didn't
change (content-only edit), don't wait on a hash change — poll for a changed asset or the new
text instead.
