# FM2 Reviewer Quartz Triage

## Current state

- Publication repository: `kvallespin/kvallespin.github.io`
- Local working copy: `C:/Users/kenne/kvallespin.github.io`
- Quartz source copied into the GitHub Pages repository.
- `quartz.config.yaml` uses `baseUrl: kvallespin.github.io`, correct for a user site repo.
- GitHub Actions deploy workflow is set to run on `main`.
- Local build succeeds.
- Local preview succeeds at `http://127.0.0.1:8120` while the preview process is running.

## Content status

The FM2 reviewer markdown was provided via Telegram/Hermes as:

`C:/Users/kenne/AppData/Local/hermes/cache/documents/doc_253369424eda_FINMA202_Oral_Exam_Reviewer.md`

It has been copied into Quartz as:

- `content/index.md`, so the reviewer appears at the site root
- `content/FINMA202_Oral_Exam_Reviewer.md`, so the named page also exists

Currency dollar signs were escaped where followed by digits so Quartz/KaTeX does not misread dollar amounts as inline math delimiters.

## Known local patch

Quartz v5 on this Windows setup failed to resolve extensionless imports from `../../.quartz/plugins`. Two imports were patched to use `../../.quartz/plugins/index`:

- `quartz/components/Head.tsx`
- `quartz/util/fileTrie.ts`

Local build was verified after this patch.

## Deployment checklist

- Confirm GitHub Pages source is set to GitHub Actions in the repository settings.
- Push the local `main` branch.
- Confirm the `Deploy Quartz site to GitHub Pages` workflow succeeds.
- Verify the public URL: `https://kvallespin.github.io/`
