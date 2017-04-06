DOCUMENT := 'Main'
TIMESTAMP := $(shell date '+%Y-%m-%d--%H-%M-%S')

default:
	@pdflatex $(DOCUMENT)

lua:
	@lualatex $(DOCUMENT)

xetex:
	@xelatex $(DOCUMENT)

clean:
	@rm -f $(DOCUMENT).aux
	@rm -f $(DOCUMENT).log
	@rm -f $(DOCUMENT).toc
	@rm -f $(DOCUMENT).pdf

snapshot:
	@cp $(DOCUMENT).pdf snapshots/$(DOCUMENT)--$(TIMESTAMP).pdf
