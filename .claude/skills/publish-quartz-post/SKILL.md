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
  broken" â€” the site has non-obvious deploy and font pitfalls that this skill
  exists to prevent. Do NOT use for unrelated repos or non-Quartz sites.
---

# Publishing posts on kvallespin.github.io

This site is a **Quartz v5** static site. The repo is at `C:/Users/kenne/kvallespin.github.io`.
This skill encodes the hard-won, authoritative way to clean, build, and ship a post
without breaking fonts, images, or the live deploy. Follow it in order.

## The things that will bite you (read first)

1. **CI builds the site â€” never commit build artifacts.** GitHub Pages is set to
   **"GitHub Actions"** as the source. On every push to `main`, the `deploy.yml` workflow
   installs Node, runs `npx quartz build`, and deploys `public/` as the Pages artifact.
   **Do not** run `cp -R public/. .`, `git add -f public/`, or add root-level HTML/CSS/JS
   build output to git. The old `mirror_to_root.sh` script is retired. Committing build
   artifacts to root or to `public/` has no effect on the live site and creates staleness bugs.
   Edit source under `content/`, push, and CI ships it.

2. **FreeSans font files in `content/assets/fonts/` must stay lowercase.** The `@font-face`
   declarations in `quartz/styles/custom.scss` reference `/assets/fonts/freesans.ttf`,
   `freesansbold.ttf`, etc. (all lowercase). Quartz copies from `content/assets/fonts/` to
   `public/assets/fonts/` during build. GitHub Pages (Linux) is case-sensitive â€” a capital
   `FreeSans.ttf` silently 404s and the whole site falls back to a system font.
   Current filenames are correct (lowercase). Do not rename them.

One standing constraint from the owner: **never `git push` unless the user explicitly asks.**
Editing content and building locally is always fine.

## Workflow

### 1. Understand the change and locate files

- Posts: `content/<section>/<slug>.md` (front matter + Markdown).
- Assets per post: `content/<section>/assets/<asset-folder>/`.
- If migrating from the old blog, the source HTML + images are under
  `C:/Users/kenne/OneDrive/Website Backup/...` â€” see `references/migration.md`.

### 2. Clean the Markdown

Apply these rules (they reflect how HTML-to-Markdown conversion mangles things):

- Remove stray `<br>` / `<br/>` and any inline `style=`, `font-family`, `text-align`,
  `wp-block`, `aligncenter` markers. The site forces FreeSans and left-aligned text via CSS;
  inline styles only fight it.
- Merge hard-wrapped lines so each paragraph is one continuous line, but **preserve** block
  elements on their own lines: headings (`##`), list items (`-`, `1.`), blockquotes (`>`),
  fenced code, images, and `---` rules.
- Pull every image onto its own line with blank lines around it, followed by an _italic_
  caption paragraph (e.g. `*My Typical Review Rig*`). Block images get centered by CSS;
  inline images don't. Do not wrap a caption that already contains bold/italic.
- Fix conversion artifacts: bare-paren URLs `(https://...)` to real links `[here](https://...)`;
  space-before-punctuation left by `**bold**`/links; empty `****`; PDF-viewer junk like
  `Page 1 / 3 Zoom 100%`; dangling truncated words.
- Collapse multiple blank lines to one.
- **Link institutions to their official URL.** Every named institution / company / org / group /
  entity gets hyperlinked to its official site at first mention (`[**Name**](https://...)`).
  **Verify each URL via web search â€” never guess one.** Use the org own homepage; for a
  defunct entity, link its Wikipedia page. Skip people and generic concepts/instruments.
- **No "Pinoy P.E." / "pinoype" / "pinoype.com" branding** may remain (the migration strips it).
  "Filipino" is fine; "Pinoy" is not (a verify grep checks for it).
- Leave the existing (sometimes odd) section numbering as-is unless asked â€” that is content.

### 3. Handle images and PII â€” the manifest is the source of truth

Every asset folder has an `import-manifest.json` listing each `published_name` blessed for
publication. **Only reference images that resolve to a real file in the folder.** When you add
or restore images, update the manifest (with a `note` for restored/redacted ones).

