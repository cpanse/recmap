FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>
RUN echo "install.packages(c('doParallel', 'GA', 'Rcpp', 'knitr', \
'testthat', 'maps', 'shapefile'))" \ 
  | R --no-save \
  && apt-get update \
  && apt-get install git -y \
  && git clone https://github.com/cpanse/recmap \
  && R CMD build --no-build-vignettes recmap \
  && R CMD INSTALL recmap_*gz;
