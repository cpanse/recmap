FROM rocker/rstudio
MAINTAINER Christian Panse <Christian.Panse@gmail.com>

RUN echo "install.packages(c('doParallel', 'GA'))" \ 
  | R --no-save \
  && apt-get update \
  && apt-get install git ssh -y \
  && mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa \
  && chown -R root:root /root/.ssh \
  && touch /root/.ssh/known_hosts \
  && echo "Host github.com\n\tStrictHostKeyChecking no\n" \
  >> /root/.ssh/config \
  && git clone git@github.com:cpanse/recmap.git \
  && R CMD build --no-build-vignettes recmap \
  && R CMD INSTALL recmap_*gz;
  # clean up
  rm -rvf /root/.ssh/id_rsa /recmap*
   
   