Originals that were excluded during migration usually contained PII. Before republishing any
credential/ID document, **inspect it** (read the image) and redact sensitive data â€” date of
birth, personal email, ID/license numbers, home address â€” with opaque black rectangles
(`scripts/redact.py` uses PIL). After deploying, **re-fetch the LIVE image and confirm the
served copy is the redacted one** â€” never trust the local file alone for privacy. License
numbers that are already public record (state rosters the post links to) may stay.

See `references/migration.md` for the full asset-restore + redaction procedure.

### 4. Mirror to the Obsidian vault

The same posts live in the vault at `C:/KVault Prime/Public Web/Engineering/` with display-name
filenames (`Unlocking the P.E..md`, `Unlocking the APEC Engineer.md`) and a parallel
`assets/<folder>/`. Copy the cleaned Markdown **and any new/changed assets** there, keeping the
**same relative `assets/...` paths** (both vault and Quartz resolve them). Verify the vault copy
is byte-identical to the Quartz copy.

### 5. Local preview (optional but recommended for new posts)

```bash
cd /c/Users/kenne/kvallespin.github.io && npx quartz build --serve
```

Browse to http://localhost:8080. Kill the server before the next build â€” a running preview
server locks `public/` and causes EBUSY errors on Windows.

### 6. Deploy = commit source + push (only if asked)

CI builds and deploys automatically. You only need to commit source files:

```bash
git add content/ quartz/ .claude/ .github/
git commit -m "..."
git push origin main
```

**Do not** stage `public/`, root HTML, `component-*.css`, `data-science/`, `tags/`, `static/`,
`assets/` (root-level), or any other build artifact. A plain `git status` after staging should
show only files under `content/`, `quartz/`, `.claude/`, or `.github/`.

If `git status` shows unexpected build artifacts staged, unstage them:
```bash
git restore --staged public/ 404.html index.html component-*.css data-science/ tags/ static/
```

### 7. Verify the LIVE site

The CI workflow takes 2-3 minutes. Monitor at
`https://github.com/kvallespin/kvallespin.github.io/actions`. Then verify:

```bash
bash .claude/skills/publish-quartz-post/scripts/verify_live.sh <section>/<slug> ...
```

Confirm: pages return **200**; `freesans.ttf` returns **200**; the active deployment SHA matches
your commit; image counts are right; no `pinoy` / `_files/` / `text-align:center` in the HTML.
For any redacted image, re-fetch it live and eyeball the redaction.
The full checklist is `references/checklist.md`.

## Authoring a new post from notes (vs. editing an existing one)

1. Pick a section and a kebab-case slug: `content/<section>/<slug>.md`.
2. Write complete front matter:
   ```yaml
   ---
   title: <Human Title>
   description: <one-line summary for SEO/cards>
   tags:
     - engineering
     - public-web
   source: notes
   created: <YYYY-MM-DD>
   ---
   ```
3. Write the body applying the cleaning rules.
4. **Add a link to the section index** `content/<section>/index.md` (easy to forget).
5. Preview locally before pushing: `npx quartz build --serve`.

## Visual style â€” apply the KV design system

Every post and page follows the **KV design system** (lines over boxes, one Cerise accent
`#E04556`, Deep Teal structure, sentence-case, no cards/gradients/shadows, no taglines). This
is global CSS in `quartz/styles/custom.scss`, so a new post inherits it automatically.
Cerise red inline spans: `<span style="color: #E04556;">text</span>`.
Details, tokens, and the home/section-page patterns: `references/kv-design-system.md`.

## Reference files

- `references/deploy.md` â€” CI-only deploy model, what NOT to commit, font case rule, CDN tips.
- `references/migration.md` â€” cleaning old HTML backups, manifest discipline, PII redaction.
- `references/kv-design-system.md` â€” the KV visual system: tokens, rules, how it is applied here.
- `references/checklist.md` â€” copy/paste pre-publish + post-deploy verification checklist.

## Scripts

- `scripts/verify_live.sh` â€” poll + verify live URLs, fonts, forbidden strings, active deploy SHA.
- `scripts/redact.py` â€” draw opaque rectangles over PII regions of an image (PIL).
- `scripts/mirror_to_root.sh` â€” **RETIRED.** Do not use. The CI-build model makes this unnecessary.

## Portable agent prompts

- `AGENT_PROMPT.md` â€” generic, self-contained prompt for any agent that lacks this skill.
- `BORGES_AGENT_PROMPT.md` â€” the same procedure addressed to **Borges, Ken AI Chief of Staff**.
