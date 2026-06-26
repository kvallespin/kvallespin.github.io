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

## The things that will bite you (read first)

1. **CI builds the site — never commit build artifacts.** GitHub Pages is set to
   **"GitHub Actions"** as the source. On every push to `main`, the `deploy.yml` workflow
   installs Node, installs community plugins, runs `npx quartz build`, and deploys `public/`
   as the Pages artifact. **Do not** run `cp -R public/. .`, `git add -f public/`, or add
   root-level HTML/CSS/JS build output to git. The old `mirror_to_root.sh` script is retired.
   Committing build artifacts to root or to `public/` has no effect on the live site and
   creates staleness bugs. Edit source under `content/`, push, and CI ships it.

2. **FreeSans font files in `content/assets/fonts/` must stay lowercase.** The `@font-face`
   declarations in `quartz/styles/custom.scss` reference `/assets/fonts/freesans.ttf`,
   `freesansbold.ttf`, etc. (all lowercase). Quartz copies from `content/assets/fonts/` to
   `public/assets/fonts/` during build. GitHub Pages (Linux) is case-sensitive — a capital
   `FreeSans.ttf` silently 404s and the whole site falls back to a system font.
   Current filenames are correct (lowercase). Do not rename them.

3. **Community plugins live in `.quartz/plugins/` and are NOT committed to git.** This repo
   uses the Quartz community plugin system. Plugin source code is gitignored (`.quartz/` is
   in `.gitignore`) and cloned on-demand from `github:quartz-community/*` repos using
   `npx quartz plugin install --from-config`. The CI workflow runs this step explicitly before
   `npx quartz build`. **Never commit `.quartz/plugins/*` contents** — they are large,
   externally versioned, and CI handles the install. If git ever starts tracking any
   `.quartz/plugins/<name>` directory as a gitlink (mode 160000, no `.gitmodules`), that
   is a bug: run `git rm --cached .quartz/plugins/<name>` for each affected path to
   dereference it, then let CI re-clone them fresh. Do not use `npm run install-plugins`
   on CI — that script uses raw `tsx` which cannot handle `.scss` imports in the Quartz
   chain and will fail. The correct command is `npx quartz plugin install --from-config`,
   which goes through the Quartz CLI (esbuild) and handles SCSS correctly.

One standing constraint from the owner: **never `git push` unless the user explicitly asks.**
Editing content and building locally is always fine.

## Workflow

### 1. Understand the change and locate files

- Posts: `content/<section>/<slug>.md` (front matter + Markdown).
- Assets per post: `content/<section>/assets/<asset-folder>/`.
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
- Pull every image onto its own line with blank lines around it, followed by an _italic_
  caption paragraph (e.g. `*My Typical Review Rig*`). Block images get centered by CSS;
  inline images don't. Don't wrap a caption that already contains bold/italic.
- Fix conversion artifacts: bare-paren URLs `(https://...)` to real links `[here](https://...)`;
  space-before-punctuation left by `**bold**`/links; empty `****`; PDF-viewer junk like
  `Page 1 / 3 Zoom 100%`; dangling truncated words.
- Collapse multiple blank lines to one.
- **Link institutions to their official URL.** Every named institution / company / org / group /
  entity gets hyperlinked to its official site at first mention (`[**Name**](https://...)`).
  **Verify each URL via web search — never guess one.** Use the org's own homepage; for a
  defunct entity, link its Wikipedia page. Skip people and generic concepts/instruments.
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

### 5. Local preview (optional but recommended for new posts)

```bash
cd /c/Users/kenne/kvallespin.github.io && npx quartz build --serve
```

Browse to http://localhost:8080. Kill the server before the next build (`npx quartz build`
without `--serve`) — a running preview server locks `public/` and causes `EBUSY` errors.

### 6. Deploy = commit source + push (only if asked)

CI builds and deploys automatically. You only need to commit source files:

```bash
git add content/ quartz/ .claude/ .github/
git commit -m "..."   # end with the required Co-Authored-By trailer if applicable
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

The CI workflow takes ~1 minute. Monitor the Actions run at
`https://github.com/kvallespin/kvallespin.github.io/actions`. Then verify:

```bash
bash .claude/skills/publish-quartz-post/scripts/verify_live.sh <section>/<slug> ...
```

Confirm: pages return **200**; `freesans.ttf` returns **200**; the active deployment SHA matches
your commit; image counts are right; and there are **no** `pinoy` / `_files/` / `text-align:center`
strings in the served HTML. For any redacted image, re-fetch it live and eyeball the redaction.
The full checklist is `references/checklist.md`.

## Authoring a new post from notes (vs. editing an existing one)

The numbered workflow above assumes the prose already exists. When you're _creating_ a new post
from raw notes, do these first, then rejoin at step 4 (vault), 5 (preview), etc.:

1. Pick a section and a kebab-case slug → `content/<section>/<slug>.md`.
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
3. Write the body from the notes, applying the same cleaning rules (continuous paragraphs,
   block images with italic captions, real links, no inline styles, no "Pinoy"). The red
   "_Originally posted_" note is migration-only — skip it for fresh posts.
4. **Add a link to the section index** `content/<section>/index.md` (easy to forget):
   `- [[<slug>|<Human Title>]]`
5. Preview locally before pushing: `npx quartz build --serve` → http://localhost:8080.

## Visual style — apply the KV design system

Every post and page follows the **KV design system** (lines over boxes, one Cerise accent
`#E04556`, Deep Teal structure, sentence-case, no cards/gradients/shadows, no taglines). This
is global CSS in `quartz/styles/custom.scss`, so a new post inherits it automatically — just
write sentence-case Markdown and use the `kv-date-note` class for any "originally posted" note.
Cerise red inline spans: `<span style="color: #E04556;">text</span>`.
Details, tokens, and the home/section-page patterns: `references/kv-design-system.md`.

## Reference files

- `references/deploy.md` — CI-only deploy model, plugin install architecture, font case rule, CDN tips.
- `references/migration.md` — cleaning old HTML backups, manifest discipline, PII redaction.
- `references/kv-design-system.md` — the KV visual system: tokens, rules, how it's applied here.
- `references/checklist.md` — copy/paste pre-publish + post-deploy verification checklist.

## Scripts

- `scripts/verify_live.sh` — poll + verify live URLs, fonts, forbidden strings, active deploy SHA.
- `scripts/redact.py` — draw opaque rectangles over PII regions of an image (PIL).
- `scripts/mirror_to_root.sh` — **RETIRED.** Do not use. The CI-build model makes this unnecessary.

## Portable agent prompts

- `AGENT_PROMPT.md` — generic, self-contained prompt for any agent that lacks this skill.
- `BORGES_AGENT_PROMPT.md` — the same procedure addressed to **Borges, Ken's AI Chief of Staff**.
