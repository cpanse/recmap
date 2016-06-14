FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>

RUN echo "install.packages(c('recmap', 'doParallel', 'GA'))" \
| R --no-save \
&& cd /tmp/ \
&& git@github.com:cpanse/recmap.git \
&& R CMD build recmap 
&& R CMD INSTALL recmap*gz
