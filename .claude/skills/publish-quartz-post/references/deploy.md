# Deploy model

## What serves the live site

GitHub Pages for this repo is configured as **"GitHub Actions"**. The `deploy.yml` workflow
runs on every push to `main`:

1. Checks out the repo (`fetch-depth: 0`)
2. Installs Node (v22) via `setup-node` + `npm ci`
3. Runs `npx quartz plugin install --from-config` → clones community plugins into `.quartz/plugins/`
4. Runs `npx quartz build` → produces `public/`
5. Uploads `public/` as the Pages artifact
6. Deploys via `actions/deploy-pages`

**There is no branch builder.** The root of the repo is never served. Only the CI-built
`public/` artifact is live.

→ **After editing source under `content/`, just push. CI handles everything.**
No local build required, no mirroring to root, no `git add -f public/`.

## Community plugin architecture

This repo uses the Quartz community plugin system. Plugins are configured in `quartz.config.yaml`
under the `plugins:` key as `source: github:quartz-community/<name>` entries. The plugin source
code lives at `.quartz/plugins/<name>/` but is **gitignored** — `.quartz/` is in `.gitignore`.

On CI (and locally if needed), plugins are installed by:
```bash
npx quartz plugin install --from-config
```

This reads `quartz.config.yaml`, clones each enabled plugin from its GitHub repo via
`isomorphic-git` (pure HTTPS, no system git auth needed), and writes the source into
`.quartz/plugins/<name>/`. The Quartz build (`npx quartz build`) then bundles those plugins
via esbuild alongside the rest of the site.

**Critical rules:**
- Never commit `.quartz/plugins/*` contents. They are large, externally versioned, and
  CI reinstalls them fresh on every run.
- Never use `npm run install-plugins` on CI. That script runs with raw `tsx`, which cannot
  handle `.scss` imports in the Quartz import chain and will crash with
  `ERR_UNKNOWN_FILE_EXTENSION ".scss"`. Always use the Quartz CLI:
  `npx quartz plugin install --from-config`.
- If git ever records any `.quartz/plugins/<name>` directory as a gitlink (mode 160000)
  with no corresponding `.gitmodules` entry, that is a corruption bug. Fix it with:
  ```bash
  git rm --cached .quartz/plugins/<name>
  git commit -m "fix: dereference gitlink for .quartz/plugins/<name>"
  ```
  CI will re-clone the plugin on the next push.

## What NOT to commit

- **`public/`** — in `.gitignore`, and untracked. CI regenerates it fresh on every push.
- **`.quartz/plugins/*`** — gitignored. CI clones them fresh via `quartz plugin install`.
- **Root build artifacts** — `index.html`, `404.html`, `component-*.css`, `data-science/`,
  `tags/`, etc. were legacy mirror artifacts from the old branch-builder pattern. They are
  gone from the repo. Do not re-add them.

If you run `npx quartz build` locally (for preview only), the output stays in `public/` and
is ignored by git. Do not `git add -f public/` or `cp -R public/. .`.

## Fonts (FreeSans) — case-sensitivity

`quartz/styles/custom.scss` declares FreeSans with lowercase `url()` paths:
`/assets/fonts/freesans.ttf`, `freesansbold.ttf`, `freesansoblique.ttf`,
`freesansboldoblique.ttf`.

The source font files are at `content/assets/fonts/` and **must be lowercase** to match.
Quartz copies them to `public/assets/fonts/` during build; GitHub Pages (Linux) is
case-sensitive, so a capital `FreeSans.ttf` vs `freesans.ttf` means a silent font 404 and
the site falls back to a system font.

Current state: all four font files in `content/assets/fonts/` are lowercase ✓.
Do not rename them to mixed-case.

Verify after any deploy:
```bash
curl -s -o /dev/null -w '%{http_code}\n' "https://kvallespin.github.io/assets/fonts/freesans.ttf"
# expect 200
```

## Inline colored text

Raw HTML passes through Quartz, so colored spans work:
`<span style="color: #E04556;">text</span>` (cerise red for academic program names).
Quartz normalizes to `style="color:#E04556;"` — verify with grep on the built HTML.

## CDN caching

Pages carries `Cache-Control: max-age=600`. A fresh CI deploy normally purges, but edges can
lag. When verifying, append `?cb=$RANDOM` and poll. The deployment is live once the Actions
run shows green and the SHA at
`https://api.github.com/repos/kvallespin/kvallespin.github.io/deployments?environment=github-pages&per_page=1`
matches your commit.
