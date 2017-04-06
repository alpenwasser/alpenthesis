DOCUMENT := example
TIMESTAMP := $(shell date '+%Y-%m-%d--%H-%M-%S')

default:
	@pdflatex -shell-escape $(DOCUMENT)

lua:
	@lualatex -shell-escape $(DOCUMENT)

xetex:
	@xelatex -shell-escape $(DOCUMENT)

clean:
	@rm -f $(DOCUMENT).aux
	@rm -f $(DOCUMENT).ctr
	@rm -f $(DOCUMENT).log
	@rm -f $(DOCUMENT).out
	@rm -f $(DOCUMENT).pdf
	@rm -f $(DOCUMENT).toc
	@rm -rf _minted-$(DOCUMENT)


snapshot:
	@cp $(DOCUMENT).pdf snapshots/$(DOCUMENT)--$(TIMESTAMP).pdf
