CLASSNAME := alpenthesis
EXAMPLE := example

default:
	@latex $(CLASSNAME).ins
	@pdflatex -shell-escape $(CLASSNAME).dtx
	@mv $(CLASSNAME).pdf $(CLASSNAME)-en.pdf
	@pdflatex -shell-escape $(CLASSNAME)-de.tex
	@cp $(CLASSNAME).cls ../
	@pdflatex -shell-escape $(EXAMPLE)

# Preserve PDF documents, template and class file.
# This is what we might want to hand to an end user.
tidy:
	@rm -f $(CLASSNAME).aux
	@rm -f $(CLASSNAME).glo
	@rm -f $(CLASSNAME).idx
	@rm -f $(CLASSNAME).log
	@rm -f $(CLASSNAME).dvi
	@rm -f $(CLASSNAME).tex
	@rm -f $(CLASSNAME).out
	@rm -f $(CLASSNAME).toc
	@rm -rf _minted-$(CLASSNAME)
	@rm -rf _minted-$(EXAMPLE)
	@rm -rf _minted-$(CLASSNAME)-de
	@rm -f $(EXAMPLE).aux
	@rm -f $(EXAMPLE).ctr
	@rm -f $(EXAMPLE).log
	@rm -f $(EXAMPLE).out
	@rm -f $(EXAMPLE).toc
	@ if [ -f $(CLASSNAME)-de.pdf ];then cp $(CLASSNAME)-de.pdf bak.$(CLASSNAME)-de.pdf;fi
	@rm -f $(CLASSNAME)-de.*
	@ if [ -f bak.$(CLASSNAME)-de.pdf ]; then mv bak.$(CLASSNAME)-de.pdf $(CLASSNAME)-de.pdf;fi

# Remove everything but .dtx and .ins:
clean: tidy
	@rm -f $(CLASSNAME)-en.pdf
	@rm -f $(CLASSNAME)-de.pdf
	@rm -f $(CLASSNAME).cls
	@rm -f $(EXAMPLE).*
