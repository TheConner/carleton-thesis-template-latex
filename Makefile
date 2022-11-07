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

clean:
	rm -f *.log *.out *.idx *.glo *.blg *.bbl *.aux $(PACKAGE).cls $(PACKAGE).ins $(PDF)