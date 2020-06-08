BASEDIR=/Users/richardbartels/Documents/Projects/resume
TEXFILE="cv.tex"
AUXFILE="cv.aux"
echo $TEXFILE

docker build -t miktex/miktex docker

docker run -it -v $BASEDIR:/miktex/work miktex/miktex\
 sh -c "mpm --admin --install=fontawesome5 &&\
  mpm --admin --update &&\
   initexmf --mkmaps &&\
    pdflatex -interaction nonstopmode -halt-on-error -file-line-error $TEXFILE &&\
     bibtex $AUXFILE &&\
      pdflatex -interaction nonstopmode -halt-on-error -file-line-error $TEXFILE &&\
       pdflatex -interaction nonstopmode -halt-on-error -file-line-error $TEXFILE"

rm *.aux
rm *.log
rm *.out
rm *.blg
rm *.gz*