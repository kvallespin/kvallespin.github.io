# Migrating & restoring content from the old blog

## Source of truth

Old blog saves live in `C:/Users/kenne/OneDrive/Website Backup/`:
- `Unlocking the P.E. – Pinoy P.E.htm` + `Unlocking the P.E. – Pinoy P.E_files/`
- `Unlocking the APEC Eng. – Pinoy P.E.htm` + `…_files/`
- (and other posts)

The `_files/` folder holds every original image at multiple resolutions
(`name-300x169.jpg`, `name-768x...jpg`, `name.jpg`, …) plus junk (32-hex-named spacers, emoji
SVGs, logos). For a content image, prefer a large web-friendly size (the `-1024…` / `-768x1024`
variant, or the full file if reasonable).

## Mapping images to placement

To rebuild a post faithfully, extract the **document-order sequence of images and their
captions** from the HTML and place each where its `<figcaption>` indicates. A quick way:
```python
import re, html
data = open(HTML, encoding='utf-8', errors='ignore').read()
for m in re.finditer(r'(<img[^>]+_files/([^"?]+)")|(<figcaption[^>]*>(.*?)</figcaption>)', data, re.I|re.S):
    if m.group(2): print("IMG", m.group(2))
    elif m.group(4): print("CAP", html.unescape(re.sub(r'<[^>]+>','',m.group(4))).strip())
```
Ignore hashed/emoji/logo/sidebar images; keep the article-body ones.

## The manifest

Each `content/engineering/assets/<folder>/import-manifest.json` records every published asset:
```json
{ "source_name": "pe-cert_ky-1024x791.jpg", "published_name": "pe-certificate-2.jpg", "bytes": 171727 }
```
Add a `"note"` field for restored or redacted assets (e.g. `"restored 2026-06-21 with DOB,
email, and NCEES ID redacted"`). The manifest is how future sessions know what's intentionally
public — keep it accurate. Only reference `published_name`s that exist on disk.

## PII redaction (mandatory for credential/ID documents)

Migration intentionally excludes documents with personal data. If the owner asks to restore one,
**look at it first** (read the image) and identify sensitive fields before publishing:
- date of birth, personal email, government IDs, exam/registration IDs, home address,
  signatures, anything that aids identity theft.
- License numbers that are already public record (verifiable via the state rosters the post
  links to) may stay — note that judgment call.

Redact with opaque rectangles using `scripts/redact.py` (PIL). To get exact pixel boxes, crop the
header/footer regions and view them, measure, then draw generous boxes. After deploying,
**re-fetch the live image and confirm the served copy is redacted** — local correctness is not
proof the right file shipped.

When the privacy call is genuinely the owner's (e.g. "this exposes your DOB — skip / redact /
publish as-is?"), ask before publishing rather than guessing.

## Front matter

Keep existing front matter shape: `title`, `description`, `tags` (include `public-web`),
`source: website-backup`, `created`. Don't invent dates — if you need an original-post date, pull
it from the backup HTML's entry metadata (the earliest date in the post's header block is the
published date; a slightly later one is "modified").
