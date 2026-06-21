---
name: publish-quartz-post
description: >-
  Authoritative workflow for creating, cleaning, and publishing posts on the
  kvallespin.github.io Quartz site (content/engineering and other sections).
  Use this skill whenever the task involves adding, editing, fixing, migrating,
  or publishing any post/page on this site; rebuilding or deploying it; touching
  fonts/styles in quartz/styles/custom.scss; migrating content from the old
  "Website Backup" HTML; managing post images/assets; or mirroring content to the
  Obsidian vault. Trigger even if the user just says "publish my post", "fix the
  rendering", "update the PE/APEC entry", "rebuild the site", or "the page looks
  broken" — the site has non-obvious deploy and font pitfalls that this skill
  exists to prevent. Do NOT use for unrelated repos or non-Quartz sites.
---

# Publishing posts on kvallespin.github.io

This site is a **Quartz v5** static site. The repo is at `C:/Users/kenne/kvallespin.github.io`.
This skill encodes the hard-won, authoritative way to clean, build, and ship a post
without breaking fonts, images, or the live deploy. Follow it in order.

## The two things that will bite you (read first)

1. **GitHub Pages serves the repo ROOT, not `public/`.** A built copy of the site is
   committed at the repo root (`index.html`, `index-*.css`, `engineering/*.html`, `assets/`,
   `CNAME`, …) and the branch builder serves *that*. `public/` is just Quartz's build output.
   If you only rebuild `public/` and push, **the live site does not change.** You must mirror
   the fresh build into the repo root every time. See `references/deploy.md`.

2. **FreeSans is case-sensitive on Pages.** The font files are lowercase
   (`/assets/fonts/freesans*.ttf`). The `@font-face` URLs in `quartz/styles/custom.scss`
   must match that lowercase exactly, or the whole site silently falls back to a system font.

Two standing constraints from the owner: **never edit `.github/workflows/deploy.yml`**, and
**never `git push` unless the user explicitly asks** (building locally is always fine).

## Workflow

### 1. Understand the change and locate files
- Posts: `content/engineering/<slug>.md` (front matter + Markdown). Other sections exist too
  (`content/<section>/`). Assets per post: `content/engineering/assets/<asset-folder>/`.
- If migrating from the old blog, the source HTML + images are under
  `C:/Users/kenne/OneDrive/Website Backup/...` — see `references/migration.md`.

### 2. Clean the Markdown
Apply these rules (they reflect how HTML-to-Markdown conversion mangles things):
- Remove stray `<br>` / `<br/>` and any inline `style=`, `font-family`, `text-align`,
  `wp-block`, `aligncenter` markers. The site forces FreeSans and left-aligned text via CSS;
  inline styles only fight it.
- Merge hard-wrapped lines so each paragraph is one continuous line, but **preserve** block
  elements on their own lines: headings (`##`), list items (`-`, `1.`), blockquotes (`>`),
  fenced code, images, and `---` rules.
- Pull every image onto its own line with blank lines around it, followed by an *italic*
  caption paragraph (e.g. `*My Typical Review Rig*`). Block images get centered by CSS;
  inline images don't. Don't wrap a caption that already contains bold/italic.
- Fix conversion artifacts: bare-paren URLs `(https://…)` → real links `[here](https://…)`;
  space-before-punctuation left by `**bold**`/links; empty `****`; PDF-viewer junk like
  `Page 1 / 3 Zoom 100%`; dangling truncated words.
- Collapse multiple blank lines to one.
- **No "Pinoy P.E." / "pinoype" / "pinoype.com" branding** may remain (the migration strips it).
  "Filipino" is fine; "Pinoy" is not (a verify grep checks for it).
- Leave the existing (sometimes odd) section numbering as-is unless asked — that's content.

### 3. Handle images and PII — the manifest is the source of truth
Every asset folder has an `import-manifest.json` listing each `published_name` blessed for
publication. **Only reference images that resolve to a real file in the folder.** When you add
or restore images, update the manifest (with a `note` for restored/redacted ones).

Originals that were excluded during migration usually contained PII. Before republishing any
credential/ID document, **inspect it** (read the image) and redact sensitive data — date of
birth, personal email, ID/license numbers, home address — with opaque black rectangles
(`scripts/redact.py` uses PIL). After deploying, **re-fetch the LIVE image and confirm the
served copy is the redacted one** — never trust the local file alone for privacy. License
numbers that are already public record (state rosters the post links to) may stay.

See `references/migration.md` for the full asset-restore + redaction procedure.

### 4. Mirror to the Obsidian vault
The same posts live in the vault at `C:/KVault Prime/Public Web/Engineering/` with display-name
filenames (`Unlocking the P.E..md`, `Unlocking the APEC Engineer.md`) and a parallel
`assets/<folder>/`. Copy the cleaned Markdown **and any new/changed assets** there, keeping the
**same relative `assets/...` paths** (both vault and Quartz resolve them). Verify the vault copy
is byte-identical to the Quartz copy.

### 5. Build
```bash
cd /c/Users/kenne/kvallespin.github.io && npx quartz build
```
Then sanity-check the output in `public/` (image counts, no forbidden strings) before deploying.

### 6. Deploy = build + **mirror to root** + commit + push (only if asked)
This is the step everyone forgets. After `npx quartz build`:
```bash
bash .claude/skills/publish-quartz-post/scripts/mirror_to_root.sh
```
Then stage source + root + `public/`, commit, and (only with explicit permission) push:
```bash
git add content/ quartz/ .claude/
git add -f public/
git add 404.html CNAME favicon.ico index.html index.xml sitemap.xml profile.html \
        index-og-image.webp profile-og-image.webp \
        index-*.css component-*.css prescript-*.js postscript-*.js \
        assets data-science design engineering finance projects reviewers static tags
# stage deletions of orphaned old root build files:
git status -s | grep -E '^ D ' | grep -vE 'public/' | sed -E 's/^ D //' | while read -r f; do git add -- "$f"; done
git commit -m "…"   # end with the required Co-Authored-By trailer
git push origin main
```
Do **not** stage `.tmp_*` migration scratch files. Full details + the dual-deploy race in
`references/deploy.md`.

### 7. Verify the LIVE site
GitHub Pages has a CDN; poll until the new build is served, then check it:
```bash
bash .claude/skills/publish-quartz-post/scripts/verify_live.sh engineering/<slug> …
```
Confirm: pages return **200**; `freesans.ttf` returns **200**; the active deployment SHA matches
your commit; image counts are right; and there are **no** `pinoy` / `_files/` / `text-align:center`
strings in the served HTML. For any redacted image, re-fetch it live and eyeball the redaction.
The full checklist is `references/checklist.md`.

## Reference files
- `references/deploy.md` — the root-vs-public model, dual-deploy race, font case, exact commands.
- `references/migration.md` — cleaning old HTML backups, manifest discipline, PII redaction.
- `references/checklist.md` — copy/paste pre-publish + post-deploy verification checklist.

## Scripts
- `scripts/mirror_to_root.sh` — copy the fresh `public/` build into the repo root (what Pages serves).
- `scripts/verify_live.sh` — poll + verify live URLs, fonts, forbidden strings, active deploy SHA.
- `scripts/redact.py` — draw opaque rectangles over PII regions of an image (PIL).
