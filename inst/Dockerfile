FROM rocker/geospatial
MAINTAINER Christian Panse <Christian.Panse@gmail.com>
RUN install2.r --error \ 
  GA \
  colorspace  \
  doParallel \
  knitr \
  maps \
  noncensus \
  shiny \
  testthat 
RUN apt-get install curl && cd /tmp \
 && curl -s https://codeload.github.com/cpanse/recmap/zip/master \
 > recmap.zip && unzip recmap.zip \
 && R CMD build recmap-master --no-build-vignettes \
 && R CMD INSTALL recmap*.gz 
