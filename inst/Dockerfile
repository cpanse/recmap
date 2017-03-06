FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>
RUN R -e "install.packages(pkgs=c('devtools'), quiet=FALSE, repos='https://stat.ethz.ch/CRAN/', type='source'); library(devtools); install_git('https://github.com/cpanse/recmap', build_vignettes = TRUE, quiet = FALSE)" 

#RUN apt-get update \
#  && apt-get install git -y \
#  && git clone https://github.com/cpanse/recmap.git \
#  && R CMD build --no-build-vignettes recmap \
#  && R CMD INSTALL recmap_*gz;
