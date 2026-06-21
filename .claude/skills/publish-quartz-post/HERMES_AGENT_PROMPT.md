# Detailed prompt for the Hermes agent — publishing on kvallespin.github.io

Hand the entire block below (everything under the `=== BEGIN PROMPT ===` line) to Hermes.
It assumes no prior context and includes exact commands. It is written for a capable coding
agent with shell access on Kenneth's Windows machine.

=== BEGIN PROMPT ===

## Role

You are maintaining and publishing posts on a **Quartz v5** static website,
`https://kvallespin.github.io`. The git repo is at `C:/Users/kenne/kvallespin.github.io`.
Work carefully and verify the LIVE result — this site has two non-obvious failure modes
(described below) that make a "successful" build/push silently do nothing.

## Environment & tools you need

- Shell: Git Bash (POSIX paths like `/c/Users/...`) and/or PowerShell. Commands below use Bash.
- `node` + `npx` (Quartz builds with `npx quartz build`).
- `git` (the repo's remote is GitHub; default branch is `main`).
- `python` with **Pillow (PIL)** for image redaction (`python -c "import PIL"` should succeed;
  if not, `pip install pillow`).
- `curl` for live verification.

## Hard rules (do not violate)

1. **NEVER edit `.github/workflows/deploy.yml`.**
2. **NEVER `git push` unless Kenneth explicitly tells you to in this task.** Building and even
   committing locally is fine, but pushing is the only thing that changes the public site, so it
   requires explicit go-ahead.
3. **Protect privacy.** Never publish personal PII. Treat any credential/ID/exam document as
   sensitive and redact it (see "Images & PII"). When a privacy trade-off is genuinely Kenneth's
   call, ask before publishing.
4. **No "Pinoy P.E." / "pinoype" / "pinoype.com" branding** may appear in any published post
   (the site was migrated off that old blog). The word "Filipino" is fine; "Pinoy" is not.
5. Do not embed fonts as base64 or inside SVG.

## Repo map

- Posts (Markdown + YAML front matter): `content/<section>/<slug>.md`
  - e.g. `content/engineering/unlocking-the-pe.md`, `content/engineering/unlocking-the-apec-engineer.md`
- Per-post images: `content/engineering/assets/<asset-folder>/`
  - e.g. `assets/pe-journey/...`, `assets/apec-engineer/...`
  - Each folder has `import-manifest.json` = the record of which images are blessed for publication.
- Styles/fonts: `quartz/styles/custom.scss` (FreeSans `@font-face` + `:root` vars + `!important` rule).
- Build output: `public/` (Quartz writes here).
- **Committed built site at the repo ROOT** (`index.html`, hashed `index-*.css`, `engineering/*.html`,
  `assets/`, `CNAME`, etc.) — this is what GitHub Pages serves. See pitfall #1.
- Obsidian vault copies: `C:/KVault Prime/Public Web/Engineering/<Display Name>.md` + parallel `assets/`.
- Original old-blog backup (for migrations/image restores):
  `C:/Users/kenne/OneDrive/Website Backup/<Title> – Pinoy P.E.htm` and matching `..._files/` folders.
- A ready-made skill with helper scripts: `.claude/skills/publish-quartz-post/` (you may read/use
  `scripts/mirror_to_root.sh`, `scripts/verify_live.sh`, `scripts/redact.py`).

## THE TWO PITFALLS (read before deploying anything)

**Pitfall 1 — Pages serves the repo ROOT, not `public/`.**
GitHub Pages is set to "Deploy from a branch", so the branch builder serves the committed build
at the **repo root**. `public/` is only Quartz's output dir. If you rebuild `public/` and push
without copying it to the root, **the live site does not change.** There is also a dual-deploy
race (the Actions workflow and the Pages branch app both deploy; a stale queued run can win and
appear to roll the site backward). Mirroring the build into the root makes the race irrelevant —
whichever pipeline wins, the root has your content. **So after every build you MUST mirror
`public/` into the repo root.**

**Pitfall 2 — FreeSans is case-sensitive on Pages.**
The font files are lowercase: `/assets/fonts/freesans.ttf`, `freesansbold.ttf`,
`freesansoblique.ttf`, `freesansboldoblique.ttf`. GitHub Pages (Linux) is case-sensitive, so the
`@font-face` `url(...)` values in `quartz/styles/custom.scss` must be **lowercase**. If they're
capitalized, the font 404s and the whole site falls back to a system/serif font. If you ever see
that symptom, check the case in `custom.scss` and verify the live font returns 200.

(Permanent fix that only Kenneth can do: GitHub → Settings → Pages → Source = "GitHub Actions".
That retires the root copy and the mirroring step. Until he does it, keep mirroring. Never try to
fix this by editing the workflow file.)

## Procedure

### A. Edit / clean the Markdown

Open the target post under `content/<section>/`. Apply these cleaning rules (the old content came
from HTML→Markdown conversion and is messy):

- Remove stray `<br>`, `<br/>`, and any inline `style=`, `font-family`, `text-align`, `wp-block`,
  or `aligncenter`. The site forces FreeSans + left-aligned text via CSS; inline styles fight it.
- Merge hard-wrapped lines so each paragraph is one continuous line. **Keep on their own lines**
  (with blank lines around them): headings (`##`/`###`), list items (`-`, `1.`), blockquotes (`>`),
  fenced code blocks, images, and horizontal rules (`---`).
- Put every image on its own line, blank lines around it, followed by an *italic* caption
  paragraph, e.g.:
  ```
  ![](assets/pe-journey/review-rig.jpg)

  *My Typical Review Rig*
  ```
  (Block images get centered by CSS; inline images do not. Don't wrap a caption that already
  contains bold/italic in more emphasis.)
- Fix conversion artifacts: bare-paren URLs `(https://x)` → `[here](https://x)`; remove space
  before punctuation left by `**bold**`/links; delete empty `****`; delete PDF-viewer junk like
  `Page 1 / 3 Zoom 100%`; fix dangling truncated words.
- Collapse runs of blank lines to a single blank line.
- Remove any leftover "Pinoy P.E."/"pinoype" branding.
- Leave existing (sometimes odd) section numbering as-is unless asked to renumber — it's content.
- Colored inline notes are allowed via raw HTML, e.g.
  `<span style="color: red">Originally posted on June 18, 2019.</span>` (Quartz passes raw HTML
  through; it renders as `style="color:red;"`). This is the only sanctioned inline style.

Front matter: keep the existing shape (`title`, `description`, `tags` including `public-web`,
`source: website-backup`, `created`). Don't invent dates; for an "originally posted" date, pull it
from the backup HTML's entry metadata (earliest date in the post header = published date).

### B. Images, the manifest, and PII

- Only reference images that resolve to a real file in the asset folder. Quick check from
  `content/engineering`:
  ```bash
  grep -oE '!\[\]\(assets/[^)]+\)' <slug>.md | sed -E 's/!\[\]\((.*)\)/\1/' | \
    while read p; do [ -f "$p" ] || echo "MISSING: $p"; done
  ```
- When you add or restore an image, copy the source into the asset folder with a descriptive
  kebab-case name and add an entry to `import-manifest.json` (include a `"note"` for restored or
  redacted assets). Originals live in the backup `..._files/` folder at several resolutions —
  prefer a large web size (`-1024…` or `-768x1024`, or the full file).
- **PII redaction is mandatory for credential/ID documents.** Before publishing one, open and look
  at it, then black out date of birth, personal email, government/exam/license ID numbers, home
  address, and signatures. Use the helper:
  ```bash
  # 1) inspect size + dump header/footer crops to measure where the text sits:
  python .claude/skills/publish-quartz-post/scripts/redact.py inspect SOURCE.jpg /tmp/insp
  #    (view /tmp/insp/header.png and /tmp/insp/footer.png to read pixel coordinates)
  # 2) draw opaque boxes (x0,y0,x1,y1 per region) and save to the asset folder:
  python .claude/skills/publish-quartz-post/scripts/redact.py redact SOURCE.jpg \
    content/engineering/assets/pe-journey/<name>.jpg \
    --box 365,145,505,182 --box 655,108,1115,150 --box 48,1568,300,1616
  ```
  License numbers that are already public record (verifiable via the state rosters the post links
  to) may remain. **After deploying, re-fetch the LIVE image and confirm the served copy is the
  redacted one** — never trust the local file alone for privacy.

### C. Mirror to the Obsidian vault

```bash
cp content/engineering/<slug>.md "/c/KVault Prime/Public Web/Engineering/<Display Name>.md"
# copy any new/changed assets too, keeping the same relative paths:
cp content/engineering/assets/<folder>/<file> "/c/KVault Prime/Public Web/Engineering/assets/<folder>/<file>"
# confirm identical markdown:
diff -q content/engineering/<slug>.md "/c/KVault Prime/Public Web/Engineering/<Display Name>.md"
```

### D. Build, then mirror to root

```bash
cd /c/Users/kenne/kvallespin.github.io
npx quartz build
bash .claude/skills/publish-quartz-post/scripts/mirror_to_root.sh
```
If you can't use the script, mirror manually: delete the root's old hashed files
(`rm -f ./index-*.css ./component-*.css ./prescript-*.js ./postscript-*.js`), then for each
top-level entry in `public/`, replace it at the repo root (`rm -rf ./DIR && cp -r public/DIR ./DIR`
for directories; `cp -f public/FILE ./FILE` for files). Never touch source dirs (`content/`,
`quartz/`, `.quartz/`, `node_modules/`, `.claude/`, configs) — they aren't in `public/`.

### E. Commit (and push only if explicitly authorized)

```bash
cd /c/Users/kenne/kvallespin.github.io
git add content/ quartz/ .claude/
git add -f public/
git add 404.html CNAME favicon.ico index.html index.xml sitemap.xml profile.html \
        index-og-image.webp profile-og-image.webp \
        index-*.css component-*.css prescript-*.js postscript-*.js \
        assets data-science design engineering finance projects reviewers static tags
# stage deletions of orphaned old root build files:
git status -s | grep -E '^ D ' | grep -vE 'public/' | sed -E 's/^ D //' | while read -r f; do git add -- "$f"; done
# Do NOT stage .tmp_* scratch files.
git commit -m "Describe the change

Co-Authored-By: Hermes <noreply@example.com>"
# Only if Kenneth said to publish:
git push origin main
```

### F. Verify the LIVE site

```bash
bash .claude/skills/publish-quartz-post/scripts/verify_live.sh engineering/<slug>
```
Or manually, polling through the CDN (append `?cb=$RANDOM`):
- Each page returns `200`.
- `https://kvallespin.github.io/assets/fonts/freesans.ttf` returns `200`.
- The active deployment SHA equals your commit:
  ```bash
  curl -s "https://api.github.com/repos/kvallespin/kvallespin.github.io/deployments?environment=github-pages&per_page=1" | grep -E '"sha"'
  git rev-parse HEAD
  ```
- Served HTML has NO `pinoy`, `_files/`, or `text-align:center|justify`.
- Image counts are correct; any redacted image is verified by re-fetching it live.
- If the CSS changed, the previous `index-<oldhash>.css` now returns `404`.

GitHub Pages can take 30–120s and is CDN-cached; poll until the new build appears. If the live
content won't update or the deployment SHA goes backward, that's the root-vs-public / dual-deploy
issue — re-run the mirror-to-root step, re-commit, re-push (if authorized), and re-verify. Do not
edit the workflow.

## When to stop and ask Kenneth

- A document exposes PII and it's unclear whether to skip, redact, or publish as-is.
- The change would touch `.github/workflows/deploy.yml` or repo Pages settings.
- You're unsure whether you're allowed to push.
- A live verification check keeps failing after a correct mirror+push.

=== END PROMPT ===
