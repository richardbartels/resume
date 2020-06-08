TEXFILE = cv.tex
AUXFILE = cv.aux
PDFFILE = cv.pdf

BASEDIR=$(CURDIR)
OUTPUTDIR=$(BASEDIR)/output

GITHUB_PAGES_BRANCH=master

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
	sudo docker run -it -v $(BASEDIR):/miktex/work miktex/miktex\
	 sh -c "mpm --admin --install=fontawesome5 &&\
	  mpm --admin --update &&\&&\
	   pdflatex -interaction nonstopmode $(TEXFILE) &&\
	    bibtex $(AUXFILE) &&\
	     pdflatex -interaction nonstopmode $(TEXFILE) &&\
	      pdflatex -interaction nonstopbmode $(TEXFILE)"
	mv $(PDFFILE) $(OUTPUTDIR)
	cp index.html $(OUTPUTDIR)

github:
	ghp-import -n $(OUTPUTDIR)
	@git push -fq https://${GH_TOKEN}@github.com/$(TRAVIS_REPO_SLUG).git gh-pages > /dev/null

.PHONY: help clean build github
