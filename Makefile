TEXFILE = cv.tex
AUXFILE = cv.aux
PDFFILE = cv.pdf

BASEDIR=$(CURDIR)
OUTPUTDIR=$(BASEDIR)/output

GITHUB_PAGES_BRANCH=gh-pages

help:
	@echo 'Makefile for automatic LaTeX compilation                                  '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make clean                          remove the generated files         '
	@echo '   make build	                        generate files										 '
	@echo '   make github                         upload the web site via gh-pages   '
	@echo '                                                                          '


clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

build:
	mkdir $(OUTPUTDIR)
	sudo docker run -it -v $(BASEDIR):/opt/qpdf-6.0.0 texlive\
	 sh -c "tlmgr update --self --all &&\
	  tlmgr install pdfescape letltxmacro bitset parskip etoolbox &&\
	   pdflatex $(TEXFILE) &&\
	    bibtex $(AUXFILE) &&\
	     pdflatex $(TEXFILE) &&\
	      pdflatex $(TEXFILE)"
	mv $(PDFFILE) $(OUTPUTDIR)
	cp CNAME $(OUTPUTDIR)
	cp index.html $(OUTPUTDIR)

github:
	ghp-import -n $(OUTPUTDIR)
	@git push -fq https://${GH_TOKEN}@github.com/$(TRAVIS_REPO_SLUG).git gh-pages > /dev/null

.PHONY: help clean build github
