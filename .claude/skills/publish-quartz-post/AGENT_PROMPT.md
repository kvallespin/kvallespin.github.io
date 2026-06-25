# Portable agent prompt — publishing on kvallespin.github.io

Paste the block below to any coding agent that doesn't have the `publish-quartz-post` skill.
It is self-contained.

---

You are publishing/updating a post on my **Quartz v5** site at `C:/Users/kenne/kvallespin.github.io`.
Follow this exact approach; it encodes pitfalls that have bitten us before.

**Non-negotiables**

- NEVER edit `.github/workflows/deploy.yml`.
- NEVER `git push` unless I explicitly tell you to. Building locally is always fine.
- Do not publish private/PII material. Treat credential/ID documents as sensitive.

**Two pitfalls that make "successful" deploys do nothing**

1. GitHub Pages serves the **repo ROOT**, not `public/`. A built copy of the site is committed
   at the root and the branch builder serves it. After `npx quartz build` you MUST mirror the
   fresh `public/` into the repo root (replace top-level built files/dirs; delete orphaned old
   hashed `index-*.css`/`component-*.css`/`prescript-*.js`/`postscript-*.js`; leave source dirs
   like `content/`, `quartz/`, `node_modules/`, `.claude/` untouched). Otherwise the live site
   doesn't change. (A dual-deploy race also exists; mirroring to root makes the winner irrelevant.)
2. FreeSans fonts are lowercase at `/assets/fonts/freesans*.ttf` and Pages is case-sensitive.
   The `@font-face` `url(...)` values in `quartz/styles/custom.scss` must be lowercase or the
   site silently falls back to a system font. Never embed fonts as base64 or in SVG.

**Content cleaning rules (HTML→Markdown leaves a mess)**

- Strip `<br>`, inline `style=`, `font-family`, `text-align`, `wp-block`, `aligncenter`.
- Merge hard-wrapped lines into continuous paragraphs; keep headings, lists, blockquotes, fenced
  code, images, and `---` on their own lines.
- Put each image on its own line (blank lines around it) with an _italic_ caption paragraph below.
  Block images center via CSS; inline ones don't.
- Fix bare-paren URLs `(https://…)` → `[here](https://…)`, space-before-punctuation, empty `****`,
  PDF-viewer junk ("Page 1 / 3 Zoom 100%"), and dangling truncated words. Collapse blank lines.
- Remove all "Pinoy P.E." / "pinoype" branding ("Filipino" is fine, "Pinoy" is not).

**Images & PII**

- Each `content/engineering/assets/<folder>/import-manifest.json` lists the assets blessed for
  publication. Only reference images that resolve to a real file; update the manifest (with a
  `note`) when you add/restore/redact one.
- Originals are in `C:/Users/kenne/OneDrive/Website Backup/.../<post>_files/`. Before republishing
  any credential/ID document, LOOK at it and redact PII (date of birth, personal email, ID/license
  numbers, home address) with opaque black rectangles (PIL). Public-record license numbers may stay.
  After deploy, re-fetch the LIVE image and confirm the served copy is the redacted one.

**Obsidian vault mirror**

- The same posts live at `C:/KVault Prime/Public Web/Engineering/<Display Name>.md` with a parallel
  `assets/<folder>/`. Copy the cleaned Markdown AND any new/changed assets there, using the SAME
  relative `assets/...` paths. Confirm the vault `.md` is identical to the Quartz `.md`.

**Build → mirror → (commit → push only if asked) → verify**

1. `cd /c/Users/kenne/kvallespin.github.io && npx quartz build`
2. Mirror `public/` into the repo root (see pitfall #1).
3. Stage source + `git add -f public/` + the root built files + any deletions. Don't stage
   `.tmp_*` scratch files. Commit messages end with:
   `Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`
4. Push only with explicit permission.
5. Verify LIVE (poll through the CDN with `?cb=$RANDOM`): each page returns 200; every
   `/assets/fonts/freesans*.ttf` returns 200; the active `github-pages` deployment SHA equals your
   commit; served HTML has no `pinoy` / `_files/` / `text-align:center|justify`; image counts are
   right; redacted images verified live.

If anything in the deploy behaves oddly (live content not updating, deployment SHA going
backwards), it's the root-vs-public / dual-deploy issue above — mirror to root and re-verify rather
than editing the workflow. The permanent fix is for me to set Pages Source = "GitHub Actions" in
the GitHub UI; remind me if it keeps recurring.
