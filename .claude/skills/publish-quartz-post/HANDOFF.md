# Handoff notes for Borges (Ken's AI Chief of Staff)

Operational notes from the prior maintainer that complement `SKILL.md` and
`BORGES_AGENT_PROMPT.md`. Read these before your first publish.

## Current state (as of this handoff)

- Live posts `/engineering/unlocking-the-pe` and `/engineering/unlocking-the-apec-engineer`
  are clean: FreeSans loads, images centered, the NCEES credential doc is redacted, no
  "Pinoy" branding. Last verified-live commit: `1fe8cf9`.
- Both engineering posts also have a red "_Originally posted on …_" note — that's a
  **migration** convention; brand-new posts don't need it.

## The gap you will hit first: authoring vs. publishing

The skill grew out of _cleaning and shipping existing_ posts. _Authoring a new post from
notes_ needs three extra things the rest of the workflow assumes already exist:

1. Complete front matter.
2. **A link in the section index** (`content/engineering/index.md`) — every published post
   needs one and it's the easiest step to forget.
3. A local preview before anything goes public (`npx quartz build --serve`).
   See "Authoring a new post from notes" in `SKILL.md` / `BORGES_AGENT_PROMPT.md` for the steps.
   For a first demo, pick a short note with **no PII** and use a throwaway slug you can delete.

## Gotchas that cost real time

- **Deploy looks successful but live doesn't change / SHA goes backward** → the dual-deploy
  race. Cure: re-run `scripts/mirror_to_root.sh`, recommit, repush, re-verify. Never debug
  `deploy.yml`.
- **"Serif/system font" look** → FreeSans 404'd because an `@font-face` URL wasn't lowercase
  `freesans*.ttf`. Pages is case-sensitive.
- **After redacting a document, re-fetch the LIVE image and look at it.** Local correctness is
  not proof the redacted file shipped.
- `import-manifest.json` in each asset folder is the source of truth for what's publishable —
  keep it current (add a `note` for restored/redacted assets).
- Windows Python has no `/tmp` (use a real temp dir); git's CRLF warnings are harmless; never
  stage `.tmp_*` scratch or temp image dirs.

## Etiquette

- **Push only with Ken's explicit OK.** Building/committing locally is fine.
- **Ask before publishing anything involving a PII judgment call.**
- **Never edit `.github/workflows/deploy.yml`.**
- The one permanent fix that retires the root-mirroring dance is **Ken** setting
  GitHub → Settings → Pages → Source = "GitHub Actions". You can't do it; remind him.
