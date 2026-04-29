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

- **Markdown → HTML:** Pandoc with `--standalone` and `style.css`. The local Makefile additionally passes `--embed-resources` so `output/cv.html` is self-contained; the CI workflow does not, so the GitHub Pages copy references `style.css` separately.
- **HTML → PDF:** WeasyPrint reads the generated HTML and the same `style.css`. `style.css` therefore drives both screen and print rendering — it includes a `@media print` block for page-break and font-size tweaks. Edits to typography or layout must be checked in both outputs.
- **Layout quirks:** the profile/links header in `cv_markdown.md` is a raw HTML `<table>` (Pandoc passes it through). The "Current Role" label above the top job entry is a Markdown blockquote that `style.css` restyles into a small uppercase tag — it is not a quotation.

## CI / deployment

`.github/workflows/build-cv.yml` runs on push to `main` **only when `cv_markdown.md` or `style.css` change**. Edits to the Makefile, README, or workflow itself will not trigger a rebuild — use `workflow_dispatch` from the Actions tab to force one. The workflow uploads `output/` as an artifact and publishes to the `gh-pages` branch (GitHub Pages source must be set to that branch in repo settings).
