# Makefile for local CV builds
# Requires: pandoc, weasyprint
# Install: brew install pandoc weasyprint

SRC     = cv_markdown.md
CSS     = style.css
OUTDIR  = output
HTML    = $(OUTDIR)/cv.html
PDF     = $(OUTDIR)/cv.pdf

.PHONY: all html pdf clean

all: html pdf

html: $(HTML)

pdf: $(PDF)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(HTML): $(SRC) $(CSS) | $(OUTDIR)
	pandoc $(SRC) \
		--from markdown \
		--to html5 \
		--standalone \
		--embed-resources \
		--css $(CSS) \
		--metadata pagetitle="Jelle van Elburg — CV" \
		--output $(HTML)
	@echo "✓ HTML written to $(HTML)"

$(PDF): $(HTML)
	weasyprint $(HTML) $(PDF) --stylesheet $(CSS)
	@echo "✓ PDF written to $(PDF)"

clean:
	rm -rf $(OUTDIR)
	@echo "✓ Cleaned output directory"
