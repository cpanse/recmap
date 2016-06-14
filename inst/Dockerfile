FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>

RUN apt-get update && apt-get install ssh -y \
  && echo "install.packages(c('doParallel', 'GA'))" | R --no-save \
  && cd /tmp/ \
  && ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts \
  && git clone git@github.com:cpanse/recmap.git \
  && R CMD build recmap \
  && R CMD INSTALL recmap*gz \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ /tmp/recmap*
  
  
  
