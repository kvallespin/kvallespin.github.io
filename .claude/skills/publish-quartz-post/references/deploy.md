# Deploy model

## What serves the live site

GitHub Pages for this repo is configured as **"GitHub Actions"**. The `deploy.yml` workflow
runs on every push to `main`:

1. Checks out the repo
2. Installs Node (v22) via `setup-node` + `npm ci`
3. Runs `npx quartz build` â†’ produces `public/`
4. Uploads `public/` as the Pages artifact
5. Deploys via `actions/deploy-pages`

**There is no branch builder.** The root of the repo is never served. Only the CI-built
`public/` artifact is live.

â†’ **After editing source under `content/`, just push. CI handles the build.**
No local build required, no mirroring to root, no `git add -f public/`.

## What NOT to commit

- **`public/`** â€” in `.gitignore`, and untracked. CI regenerates it fresh on every push.
- **Root build artifacts** â€” `index.html`, `404.html`, `component-*.css`, `data-science/`,
  `tags/`, etc. were legacy mirror artifacts from the old branch-builder pattern. They are
  gone from the repo. Do not re-add them.

If you run `npx quartz build` locally (for preview only), the output stays in `public/` and
is ignored by git. Do not `git add -f public/` or `cp -R public/. .`.

## Fonts (FreeSans) â€” case-sensitivity

`quartz/styles/custom.scss` declares FreeSans with lowercase `url()` paths:
`/assets/fonts/freesans.ttf`, `freesansbold.ttf`, `freesansoblique.ttf`,
`freesansboldoblique.ttf`.

The source font files are at `content/assets/fonts/` and **must be lowercase** to match.
Quartz copies them to `public/assets/fonts/` during build; GitHub Pages (Linux) is
case-sensitive, so a capital `FreeSans.ttf` vs `freesans.ttf` means a silent font 404 and
the site falls back to a system font.

Current state: all four font files in `content/assets/fonts/` are lowercase (after the fix).
Do not rename them to mixed-case.

Verify after any deploy:
```bash
curl -s -o /dev/null -w '%{http_code}\n' "https://kvallespin.github.io/assets/fonts/freesans.ttf"
# expect 200
```

## Inline colored text

Raw HTML passes through Quartz, so colored spans work:
`<span style="color: #E04556;">text</span>` (cerise red for academic program names).
Quartz normalizes to `style="color:#E04556;"` â€” verify with grep on the built HTML.

## CDN caching

Pages carries `Cache-Control: max-age=600`. A fresh CI deploy normally purges, but edges can
lag. When verifying, append `?cb=$RANDOM` and poll. The deployment is live once the Actions
run shows green and the SHA at
`https://api.github.com/repos/kvallespin/kvallespin.github.io/deployments?environment=github-pages&per_page=1`
matches your commit.
