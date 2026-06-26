# Handoff to Hermes — kvallespin.github.io deploy model

Hermes, this is a full briefing on Ken's personal site so you can publish posts without
breaking the live site. Read this before touching anything in `C:/Users/kenne/kvallespin.github.io`.

## What the site is

A **Quartz v5** static site at `https://kvallespin.github.io`. Source is Markdown under
`content/`. The site is built by GitHub Actions and deployed to GitHub Pages on every push to
`main`. Ken's content sections are `engineering/`, `data-science/`, `finance/`, `design/`,
`projects/`, and `profile/`.

## The deploy pipeline (understand this first)

GitHub Pages source is set to **"GitHub Actions"** — the branch builder is disabled. The
workflow at `.github/workflows/deploy.yml` runs on every push to `main` and does exactly this:

1. `actions/checkout@v4` with `fetch-depth: 0`
2. `git config --global --add safe.directory "$GITHUB_WORKSPACE"`
3. `actions/setup-node@v4` with Node v22 (from `.node-version`)
4. `npm ci`
5. `npx quartz plugin install --from-config` — clones community plugins into `.quartz/plugins/`
6. `npx quartz build` — produces `public/`
7. Upload `public/` as the Pages artifact
8. Deploy via `actions/deploy-pages`

**Push source, CI builds everything.** You never need to run the build locally to ship.
Never commit `public/`, root HTML artifacts, or plugin source code.

## What you must never do

- **Never `git push` unless Ken explicitly asks.** Editing content locally is always safe.
- **Never commit `.quartz/plugins/*`.** That directory is gitignored. CI clones plugins fresh
  on every run via `npx quartz plugin install --from-config`. If git ever starts tracking
  a `.quartz/plugins/<name>` directory as a gitlink (mode 160000), that is a bug — fix it
  with `git rm --cached .quartz/plugins/<name>` and commit the removal.
- **Never use `npm run install-plugins` on CI** (or suggest it). That script uses raw `tsx`
  which crashes on `.scss` imports with `ERR_UNKNOWN_FILE_EXTENSION`. The correct command
  is `npx quartz plugin install --from-config` (Quartz CLI, uses esbuild, handles SCSS).
- **Never rename font files to mixed-case.** `content/assets/fonts/` must contain
  `freesans.ttf`, `freesansbold.ttf`, `freesansoblique.ttf`, `freesansboldoblique.ttf`
  (all lowercase). GitHub Pages is Linux and case-sensitive. A capital `FreeSans.ttf`
  silently 404s and the entire site loses its custom font.
- **Never stage build artifacts.** After `git add`, only files under `content/`, `quartz/`,
  `.claude/`, or `.github/` should appear in `git status`. If you see `public/`, `index.html`,
  `404.html`, `component-*.css`, or section directories at root, unstage them:
  `git restore --staged public/ 404.html index.html component-*.css`

## Publishing a post — step by step

**1. Write or place the Markdown file**
`content/<section>/<slug>.md` with front matter:
```yaml
---
title: <Human Title>
description: <one-line SEO summary>
tags:
  - <section>
created: <YYYY-MM-DD>
---
```

**2. Add it to the section index** (easy to forget):
Open `content/<section>/index.md` and add `- [[<slug>|<Human Title>]]`

**3. Clean the Markdown** (applies to migrated HTML content especially):
- No inline `style=`, `font-family`, `text-align`, `<br>`, `wp-block`, `aligncenter` — CSS
  handles all of that globally.
- Each paragraph is one continuous line; block elements (headings, lists, code, images,
  `---`) get their own lines.
- Every image on its own line with blank lines above and below, followed by an italic caption:
  `*Caption text*`
- Fix bare URLs: `(https://...)` becomes `[link text](https://...)`
- Link every named institution/org to its official URL at first mention. Verify via web
  search — never guess.
- Strip any "Pinoy P.E." / "pinoype" / "pinoype.com" references — those are old branding.

**4. Visual style is automatic.** The KV design system (Cerise `#E04556`, Deep Teal, FreeSans,
sentence-case, no cards/gradients) is global CSS. New posts inherit it. For inline accent
color: `<span style="color: #E04556;">text</span>`.

**5. Preview locally (optional):**
```bash
cd C:/Users/kenne/kvallespin.github.io
npx quartz build --serve
```
Browse http://localhost:8080. Kill the server before running the build again.

**6. Stage and commit source only (only when Ken asks to push):**
```bash
git add content/ quartz/ .claude/ .github/
git commit -m "publish: <short description>"
git push origin main
```

**7. Verify after CI completes (~1 min):**
- `https://kvallespin.github.io/<section>/<slug>` returns 200
- `https://kvallespin.github.io/assets/fonts/freesans.ttf` returns 200
- Check `https://github.com/kvallespin/kvallespin.github.io/actions` for a green run

## Images and PII

Every `content/<section>/assets/<folder>/` has an `import-manifest.json` listing published
filenames. Only reference images in that manifest. Before republishing any credential or ID
document, redact sensitive fields (DOB, personal email, ID numbers, address) using
`scripts/redact.py`, then re-fetch the live URL after deploy to confirm the redacted copy
is what's served.

## Where to find the full rules

The authoritative skill is at `.claude/skills/publish-quartz-post/SKILL.md` in the repo.
Reference docs are in `.claude/skills/publish-quartz-post/references/`:
- `deploy.md` — full CI pipeline, plugin architecture, font rules, CDN tips
- `migration.md` — HTML-to-Markdown migration, manifest discipline, PII redaction
- `kv-design-system.md` — visual tokens, layout rules, component patterns
- `checklist.md` — pre-push and post-deploy verification checklist

## History that explains why the rules are what they are

The site previously ran a dual-pipeline: a branch builder served the repo root, and GitHub
Actions served `public/`. This caused race conditions where stale root artifacts overrode
fresh CI builds, making pushed content invisible. That pipeline was eliminated. The branch
builder is disabled, root artifacts are untracked, and CI is the single source of truth.

The `.quartz/plugins/` community plugin directories were once accidentally committed as git
gitlinks (submodule-like pointers with no `.gitmodules` file). This broke CI with
`git exit code 128` errors. They were dereferenced, removed from git tracking, and the
workflow now installs them cleanly via `npx quartz plugin install --from-config`.
