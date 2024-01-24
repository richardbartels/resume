TEXFILE="cv.tex"
AUXFILE="cv.aux"
echo $TEXFILE

pdflatex -interaction nonstopmode -halt-on-error -file-line-error $TEXFILE &&\
bibtex $AUXFILE &&\
pdflatex -interaction nonstopmode -halt-on-error -file-line-error $TEXFILE &&\
pdflatex -interaction nonstopmode -halt-on-error -file-line-error $TEXFILE

rm *.aux
rm *.log
rm *.out
rm *.blg
rm *.gz*