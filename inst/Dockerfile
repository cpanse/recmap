FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>
RUN R -e "install.packages(pkgs=c('devtools'), quiet=FALSE, repos='https://stat.ethz.ch/CRAN/', type='source'); \
    library(devtools); \
    install_git('https://github.com/cpanse/recmap', build_vignettes = TRUE, quiet = FALSE)" 
