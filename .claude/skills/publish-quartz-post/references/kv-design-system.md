# KV design system — apply to every post and page

From this point forward, all posts and pages on this site follow the **KV design
system** (Kenneth Vallespin's brand/visual system). Source of truth for the vault
spec: `C:/KVault Prime/Design/KV Design System/KV Design System.md`. This file is the
**web** distillation — what to do in Quartz.

## Principles (the short version)

- **Lines over boxes.** Hairlines, rules, and a 6px Cerise marker bar do the work —
  not borders, cards, gradients, or drop shadows. Default radius is 0.
- **One identity color.** Cerise Red marks the single most important thing. If
  everything is red, nothing is.
- **Structure is blue.** Deep Teal carries titles, links, and table rules.
- **Sentence case.** Titles/headings read like sentences. No Title Case, no ALL CAPS
  except short eyebrows. No emoji. No taglines/slogans on the landing page — the home
  hero is **name + post-nominals only**.
- **Restraint + whitespace.** Soft White canvas, never pure black/white.

## Tokens (mirror of the vault spec; defined in `quartz/styles/custom.scss` `:root`)

| Token              | Hex       | Role                                             |
| ------------------ | --------- | ------------------------------------------------ |
| `--kv-cerise`      | `#e04556` | identity · markers · the one thing that matters  |
| `--kv-deep-teal`   | `#175676` | titles · links · table header rule (light mode)  |
| `--kv-sky`         | `#4ba3c3` | dark-mode lift for teal text so it stays legible |
| `--kv-coral`       | `#e8676a` | dark-mode link hover                             |
| `--kv-pale-ice`    | `#cee5f3` | the only soft fill (insight callouts)            |
| `--kv-slate`       | `#475461` | body/secondary text — never black                |
| `--kv-medium-gray` | `#7f7f7f` | captions · descriptions                          |
| `--kv-hairline`    | `#d2d2d2` | hairline rules / row dividers                    |

## How it's implemented (already in `custom.scss`)

You usually don't touch this — it's global CSS, so **every post inherits KV automatically.**
The relevant blocks, all near the bottom of `quartz/styles/custom.scss`:

- **All article content** (`.page article …`): links Deep Teal → Cerise hover; headings
  Deep Teal; `h2` gets a 6px Cerise marker bar; `hr` → hairline; blockquote → Deep Teal
  edge; tables → Deep Teal 2px header rule + hairline row dividers.
- **Dark mode** (`[saved-theme="dark"] …`): teal text lifts to Sky, hover to Coral, so
  nothing goes dark-on-dark. Always sanity-check a new visual element in dark mode.
- **Home landing** (`.center:has(.home-hero) …`): hero is name + nominals with a Cerise
  marker bar (no card); duplicate page title/meta and right-rail TOC hidden; the "Browse
  by domain" list is hairline rows with Cerise markers. See `deploy.md`-style `:has()` scoping.
- **Section/parent pages**: the duplicate body `# Title` is removed (the page already has a
  title from front matter); the auto `.page-listing` is hidden (scoped by
  `body[data-slug="<section>/index"]`) so the curated "Notes" list is the single source.
- **The "originally posted" note** uses class `kv-date-note` (Cerise), not inline `color: red`.

## Applying it to a NEW post (what you actually do)

- Nothing extra for visuals — write normal Markdown and the global KV CSS styles it.
- Keep headings **sentence case**. Use the `kv-date-note` class for any "originally posted" note.
- If you add a _new section page_, remove the duplicate body `# Title`, keep a curated
  "Notes"/list, and add its slug to the `.page-listing` hide rule in `custom.scss`.
- New visual elements: build them from lines/markers in the KV tokens, and check dark mode.

## Scope status (2026-06-21)

Applied globally; verified on Unlocking the APEC Engineer, Unlocking the P.E., and the
FINMA202 reviewer, plus the Engineering and Projects parent pages. The other section pages
(finance, data-science, design, reviewers) get the global CSS but still have a duplicate
body `# Title` + visible auto-listing — align them the same way when touched.
