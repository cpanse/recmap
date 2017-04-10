[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/recmap)](https://cran.r-project.org/package=recmap)
[![](https://images.microbadger.com/badges/image/cpanse/recmap.svg)](http://microbadger.com/images/cpanse/recmap "Get your own image badge on microbadger.com")
[![Research software impact](http://depsy.org/api/package/cran/recmap/badge.svg)](http://depsy.org/package/r/recmap)

# recmap - Compute the Rectangular Statistical Cartogram

This package contains an implementation of the [RecMap construction algorithm (MP2)](http://dx.doi.org/10.1109/INFVIS.2004.57).


## Installation


### from [CRAN](https://CRAN.R-project.org/package=recmap)

`recmap` requires R 3.3 or later.

Released and tested versions of `recmap` are available via the 
[CRAN](https://CRAN.R-project.org/package=recmap) network, 
and can be installed using the R shell via

```{r}
install.package('recmap')
```

### from [github](https://github.com/cpanse/recmap)

install the latest development version

```{r}
install.packages('devtools')
library(devtools)
install_git('https://github.com/cpanse/recmap', build_vignettes = TRUE, quiet = FALSE)
library(recmap)
```

### Use the docker public | automated build [recmap image](https://hub.docker.com/r/cpanse/recmap/) 

this image contains the latest build.

```{bash}
docker pull cpanse/recmap \
&& docker run -d -p 8791:8787 cpanse/recmap
```

connect to http://yourdockerhost:8791  using a web browser

* username: rstudio
* password: rstudio


## Documentation

The package ships with a package vignette (`browseVignettes('recmap')` 
and a reference manual (just type `?recmap` on the R shell).

Both documents are also available on the package's [CRAN](https://CRAN.R-project.org/package=recmap) page.

A white paper containing more technical information and examples is
available through [arXiv:1606.00464](https://arxiv.org/abs/1606.00464).

## Demonstration

```{r}
# Requires to install suggested  packages
# install.packages(c('colorspace', 'maps', 'noncensus', 'shiny'))

library(colorspace)
library(maps)
library(shiny)
library(recmap)
library(noncensus)

recmap_state.x77 <- system.file("shiny-examples", "state.x77", package = "recmap")
shiny::runApp(recmap_state.x77, display.mode = "normal")

recmap_US.county <- system.file("shiny-examples", "US.county", package = "recmap")
shiny::runApp(recmap_US.county, display.mode = "normal")
```

# Related approaches

* [cartogram](https://CRAN.R-project.org/package=cartogram)
* [Rcartogram](https://github.com/omegahat/Rcartogram)
* see also [CRAN Task View: Analysis of Spatial Data](https://CRAN.R-project.org/view=Spatial)
