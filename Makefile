#############################################################################
# Makefile to convert an IPython Notebook to a PDF, applying a bit of cleaning
# transformations to the TeX file specified in a companion Pyton script
# (replace.py).
#############################################################################

# Specify here the name of the target PDF file.
# Note Remember to escape any spaces in the file name!

PDF=IPython\ 2013\ Progress\ Report\ -\ Sloan\ Foundation.pdf

#############################################################################
# You shouldn't need to configure anything below.

# This should work with the pattern rules at the end, but it isn't, don't know
# why. I hate debugging makefile rule problems, so here it's just brue-forced.Fix
$(PDF): $(PDF:pdf=ipynb)
	ipython nbconvert --to latex "$<"
	./replace.py "$(<:ipynb=tex)"
	pdflatex "$(<:ipynb=tex)"
	pdflatex "$(<:ipynb=tex)"

clean:
	rm -f $(PDF:pdf=tex) $(PDF:pdf=aux) $(PDF:pdf=log) $(PDF:pdf=out) *~

cleanall: clean
	rm -f $(PDF)


# Pattern rules. FIXME: for some reason these aren't working. No time to debug.

# Make pdf out of tex source, run pdflatex twice.
.tex.pdf:
	pdflatex "$<"
	pdflatex "$<"

# Make cleaned up tex file from ipynb sources
.ipynb.tex:
	ipython nbconvert --to latex "$<"
	./replace.py "$@"

