FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>

RUN apt-get install -y --no-install-recommends \
  ssh \
  | R --no-save \
  echo "install.packages(c('doParallel', 'GA'))" \
  && cd /tmp/ \
  && git clone git@github.com:cpanse/recmap.git \
  && R CMD build recmap \
  && R CMD INSTALL recmap*gz
  
  
  
