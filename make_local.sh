BASEDIR=/Users/richardbartels/Documents/Projects/resume
TEXFILE="cv.tex"
AUXFILE="cv.aux"
echo $TEXFILE

docker build -t miktex/miktex docker

docker run -it -v $BASEDIR:/miktex/work miktex/miktex \
 sh -c "mpm --admin --install=fontawesome5 &&\
  mpm --admin --update &&\
   pdflatex -interaction nonstopmode $TEXFILE &&\
    bibtex $AUXFILE &&\
     pdflatex -interaction nonstopmode $TEXFILE &&\
      pdflatex -interaction nonstopbmode $TEXFILE"

rm *.aux
rm *.log
rm *.out
rm *.blg
rm *.gz*