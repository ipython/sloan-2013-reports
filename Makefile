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

all: $(PDF)

clean:
	rm -f $(PDF) $(PDF:pdf=tex) $(PDF:pdf=aux ) $(PDF:pdf=log) \
		$(PDF:pdf=out) *~ 

# Pattern rules

# Make cleaned up tex file from ipynb sources
%.tex : %.ipynb
	ipython nbconvert --to latex "$<"
	./replace.py "$<"

# Make pdf out of tex source, run pdflatex twice.
%.pdf : %.tex
	pdflatex "$<"
	pdflatex "$<"
