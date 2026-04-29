# curriculum-vitae

Markdown-based CV with automated HTML and PDF generation.

The source of truth is a single Markdown file (`cv_markdown.md`). A custom CSS stylesheet (`style.css`) handles layout and typography. Pandoc converts the Markdown to HTML, and WeasyPrint renders that to a print-ready PDF.

## Repo structure

```
curriculum-vitae/
├── cv_markdown.md          # CV content — edit this
├── style.css               # Layout and typography
├── Makefile                # Local build commands
├── images/                 # Profile picture and other assets
├── output/                 # Generated files (git-ignored)
└── .github/
    └── workflows/
        └── build-cv.yml    # GitHub Actions: auto-build on push
```

## Local setup

Install dependencies via Homebrew:

```bash
brew install pandoc weasyprint
```

Then build:

```bash
make          # builds both HTML and PDF → output/
make html     # HTML only
make pdf      # PDF only (requires HTML to exist)
make clean    # removes the output/ directory
```

Output files land in `output/cv.html` and `output/cv.pdf`. The `output/` directory is git-ignored.

## GitHub Actions

On every push to `main` that touches `cv_markdown.md` or `style.css`, the workflow automatically builds both files and uploads them as a workflow artifact. You can download the artifact from the **Actions** tab in GitHub.

To also host the HTML version as a GitHub Page:
1. Uncomment the deploy step at the bottom of `.github/workflows/build-cv.yml`
2. In GitHub: **Settings → Pages → Source → GitHub Actions**

## Sharing

- **PDF**: download from the Actions artifact after any push, or build locally with `make`
- **HTML**: host via GitHub Pages (see above), or just share the raw HTML file
- **Markdown source**: link directly to `cv_markdown.md` on GitHub for plain-text viewing
