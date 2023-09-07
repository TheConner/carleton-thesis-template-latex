PACKAGE=cu-thesis
PDF = $(PACKAGE).pdf
.PHONY: clean

all: ${PDF} ${PACKAGE}.cls

%.pdf: %.dtx $(PACKAGE).cls
	pdflatex $<
	- bibtex $*
	pdflatex $<
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done

%.cls: %.dtx
	pdflatex $< 
	makeindex -s gind.ist $*.idx
	makeindex -s gglo.ist $*.glo -o $*.gls
	pdflatex $< 

clean:
	rm -f *.log *.out *.idx *.glo *.blg *.bbl *.aux *.acn *.fdb_latexmk *.fls *.ist *.lof *.lot *.toc $(PACKAGE).cls $(PACKAGE).ins $(PDF)