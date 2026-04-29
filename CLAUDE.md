# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build commands

Local builds require `pandoc` and `weasyprint` (`brew install pandoc weasyprint`).

- `make` — build both HTML and PDF into `output/`
- `make html` — HTML only
- `make pdf` — PDF only (depends on HTML)
- `make clean` — remove `output/`

## Architecture

Single-source CV pipeline. `cv_markdown.md` is the only content file; everything else is presentation or tooling.

- **Markdown → HTML:** Pandoc with `--standalone` and `style.css`. Title is passed via `--metadata pagetitle=...` (not `title=`) so it sets only the browser tab and does not render a duplicate visible heading above the H1. The local Makefile additionally passes `--embed-resources` so `output/cv.html` is self-contained; the CI workflow does too.
- **HTML → PDF:** WeasyPrint reads the generated HTML and the same `style.css`. `style.css` therefore drives both screen and print rendering — it includes a `@media print` block for page-break and font-size tweaks. Edits to typography or layout must be checked in both outputs.
- **Layout intent:** the canonical CV is human-facing, not optimized for ATS — the user maintains a separate simplified version for ATS submissions. The header uses a raw HTML `<table>` (Pandoc passes it through) with two cells of `width: auto` so Profile/Links size to their content rather than splitting 50/50. Every Experience and Education entry uses the same shape: `### dates · org` followed by `*role/degree · location*` and a bullet list. Keep new entries in that shape so the H3/italic/bullet styling in `style.css` applies uniformly.

## CI / deployment

`.github/workflows/build-cv.yml` runs on push to `main` **only when `cv_markdown.md` or `style.css` change**. Edits to the Makefile, README, or workflow itself will not trigger a rebuild — use `workflow_dispatch` from the Actions tab to force one. The workflow uploads `output/` as an artifact and publishes to the `gh-pages` branch (GitHub Pages source must be set to that branch in repo settings).
